module Game.Input where

import Game.Action
import Game.BetRound
import Game.Card
import Game.GameState
import Game.Player

-- datatypes

data Input = SettingsUpdate Setting
           | MatchUpdate Update
           | ActionRequest Int
data Setting = Timebank Int
             | TimePerMove Int
             | PlayerNames (String, String)
             | YourBot String
             | InitialStack Int
             | InitialBigBlind Int
             | HandsPerBlindLevel Int
type Update = Either GameUpdate PlayerUpdate
data GameUpdate = Round Int
                | BetRound BetRound
                | SmallBlind Int
                | BigBlind Int
                | OnButton Playername
                | Table [Card]
data PlayerUpdate = Chips Playername Int
                  | Hand Playername (Card, Card)
                  | Bet Playername Int
                  | Pot Playername Int
                  | AmountToCall Playername Int
                  | Move Playername Action
                  | Wins Playername Int

-- parsing

-- This is a stupid implementation of the Api
-- https://docs.riddles.io/texas-hold-em/api
-- This could be done more beautifully,

parse :: String -> Maybe Input
parse str = case words str of
  ("settings":settingWords)     -> Just (SettingsUpdate (parseSetting settingWords))
  ("update":updateWords)        -> Just (MatchUpdate (parseUpdate updateWords))
  ("action":"move":[intString]) -> Just (ActionRequest (read intString))
  []                            -> Nothing
  where
    parseSetting :: [String] -> Setting
    parseSetting strs = case strs of
      ("player_names":[value])          -> PlayerNames (splitAtChar ',' value)
      ("your_bot":[value])              -> YourBot value
      ("timebank":[value])              -> Timebank (read value)
      ("time_per_move":[value])         -> TimePerMove (read value)
      ("initial_stack":[value])         -> InitialStack (read value)
      ("initial_big_blind":[value])     -> InitialBigBlind (read value)
      ("hands_per_blind_level":[value]) -> HandsPerBlindLevel (read value)

    parseUpdate :: [String] -> Update
    parseUpdate (keyword:restwords) = case keyword of
      "game"   -> Left  $ parseGameUpdate restwords
      playername -> Right $ parsePlayerUpdate playername restwords
      where
        parseGameUpdate :: [String] -> GameUpdate
        parseGameUpdate [keyword, value] = case keyword of
          "round"       -> Round (read value)
          "bet_round"   -> BetRound (read value)
          "small_blind" -> SmallBlind (read value)
          "big_blind"   -> BigBlind (read value)
          "on_button"   -> OnButton (read value)
          "table"       -> Table (read value)

        parsePlayerUpdate :: Playername -> [String] -> PlayerUpdate
        parsePlayerUpdate name [keyword, value] = case keyword of
          "chips"          -> Chips name (read value)
          "bet"            -> Bet name (read value)
          "pot"            -> Pot name (read value)
          "amount_to_call" -> AmountToCall name (read value)
          "move"           -> Move name (read value)
          "wins"           -> Wins name (read value)
          "hand"           -> Hand name (read cardStr1, read cardStr2)
          where
            (cardStr1, cardStr2) = (splitAtChar ',' value)
    splitAtChar :: (Eq a) => a -> [a] -> ([a], [a])
    splitAtChar x xs = (firstPart, tail secondPartWithX)
      where (firstPart, secondPartWithX) =  break ((==) x) xs


-- Manipulating a GameState

-- This should probably be done with lenses.
-- TODO Some Settings are still ignored
applySettingsUpdate :: Setting -> GameState -> GameState
applySettingsUpdate (Timebank _) gs = gs
applySettingsUpdate (TimePerMove _) gs = gs
applySettingsUpdate (HandsPerBlindLevel _) gs = gs
-- We assume that the player already have names, but they might be
-- switched. If this is the case, the "yourbot" input is how we can
-- find out and fix that.
applySettingsUpdate (YourBot name) gs
  | name == (playerName . myBot    $ gs) = gs
  | name == (playerName . otherBot $ gs) = gs { myBot    = (myBot gs)    {playerName = playerName . otherBot $ gs}
                                              , otherBot = (otherBot gs) {playerName = playerName . myBot    $ gs}
                                              }
  | otherwise  = error "\"yourname\" was called before \"player_names\""
applySettingsUpdate (InitialBigBlind amount) gs = gs {bigBlind = amount}
applySettingsUpdate (InitialStack amount) gs = gs {myBot = (myBot gs) {stack = amount}
                                                      , otherBot = (otherBot gs) {stack = amount}
                                                      }
-- Just assume that myBot was named first. If this assumption is false
-- we will switch the names when the first "yourbot" command occurs
applySettingsUpdate (PlayerNames (name1, name2)) gs = gs { myBot = (myBot gs) {playerName = name1}
                                                             , otherBot = (otherBot gs) {playerName = name2}
                                                             }

applyMatchUpdate :: Update -> GameState -> GameState
applyMatchUpdate (Left gameUpdate) gs = case gameUpdate of
  (Round n)           -> gs {gameRound = n}
  (BetRound value)    -> gs {betRound = value}
  (SmallBlind amount) -> gs {smallBlind = amount}
  (BigBlind amount)   -> gs {bigBlind = amount}
  (OnButton name)     -> gs {onButton =name}
  (Table cards)       -> gs {communityCards = cards}
applyMatchUpdate (Right playerUpdate) gs = case playerUpdate of
  (Chips name amount)        -> gs {myBot = myBot', otherBot = otherBot'}
    where
      myBot'
        |((== name) . playerName . myBot   ) gs = (myBot gs) {stack = amount}
        |otherwise                              = myBot gs
      otherBot'
        |((== name) . playerName . otherBot) gs = (otherBot gs)
        |otherwise                              = (otherBot gs) {stack = amount}
  (Hand name cards) -> if name == (playerName . myBot $ gs)
                       then gs {myCards = Just cards}
                       else if name == (playerName . otherBot $ gs)
                       then gs {enemyCards = Just cards}
                       else error $ "Don't know the player " ++ name ++ "."
  (Bet name amount)          -> gs {myBot = myBot', otherBot = otherBot', communityMoney = (communityMoney gs) + amount }
    where
    myBot'
        |((== name) . playerName . myBot   ) gs = (myBot gs) {stack = stack (myBot gs) - amount}
        |otherwise                              = myBot gs
    otherBot'
        |((== name) . playerName . otherBot) gs = (otherBot gs) {stack = stack (otherBot gs) - amount}
        |otherwise                              = otherBot gs
  (Pot name amount)          -> gs {communityMoney = amount}
  (AmountToCall name amount) -> if ((== name) . playerName . myBot) gs
                                then gs {amountToCall = amount}
                                else gs -- not interesting
  (Move name action)         -> gs  -- We don't log the game moves (for now) so there is nothing to do here
  (Wins name amount)         -> gs {myBot = myBot', otherBot = otherBot', communityMoney = 0}
    where
      myBot'
        |((== name) . playerName . myBot   ) gs = (myBot gs) {stack = (+ amount) . stack . myBot $ gs}
        |otherwise                              = myBot gs
      otherBot'
        |((== name) . playerName . otherBot) gs = (otherBot gs)
        |otherwise                              = (otherBot gs) {stack = (+ amount) . stack . myBot $ gs}



