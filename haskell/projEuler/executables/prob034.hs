
dgs :: (Num a, Show a, Read a) => a -> [a]
dgs = (map (read . (\c -> [c]))) . show

nmb :: (Num a, Show a, Read a) => [a] -> a
nmb = read . (map (head . show))

factorial n = product [1..n]

condition 1 = False
condition 2 = False
condition n = n == (sum $ map factorial $ dgs n)

naive = filter condition [1..26*10^5]

-- 9999999 ~ 7 * 9! = 2540160 ~ 26*10^5

main = do print naive
