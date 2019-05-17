module GameState where

import Data.List
import Data.Array
import qualified Data.Set as S

data GameState = GameState {
  myColor :: Color,
  board :: Board,
  timePerMove :: Int
  } deriving Show

data Board = Board (Array Index Point)
           deriving Eq

data Point = Free
           | Stone Color
           | Illegal
           deriving Eq

data Color = Black | White deriving (Eq, Show, Ord)

instance Read Point where
  readsPrec _ (c1:c2:cs) = case (c1, c2) of
    ('0',_) -> [(Stone Black, c2:cs)]
    ('1',_) -> [(Stone White, c2:cs)]
    ('.',_) -> [(Free, c2:cs)]
    ('-','1') -> [(Illegal, cs)]
    _ -> fail "No parse of string to point"
  readsPrec _ [c] = case c of
    '0' -> [(Stone Black, [])]
    '1' -> [(Stone White, [])]
    '.' -> [(Free, [])]
    _ -> fail "No parse of string to point"
  readsPrec _ _ = fail "No parse of string to point"

instance Show Point where
  show Free = "."
  show (Stone Black) = "0"
  show (Stone White) = "1"
  show Illegal = "-1"

instance Show Board where
  show (Board b)
    = let s = unlines
            $ map (\i -> concatMap
                         (\j -> showN 2
                                $ b ! (Idx j i))
                    [0..18]) [0..18]
      in pord 1 s

data Input = Info Info
           | Action Int
           | RoundNumber Int
           deriving (Show, Eq)

data Info = SettingsBotId Int
          | SettingsTimePerMove Int
          | UpdateGameField Board
          deriving (Show, Eq)

data Action = Place Int Int
            | Pass

instance Show Action where
  show (Place x y) = "place_move " ++ show x ++ " " ++ show y
  show Pass = "pass"

data Index = Idx Int Int deriving (Eq)

instance Show Index where
  show (Idx x y) = "(" ++ show x ++ " " ++ show y ++ ")"

