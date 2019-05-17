

(\\) :: Int -> Int -> Bool
n \\ m = 0 == mod m n

d :: Int -> Int
d = sum . probDivs

probDivs :: Int -> [Int]
probDivs n = filter (\\ n) [1..n-1]

amicable :: Int -> Int -> Bool
amicable n m = d n == m && d m == n

-- naive try (too slow)
aList :: [(Int, Int)]
aList = [(n,m) | n <- [1..1000], m <- [1..n], n /= m, amicable n m]

-- next try..
first = map (\n -> (n, d n)) [1..10000]
second = filter (\(n, m) -> m > n) first
third = filter (\(n, m) -> d m == n) second
fourth = unzip third
fifth = fst fourth ++ snd fourth
final = sum fifth
-- worked in under a minute..
