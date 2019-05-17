

combinations :: Int -> [a] -> [[a]]
combinations 0 _ = [[]]
combinations _ [] = []
combinations k (x:xs) =
  if k < 0 then error "K<0"
  else withX ++ withoutX
  where withX = map (x:) $ combinations (k - 1) xs
        withoutX = combinations k xs
