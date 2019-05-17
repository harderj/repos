

aux1 n = 4*(2*n + 1)^2 - 12 * n

solution = 1 + ( sum $ map aux1 [1..(1001 `div` 2)])

main = do print solution
