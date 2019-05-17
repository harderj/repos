
import Primes
--import OpenTheory.Primitive.Natural
--import qualified OpenTheory.Number.Natural.Prime as P

--ps = takeWhile (<1000) P.all

--p = last ps

ones n = sum [10^n | n <- [0..n-1]]

nines n = 9 * ones n



indexA n = if (n `mod` 2 == 0) || (n `mod` 5 == 0)
           then 0
           else 1 + length l
  where l = takeWhile (\m -> (nines m) `mod` n /= 0) [1..]

groupA = let a = map indexA [950..999]
             b = zip a [950..]
             c = filter ((>900) . fst) b
         in c

solution = snd $ last groupA
