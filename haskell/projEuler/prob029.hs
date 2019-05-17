import Data.List

halfNub [] = []
halfNub [x] = [x]
halfNub es = x : help x xs where
  (x:xs) = sort es
  help _ [] = []
  help z (y:ys)
    = if z==y
      then help z ys
      else y : (help y ys)

step1 = [a^b | a <- [2..100], b <- [2..100]]

step2 = sort step1

step3 = halfNub step2

solution = length step3

main = do print solution
