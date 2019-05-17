module Game.GameState where

data GameState = GameState {
  timeBank :: Int,
  timePerMove :: Int,
  candleInterval :: Int,
  candlesTotal :: Int,
  candlesGiven :: Int,
  initialStack :: Int,
  transactionFee :: Float,
  nextCandles :: [Candle],
  stacks :: [(String, Float)]
  } deriving Show

data Candle = Candle {
  pair :: Pair,
  date :: Int,
  high :: Float,
  low :: Float,
  open :: Float,
  close :: Float,
  volumne :: Float
  } deriving Show

data Pair = Pair (String, String)
  deriving Show

data Order = Pass
           | Buy Pair Float
           | Sell Pair Float
  deriving Show

initialGameState :: GameState
initialGameState = GameState {
  timeBank = 10000,
  timePerMove = 100,
  candleInterval = 1800,
  candlesTotal = 720,
  candlesGiven = 336,
  initialStack = 1000,
  transactionFee = 0.002,
  nextCandles = [],
  stacks = []
  }

data Input = Update Info
           | ActionRequest Int

data Info = Timebank Int
          | TimePerMove Int
          | CandleInterval Int
          | CandlesTotal Int
          | CandlesGiven Int
          | InitialStack Int
          | TransactionFee Float
          | NextCandles [Candle]
          | Stacks [(String, Float)]

updateGameState
