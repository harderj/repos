
-- fails for negative n or xs
findSum _ [] = 0 
findSum n (x:xs) = case compare 0 n of
  LT -> findSum (n-x) (x:xs) + findSum n xs
  EQ -> 1
  GT -> 0

solution = findSum 200 [1,2,5,10,20,50,100,200]

main = do print solution

-- for fun
findSumList _ [] = []
findSumList n (x:xs) = case compare 0 n of
  LT -> (map (x:) (findSumList (n-x) (x:xs))) ++ findSumList n xs
  EQ -> [[]]
  GT -> []

