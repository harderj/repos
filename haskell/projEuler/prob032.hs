
import Data.List

-- 99999/9 = 50000

-- 10^4 ~ 10^3  10^2
-- 5-d    3-d

dgs :: (Num a, Show a, Read a) => a -> [a]
dgs = (map (read . (\c -> [c]))) . show

nmb :: (Num a, Show a, Read a) => [a] -> a
nmb = read . (map (head . show))

zeroless = not . (elem 0)

sortNub [] = []
sortNub [x] = [x]
sortNub es = x : help x xs where
  (x:xs) = sort es
  help _ [] = []
  help z (y:ys)
    = if z==y
      then help z ys
      else y : (help y ys)

sortNubBy _ [] = []
sortNubBy _ [x] = [x]
sortNubBy f es = x : help f x xs where
  (x:xs) = sortBy f es
  help f _ [] = []
  help f z (y:ys)
    = if f z y == EQ
      then help f z ys
      else y : (help f y ys)

hetero l = (sortNub l) == sort l

-- proper n = zeroless n && hetero n

-- auxPairs :: Num a => [(a,a)]
auxPairs = [(a,b) | a <- [1..9], b <- [1..9], a*b < 10]

-- frst (a,b,c,d,e) = a
-- scnd (a,b,c,d,e) = b
-- thrd (a,b,c,d,e) = c
-- frth (a,b,c,d,e) = d
-- ffth (a,b,c,d,e) = e


step1 = [ (a,b,c,d,e)
        | (a,b) <- auxPairs,
          c <- [1..9],
          d <- [1..9],
          e <- [1..9],
          hetero [a,b,c,d,e]]

pandig2x3 t =
  let (x,y,z) = get2x3 t
      (a,b,c,d,e) = t
      zs = dgs z
  in (z < 10^5)
     && (zeroless zs)
     && (hetero $ [a,b,c,d,e] ++ zs)

pandig1x4 t =
  let (x,y,z) = get1x4 t
      (a,b,c,d,e) = t
      zs = dgs z
  in (z < 10^5)
     && (zeroless zs)
     && (hetero $ [a,b,c,d,e] ++ zs)

get2x3 (a,b,c,d,e) = let
  x = nmb [a,c]
  y = nmb [b,d,e]
  z = x * y
  in (x,y,z)

get1x4 (a,b,c,d,e) = let
  x = nmb [a]
  y = nmb [b,c,d,e]
  z = x * y
  in (x,y,z)

step2 = filter pandig2x3 step1
step3 = filter pandig1x4 step1
step4 = map get2x3 step2 ++ map get1x4 step3
step5 = sortNubBy (\(_,_,z) (_,_,z') -> compare z z') step4
step6 = sum $ map (\(_,_,z) -> z) step5

solution = step6

main = do print solution
