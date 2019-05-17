module Game.Action where

-- datatype

data Action = Fold
            | Check
            | Call
            | Raise Int

-- Show

instance Show Action where
  show Fold = "fold"
  show Check = "check"
  show Call = "call"
  show (Raise amount) = "raise_" ++ (show amount)

-- Read

instance Read Action where
  readsPrec _ ('F':'o':'l':'d':str) = [(Fold, str)]
  readsPrec _ ('C':'h':'e':'c':'k':str) = [(Check, str)]
  readsPrec _ ('C':'a':'l':'l':str) = [(Call, str)]
  readsPrec _ ('R':'a':'i':'s':'e':'_':str) = [(Raise amount, reststr)]
    where
      (numstr, reststr) = break (`elem` ['0'..'9']) reststr
      amount :: Int
      amount = read numstr
