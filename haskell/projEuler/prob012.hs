import Data.List

divides n m = 0 == mod m n

-- prime factorization
pfac :: Integer -> [Integer]
pfac = h 2
  where h _ 1 = []
        h c n = if c `divides` n
                then c : h 2 (n `div` c)
                else h (c + 1) n

-- count dublicates in sorted list
dubCnt [] = []
dubCnt (x:xs) = h 1 x xs
  where h n x [] = [n]
        h n x (y:ys) = if x==y
                       then h (n+1) y ys
                       else n : h 1 y ys

-- the triangular numbers
tri :: Integer -> Integer
tri n = n * (n + 1) `div` 2

-- Eulers phi-function
phi = product . (map (+1)) . dubCnt . pfac
phiSlow n = length $ filter (flip divides n) [1..n]

sol = head $ filter ((500<=) . phi) (map tri [1..])