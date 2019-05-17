{-# LANGUAGE FlexibleContexts #-}

import Data.List
import Data.Numbers.Primes

auxFunc a b n = n^2 + a*n + b

func b n = n^2-79*n+b

-- g b = length $ takeWhile (\x -> isReally (func b x)) [0..]

isReally n = if n < 2 then False else isPrime n

-- isPrime' n = isPrime (round $ f . sqrt $ fromIntegral n) where
--   f x = x / (log x)

--consecPrimes :: Integral a => (a -> Bool) -> a
consecPrimes f = help 0 f where
  help n f = if isReally (f n)
             then help (n+1) f
             else n

-- aux1 n f = if isPrime (f n)
--            then aux1 (n+1) f
--            else n

--step1 :: Integral a => a
step1 aLim bLim = map help [(a,b) | b <- [2..bLim], a <- [(1-b)..aLim]] where
  help (a,b) = ((a,b), consecPrimes (auxFunc a b))

auxComp (_, x) (_,x') =
  compare x x'

solution1 = uncurry (*) $ fst $ maximumBy auxComp $ step1 999 1000

main = do print solution1




