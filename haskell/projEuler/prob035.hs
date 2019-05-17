import Data.Numbers.Primes
import Data.List

onInt f = round . f . fromIntegral

primesBelow n = takeWhile (<= n) $ wheelSieve m where
  k = n `div` 2
  m = 1 + k `div` onInt log k

relevantPrimes = primesBelow (10^6)

dgs :: (Num a, Show a, Read a) => a -> [a]
dgs = (map (read . (\c -> [c]))) . show

nmb :: (Num a, Show a, Read a) => [a] -> a
nmb = read . (map (head . show))

evenless n = and $ map odd $ dgs n

mConds [] = \_ -> True
mConds (f:fs) = \x -> f x && (mConds fs) x

cycles xs = map (cycleN xs) [0..n-1]
  where n = length xs
        cycleN xs m = take n $ drop m $ cycle xs

circular n = and $ map (isPrime . nmb) $ cycles $ dgs n

-- ups! we miss 2 by filtering with 'evenless'! remember to fix by +1

--step1 = filter (mConds condList) relevantPrimes
  --where condList = [evenless, circular]

-- too slow
-- new approach:
-- generate all circular numbers with odd digits and check primality and uniqueness afterwards instead..

odds = [9,7..1]

combs 0 _ = [[]]
combs n xs = concat $ map (\x -> map (x:) (combs (n-1) xs)) xs

circsN n = concat $ map help odds
  where help m = map (m:) $ combs (n-1) $ filter (<=m) odds

circs = concatMap circsN [1..6]

step1 = filter (circular . nmb) circs

circEq xs ys = or $ map (==ys) $ cycles xs

-- step2 = nubBy circEq step1

step2 = concatMap cycles step1

step3 = map nmb step2

step4 = 2 : (sort $ nub step3)

solution = length step4

--isCircPrime n = 


--step2 = filter (isCircPrime . nmb) step1




-- not done

