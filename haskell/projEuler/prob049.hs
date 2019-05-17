
import Data.List
import Data.Numbers.Primes

onInt f = round . f . fromIntegral

primesBelow n = takeWhile (<= n) $ wheelSieve m where
  k = n `div` 2
  m = 1 + k `div` onInt log k

relevantPrimes = drop 168 $ primesBelow (10^4)

-- not done

-- import OpenTheory.Primitive.Natural
-- import qualified OpenTheory.Number.Natural.Prime as P

-- relevantPrimes
--   = takeWhile (\a->999<a && a<10000) P.all :: [Natural]

-- digPerms :: Natural -> [Natural]

-- digPerms = (map readN) . permutations . show

-- readN n = let i = read n :: Int
--           in toEnum i :: Natural
