module Game.GameState where

import Game.Card
import Game.BetRound
import Game.Player

-- Datatype

data GameState = GameState {
  gameRound :: Int,
  betRound :: BetRound,
  smallBlind :: Int,
  bigBlind :: Int,
  amountToCall :: Int,
  onButton :: Playername,
  communityCards :: [Card],
  communityMoney :: Int,
  myCards :: Maybe (Card, Card),
  enemyCards :: Maybe (Card, Card),
  myBot :: Player,
  otherBot :: Player,
  timeBank :: Int,
  timePerMove :: Int,
  handsPerBlindLevel :: Int
  } deriving Show

-- initial value

initialGameState :: GameState
initialGameState = GameState { gameRound = 0,
                               betRound = Preflop,
                               smallBlind = undefined,
                               amountToCall = 0,
                               bigBlind = undefined,
                               onButton = undefined,
                               communityCards = [],
                               communityMoney = 0,
                               myCards = Nothing,
                               enemyCards = Nothing,
                               myBot = initialPlayer,
                               otherBot = initialPlayer,
                               timeBank = undefined,
                               timePerMove = undefined,
                               handsPerBlindLevel = undefined
                             }

-- prettyprinting for logs

showGameState :: GameState -> [String]
showGameState gs =
  [ showHand (myCards gs) ++ " vs " ++ showHand (enemyCards gs)
  , (show . betRound $ gs) ++ " " ++ (show . communityCards $ gs)
  ]
  where
    showHand :: Maybe (Card, Card) -> String
    showHand Nothing = "hidden"
    showHand (Just cards) = show cards
