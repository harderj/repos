import Math.NumberTheory.Primes.Testing
import System.Environment
import Data.Digits
import Data.List

-- dgs :: (Num a, Show a, Read a) => a -> [a]
-- dgs = (map (read . (\c -> [c]))) . show

dgs = digits 10

-- nmb :: (Num a, Show a, Read a) => [a] -> a
-- nmb = read . (map (head . show))

nmb = unDigits 10

oddDigs = concatMap help [2..]
  where help n = map nmb $ listGen n [1,3,5,7,9]

listGen 0 _ = [[]]
listGen m es = concatMap (\e-> map (e:) (listGen (m-1) es)) es

lTruncs ds =
  let m = length ds
  in reverse $ map (\n -> drop n ds) [0..(m-1)]

rTruncs ds = map reverse $ lTruncs $ reverse ds

condition n =
  let ds = dgs n
      l = and $ map (isPrime . nmb) $ lTruncs ds
      r = and $ map (isPrime . nmb) $ rTruncs ds
  in l && r

solution n = take n $ filter condition $ oddDigs 

-- now alternate approach

hToOddDgs :: Integral n => n -> [n]
hToOddDgs n = let h = n `mod` 5
                  r = n `div` 5
                  m = h*2 + 1
              in case r of
                   0 -> [m]
                   x -> m:(hToOddDgs x)

toOddDgs n = unDigits 10 $ hToOddDgs n

solution2 n = take n $ filter condition $ map toOddDgs [4..]

main = do
  args <- getArgs
  case args of
    [] -> print $ solution2 11
    (number:_) -> let n = read number
                      s = solution n
                  in do
      print $ s
      print $ sum s
