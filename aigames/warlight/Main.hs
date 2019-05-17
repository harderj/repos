module Main (main) where

import System.IO
import Data.List
import Data.Maybe

type State = String

main :: IO ()
main = do
  loop ""

loop :: State -> IO ()
loop state = do
  line <- getLine
  newState <- update state line
  if gameFinished newState
    then return ()
    else loop newState

update :: State -> String -> IO State
update state line = let
  lines = split ' ' line in do
  --print lines
  case lines of
    ("settings":ls) -> return $ set state lines
    ("setup_map":ls) -> return $ set state lines
    ("opponent_moves":ls) -> return $ set state lines
    ("go":ls) -> act state ls
    ("pick_starting_regions":ls) -> pick state ls
    ("quit":ls) -> return "quit"
    _ -> return state

set :: State -> [String] -> State
set state (_:"your_bot":name:_) = name
set state lines = state

act :: State -> [String] -> IO State
act state lines = do
  action <- getAction state lines
  print $ action
  return $ set state $ split ' ' $ action

pick :: State -> [String] -> IO State
pick s (_:r1:r2:r3:r4:r5:r6:_) = let
  picks = (intercalate " " [r1,r2,r3,r4,r5,r6]) in do
  print picks
  return $ concat [s, " ", picks] -- state specific

getAction :: State -> [String] -> IO String
getAction state lines =
  case lines of
    ("place_armies":ls) -> return $ placeArmies state
    _ -> return "no_moves"

placeArmies :: State -> String
placeArmies state = let
  (name:r1:_) = split ' ' state in
  name ++ " " ++ r1 ++ " 1,"

gameFinished :: State -> Bool
gameFinished s = (s == "quit")

split :: (Eq a) => a -> [a] -> [[a]]
split _ [] = []
split c xs = h c xs [] where
  h _ [] ys = [reverse ys]
  h c (x:xs) ys =
    if (x/=c)
    then h c xs (x:ys)
    else (reverse ys) : split c xs
