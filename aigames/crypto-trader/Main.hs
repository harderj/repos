module Main (main) where

import Control.Monad (unless)
import Control.Monad.IO.Class (liftIO)
import Control.Monad.Trans.State.Lazy (StateT, get, put, modify,  evalStateT)
import System.IO (hSetBuffering, BufferMode(LineBuffering), stdin, stdout, stderr, hFlush, isEOF)

import qualified System.Random as R
import Data.Array
import Data.Char
import Data.List

import Game.GameState

data State = State GameState R.StdGen

type Context = StateT State IO

main :: IO ()
main = do
  hSetBuffering stdin LineBuffering
  g <- R.getStdGen
  evalStateT loop (State initialGameState g)

loop :: Context ()
loop = do
  line <- liftIO getLine
  case parse line of
    Nothing -> return ()
    Just (Update info)
      -> do state <- get
            modify (\(State gs gen) -> State (updateGameState info) gen)
    Just (ActionRequest time)
      -> do state <- get
            let (bestMove, gen) = findBestAction state
            modify (genUpdate gen)
            liftIO . print $ bestMove
            liftIO (hFlush stdout)
  eof <- liftIO isEOF
  unless (line == "quit" || eof) loop

update

genUpdate :: R.StdGen -> State -> State
genUpdate g (State s g') = State s g

setState :: Info -> State -> State
setState input state = case input of
  (UpdateGameField board)
    -> let (State gs gen) = state
           color = myColor gs
       in State (GameState {myColor = color,
                             board = board}) gen
  (SettingsBotId n)
    -> let (State gs gen) = state
       in State (GameState { myColor = (intToColor n)
                            , board = board gs }) gen

intToColor :: Int -> Color
intToColor n = case n of
  0 -> Black
  1 -> White
  _ -> error "n /= 0 | 1 in intToColor parse"

findBestAction :: State -> (Action, R.StdGen)
findBestAction state = let
  (State gs gen) = state
  b = board gs
  (Board arr) = b
  legalIndices = [i | i <- indices arr, legal b i]
  in case legalIndices of
       [] -> (Pass, gen)
       is -> destroyEnemy is state

randomMove :: [Index] -> State -> (Action, R.StdGen)
randomMove idxs (State gs gen) =
  let (Board arr) = board gs
      (i, g) = randomIndex idxs gen
      (Idx x y) = idxs !! i
  in (Place x y, g)

destroyEnemy :: [Index] -> State -> (Action, R.StdGen)
destroyEnemy idxs (State gs gen) =
  let b = board gs
      is = filter (nextToEnemy gs) idxs
  in if is == []
     then randomMove idxs (State gs gen)
     else let (n, g) = randomIndex is gen
              (Idx x y) = is !! n
          in (Place x y, g)

randomIndex :: [a] -> R.StdGen -> (Int, R.StdGen)
randomIndex xs gen = R.randomR (0, length xs - 1) gen

nextToEnemy :: GameState -> Index -> Bool
nextToEnemy gs index
  = let (Board arr) = board gs
    in exists (\i -> arr ! i == Stone (enemyColor gs)) $ neighbours index

enemyColor :: GameState -> Color
enemyColor gs = case myColor gs of
  White -> Black
  Black -> White

exists :: (a -> Bool) -> [a] -> Bool
exists f = not . (all (not . f))

neighbours :: Index -> [Index]
neighbours (Idx x y) = filter (inRange ((Idx 0 0),(Idx 18 18)))
                    [(Idx (x - 1) y), (Idx x (y - 1)),
                     (Idx (x + 1) y), (Idx x (y + 1))]

parse :: String -> Maybe Input
parse str = case words str of
  ("settings":"your_botid":[value]) ->
    Just (Info (SettingsBotId (read value)))
  ("update":"game":"field":[value]) ->
    Just (Info (UpdateGameField (unwrapBoard value)))
  ("action":"move":[value]) ->
    Just (Action (read value))
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
