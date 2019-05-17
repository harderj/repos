
dgs :: (Num a, Show a, Read a) => a -> [a]
dgs = (map (read . (\c -> [c]))) . show

nmb :: (Num a, Show a, Read a) => [a] -> a
nmb = read . (map (head . show))

factorial 0 = 1
factorial 1 = 1
factorial 2 = 2
factorial 3 = 6
factorial 4 = 24
factorial 5 = 120
factorial 6 = 720
factorial 7 = 540
factorial 8 = 40320
factorial 9 = 362880
factorial n = product [1..n]

condition 1 = False
condition 2 = False
condition n = n == (sum $ map factorial $ dgs n)

naive = sum $ filter condition [1..26*10^5]

-- 9999999 ~ 7 * 9! = 2540160 ~ 26*10^5

main = do print naive
