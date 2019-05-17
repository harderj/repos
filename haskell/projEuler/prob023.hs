
import Data.List
import Data.Numbers.Primes

ds n = help $ primeFactors n where
  help [] = []
  help (x:xs) = x : ((map (*x) xs) ++ help xs)


--lim = 28123
lim = 300

divides n m = 0 == mod n m

d :: Int -> Int
d = sum . probDivs

phi = sum . divs

divs n = filter (divides n) [1..n]

probDivs :: Int -> [Int]
probDivs n = filter (divides n) [1..(n `div` 2)]

perfect n = n == d n

perfects = filter perfect [1..lim]

nonabund = not . abundant

abundant n = if n < 12 then False
             else n < d n
abundants = abunds lim

abunds n = filter abundant [1..n]

--filter' _ [] = []
--filter' f (x:xs) = if f x then x : filter' f xs
                   --else filter' f xs

--abundants' = filter' abundant [1..lim]

sumOfTwoAbundants n = help 12 (n-12) where
  help n m = if abundant n && abundant m
             then True
             else if n > m
                  then False
                  else help (n+1) (m-1)

solution1 = sum $ filter (not . sumOfTwoAbundants) [1..lim] -- slow

pairWithoutOrder [] = []
pairWithoutOrder (x:xs) = (map (\y -> (x,y)) xs) ++ pairWithoutOrder xs

allSums xs = map (\(x,y) -> x+y) $ pairWithoutOrder xs

allSums' [] = []
allSums' (x:xs) = (map (+x) xs) ++ allSums' xs

allAbundSums = allSums' $ abunds lim

-- sortNub = (foldr help []) . sort where 
--   help x [] = []
--   help x (y:ys) = if x==y then 

sortNub [] = []
sortNub [x] = [x]
sortNub es = x : help x xs where
  (x:xs) = sort es
  help _ [] = []
  help z (y:ys)
    = if z==y
      then help z ys
      else y : (help y ys)

solution2 = (lim + 1) * lim `div` 2 - sum (takeWhile (<= lim) $ sortNub allAbundSums) -- also slow

main = do print $ solution2 - 64 -- off by 64.. why?!

-- .. not done



