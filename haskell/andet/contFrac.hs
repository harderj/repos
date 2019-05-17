
main = do putStrs2 approx

contFrac :: [Double] -> Double
contFrac [] = 0
contFrac [x] = x
contFrac (x:xs) = x + 1 / contFrac xs

approx = take 40 $ map contFrac [[1..n] | n <- [1..15]]

-- putStrs :: Show a => [a] -> IO ()
-- putStrs = sequence_ . map ((++"\n") . show)

putStrs2 :: Show a => [a] -> IO ()
putStrs2 = putStr . unlines . map show


add2 = (+2)
