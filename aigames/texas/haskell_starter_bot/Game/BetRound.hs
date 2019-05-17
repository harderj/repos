module Game.BetRound where

-- datatype

data BetRound = Preflop
              | Flop
              | Turn
              | River
              deriving Show

-- Read

instance Read BetRound where
  readsPrec _ str
    | prefix7 == "preflop" = [(Preflop, rest7)]
    | prefix4 == "flop" = [(Flop, rest4)]
    | prefix4 == "turn" = [(Turn, rest4)]
    | prefix5 == "river" = [(River, rest5)]
    where
      (prefix4, rest4) = splitAt 4 str
      (prefix5, rest5) = splitAt 5 str
      (prefix7, rest7) = splitAt 7 str
