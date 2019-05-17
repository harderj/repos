(ns bot)

(defn log
    [arg]
    (.println *err* (pr-str arg))
    arg)

(defn send-command
    [command]
    (println command))

(defn parse
    [state line]
    ; (bot/log line)
    (if (or (empty? line) (= \# (first line)))
        state
        (let [parts            (clojure.string/split line #" ")
              [[handler args]] (for [s    [2 1]
                                    :let  [name   (clojure.string/replace (clojure.string/join "_" (take s parts)) "/" "_")
                                          handler (find-var (symbol (str "handlers/" name)))
                                          args    (drop s parts)]
                                    :when handler]
                                    [handler args])]
            (if (nil? handler)
                (throw (Exception. (str "Don't recognize: " line)))
                ; (do (prn handler args)
                (apply handler (cons state args)))))) ;)

(defn -main
    [] 
    (reduce parse {:round 0} (line-seq (java.io.BufferedReader. *in*))))
(ns brain)
(require 'clojure.set)

(defn regions
    [state]
        (vals (:regions state)))

(defn ours?
    [region]
    (= :us (:owner region)))

(defn enemy?
    [region]
    (= :them (:owner region)))

(defn neutral?
    [region]
    (= :neutral (:owner region)))

(defn neighbours
    [state region]
    (map (fn [region_id] (get-in state [:regions region_id])) (:neighbours region)))

(defn super_region
    [state region]
    (get-in state [:super_regions (:super_region_id region)]))

;; ----- picking regions

(defn pick_starting_region
    [state ids]
    (rand-nth ids))

;; ----- placement and attacking

(defn place_armies
    [state]
    (let [regions   (filter ours? (regions state))
          region    (rand-nth regions)
          placement {:region region :armies (:starting_armies state)}]
        [placement]))

(defn random_movement
    [state region]
    (let [neighbours  (neighbours state region)
          destination (rand-nth neighbours)
          armies      (dec (:armies region))
          movement    {:from region :to destination :armies armies}]
        movement))

(defn attack
    [state] 
    (->> (regions state)
        (filter ours?)
        (filter (fn [region] (> (:armies region) 1)))
        (map (partial random_movement state))))
(ns handlers)

(defn settings
    [state key number]
    (assoc state (keyword key) (Integer/parseInt number)))

(defn settings_starting_regions
    [state & ids]
    (assoc state
        :our_starting_regions
        (map #(Integer/parseInt %) ids)))

(defn settings_your_bot 
    [state name]
    (assoc state :our_name name))

(defn settings_opponent_bot
    [state name]
    (assoc state :their_name name))

(defn setup_map_super_regions
    [state & args]
    (assoc state
        :super_regions
        (reduce
            (fn [super_regions [id reward]]
                (assoc super_regions
                    (Integer/parseInt id)
                    {:id (Integer/parseInt id) :reward (Integer/parseInt reward)}))
            {}
            (partition 2 args))))

(defn setup_map_regions
    [state & args]
    (assoc state
        :regions
        (reduce
            (fn [regions [id super_region_id]]
                (assoc regions
                    (Integer/parseInt id)
                    {   :id (Integer/parseInt id)
                        :super_region_id (Integer/parseInt super_region_id)
                        :armies 2
                        :neighbours []
                        :owner :neutral
                        }))
            {}
            (partition 2 args))))

(defn setup_map_neighbors
    [state & args]
    (->> (partition 2 args)
        (reduce
            (fn [state [_region_id _neighbours]]
                (let [region_id  (Integer/parseInt _region_id)
                      neighbours (map #(Integer/parseInt %) (clojure.string/split _neighbours #","))
                      state2     (update-in state
                                    [:regions region_id :neighbours]
                                    (partial concat neighbours))]
                        (reduce (fn [state neighbour_id]
                            (update-in state
                                [:regions neighbour_id :neighbours]
                                (partial cons region_id)))
                            state2
                            neighbours)))
            state)))

(defn setup_map_wastelands
    [state & wasteland_ids]
    (reduce
        (fn [state region_id]
            (-> state
                (assoc-in
                    [:regions (Integer/parseInt region_id) :wasteland]
                    true)
                (assoc-in
                    [:regions (Integer/parseInt region_id) :armies]
                    6)))
        state
        wasteland_ids))

(defn setup_map_opponent_starting_regions
    [state & ids]
    (assoc state
        :their_starting_regions
        (map #(Integer/parseInt %) ids)))

(defn pick_starting_region
    [state timebank & ids]
    (bot/send-command (brain/pick_starting_region state (map #(Integer/parseInt %) ids)))
    state)

(defn add-placements
    [state args]
    (reduce
        (fn [state arg]
            (let [args                     (clojure.string/split arg #" ")
                  [_ _ _region_id _armies] args
                  region_id                (Integer/parseInt _region_id)
                  armies                   (Integer/parseInt _armies)]
                (update-in state
                    [:regions region_id :armies]
                    (partial + armies))))
        state
        args))

(defn remove-placements
    [state]
    (reduce (fn [state {:keys [region armies]}]
        (update-in state
            [:regions (:id region) :armies]
            #(- % armies)))
        state
        (:last-placement state)))
    
(defn our-output
    [state args]
    (if (and (> (count args) 2) (= "place_armies" (nth args 1)))
        (-> state
            (add-placements (clojure.string/split (clojure.string/join " " args) #","))
            (remove-placements))
        state))

(defn Output
    [state _ _ _ & args]
    (let [quoted (clojure.string/join " " args)
          line   (subs quoted 1 (dec (count quoted)))
          args   (clojure.string/split line #" ")]
        (our-output state args)))

(defn- owner_symbol
    [state owner]
    (cond
        (= owner (get state :our_name)) :us
        (= owner (get state :their_name)) :them
        :else :neutral))

(defn update_map
    [state & args]
    (reduce
        (fn [state [region_id owner armies]]
            (let [region_id (Integer/parseInt region_id)
                  armies    (Integer/parseInt armies)
                  owner     (owner_symbol state owner)]
                (assoc-in state
                    [:regions region_id :owner]
                    owner)))
        (reduce
            (fn [state region_id]
                (if (= :us (get-in state [:regions region_id :owner]))
                    (assoc-in state
                        [:regions region_id :owner]
                        :them)
                    state))
            state
            (keys (:regions state)))
        (partition 3 args)))

; doesn't do anything (yet)
(defn opponent_moves
    [state & args]
    state)

; doesn't do anything
(defn Round
    [state number]
    state)

(defn go_place_armies
    [state timebank]
    (let [moves (brain/place_armies state)
          state (assoc state :last-placement moves)]
        (if (empty? moves)
            (do
                (bot/send-command "No moves")
                state)
            (do
                (->> moves
                    (map (fn [{:keys [region armies]}]
                            (str (:our_name state) " place_armies " (:id region) " " armies ",")))
                    (clojure.string/join "")
                    (bot/send-command))
                (reduce (fn [state {:keys [region armies]}]
                    (update-in state
                        [:regions (:id region) :armies]
                        (partial + armies)))
                    state
                    moves)))))

(defn go_attack_transfer
    [state timebank]
    (let [moves (brain/attack state)]
        (if (empty? moves)
            (bot/send-command "No moves")
            (->> moves
                (map (fn [{:keys [from to armies]}]
                        (str (:our_name state) " attack/transfer " (:id from) " " (:id to) " " armies ",")))
                (clojure.string/join "")
                (bot/send-command))))
    state)(bot/-main)
