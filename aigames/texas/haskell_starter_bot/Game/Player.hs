module Game.Player where

-- data types

data Player = Player {
  playerName :: Playername,
  stack :: Int
} deriving Show

type Playername = String

-- Initial value

initialPlayer = Player "" 0