instance Ord Index where
  compare (Idx x y) (Idx x' y')
    = case (compare y y') of
        EQ -> (compare x x')
        ordering -> ordering

instance Ix Index where
  range ((Idx x y), (Idx x' y'))
    = [Idx x'' y'' | y'' <- [y..y'], x'' <- [x..x']]
  inRange ((Idx x y), (Idx x' y')) (Idx x'' y'')
    = x <= x'' && x'' <= x' && y <= y'' && y'' <= y'
  index (i, j) k
    = case elemIndex k (range (i, j)) of
        Just n -> n
        Nothing -> error "Error in array index"

type StoneGroup = [Index]

boardArr :: Board -> Array Index Point
boardArr (Board arr) = arr

simulate :: Board -> Color -> Action -> Board
simulate b _ Pass = b
simulate b c (Place x y) = let
  placed = setBoard b [(Idx x y, (Stone c))]
  in removeTheDead placed

removeTheDead :: Board -> Board
removeTheDead b = let
  deadStones = concat $ filter (deadGroup b) $ getGroups b
  in setBoard b [(i, Free) | i <- deadStones]

deadGroup :: Board -> StoneGroup -> Bool
deadGroup b = (==0) . (freedoms b)

setBoard :: Board -> [(Index, Point)] -> Board
setBoard (Board arr) s = Board (arr//s)
  
neighbours :: Index -> [Index]
neighbours (Idx x y) = filter (inRange ((Idx 0 0),(Idx 18 18)))
                    [(Idx (x - 1) y), (Idx x (y - 1)),
                     (Idx (x + 1) y), (Idx x (y + 1))]


freedoms :: Board -> StoneGroup -> Int
freedoms (Board arr) idxs = let
  closure = nub $ concatMap neighbours idxs
  boundary = closure \\ idxs
  in length $ filter (\i -> arr ! i `elem` [Free, Illegal]) $ boundary

getGroup :: Board -> Index -> StoneGroup
getGroup (Board arr) idx = case arr ! idx of
  Stone color -> let (_, _, res) = help (color, arr, []) idx
                 in res
  _ -> []
  where
    help (c, a, covered) i
      = if elem i covered then (c, a, covered)
        else if a ! i == Stone c
             then foldl help (c, a, i:covered) (neighbours i)
             else (c, a, covered)

getGroups :: Board -> [[Index]]
getGroups b =
  let es = getStones b
      help [] = []
      help (i:is) =
        let g = getGroup b i
        in g : help (is \\ g)
  in help es

getStones :: Board -> [Index]
getStones (Board arr) =
  [i | i <- indices arr, isStone(arr!i)]

isStone :: Point -> Bool
isStone (Stone _) = True
isStone _ = False

getGroupsOf :: Board -> Color -> [[Index]]
getGroupsOf b c =
  let es = getStonesOf b c
      help [] = []
      help (i:is) =
        let g = getGroup b i
        in g : help (is \\ g)
  in help es

getStonesOf :: Board -> Color -> [Index]
getStonesOf (Board arr) c =
  [i | i <- indices arr, arr!i == Stone c]

setGameState :: Info -> GameState -> GameState
setGameState input gs = let
  oldColor = myColor gs
  oldBoard = board gs
  oldTimePerMove = timePerMove gs
  in case input of
  (UpdateGameField b)
    -> GameState { myColor = oldColor
                 , board = b
                 , timePerMove = oldTimePerMove }
  (SettingsTimePerMove n)
    -> GameState { timePerMove = n
                 , board = oldBoard
                 , myColor = oldColor }
  (SettingsBotId n)
    -> GameState { myColor = (intToColor n)
                 , board = board gs
                 , timePerMove = oldTimePerMove }

intToColor :: Int -> Color
intToColor n = case n of
  0 -> Black
  1 -> White
  _ -> error "Error: n /= 0 | 1 in intToColor parse."

stoneless :: Point -> Bool
stoneless = not . ((flip elem) [Free, Illegal])

exists :: (a -> Bool) -> [a] -> Bool
exists f = not . (all (not . f))

parse :: String -> Maybe Input
parse str = case words str of
  ("settings":"your_botid":[value]) ->
    Just (Info (SettingsBotId (read value)))
  ("settings":"time_per_move":[value]) ->
    Just (Info (SettingsTimePerMove (read value)))
  ("update":"game":"field":[value]) ->
    Just (Info (UpdateGameField (unwrapBoard value)))
  ("action":"move":[value]) ->
    Just (Action (read value))
  ("update":"game":"round":[value]) ->
    Just (RoundNumber (read value))
  _ -> Nothing

unwrapBoard :: String -> Board
unwrapBoard info =
  Board (listArray ((Idx 0 0), (Idx 18 18))
         (map read $ deduct ',' info))

wrapBoard :: Board -> String
wrapBoard (Board arr)
  = intercalate "," $ map show $ elems arr

deduct :: Eq a => a -> [a] -> [[a]]
deduct x s = case dropWhile (== x) s of
  [] -> []
  s' -> w : deduct x s''
    where (w, s'') = break (== x) s'

legal :: Board -> Index -> Bool
legal (Board b) (Idx i j) =
  b ! (Idx i j) == Free

showN :: Show a => Int -> a -> String
showN n a = reverse $ take n $ reverse (show a) ++ repeat ' '

pord n = reverse . (drop n) . reverse

emptyBoard = Board (listArray ((Idx 0 0), (Idx 18 18)) $ repeat Free)

boardInsert :: Index -> Point -> Board -> Board
boardInsert (Idx x y) p (Board arr)
  = let list = elems arr
        nlist = listInsert (y + 19*x) p list
    in Board (listArray (bounds arr) nlist)

listInsert :: Int -> a -> [a] -> [a]
listInsert n x list = take n list ++ [x] ++ drop (n+1) list


