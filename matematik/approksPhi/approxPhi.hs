
g :: Int -> Int -> Int -> Int
g a b 0 = a
g a b 1 = b
g a b c = g a b (c - 1) + g a b (c - 2)

a :: (Integral b) => b -> b -> Rational
a x y = fromIntegral x / fromIntegral y

--b = (% 2 3)

h :: Int -> Int -> Int -> Float
h a b c = (fromIntegral (g a b (c+1))) / fromIntegral (g a b c)

main = let x = -1
           y = 20
           n = 30
       in do putStrLn $ show $ map (g x y) [1..n]
             putStrLn $ show $ map (h x y) [1..n]