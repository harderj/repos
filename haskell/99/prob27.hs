import Data.List hiding (group)


combinations :: Int -> [a] -> [[a]]
combinations 0 _ = [[]]
combinations _ [] = []
combinations k (x:xs) =
  if k < 0 then error "K<0"
  else withX ++ withoutX
  where withX = map (x:) $ combinations (k - 1) xs
        withoutX = combinations k xs


-- cheated (this is from the web)
combination :: Int -> [a] -> [([a],[a])]
combination 0 xs     = [([],xs)]
combination n []     = []
combination n (x:xs) = ts ++ ds
  where
    ts = [ (x:ys,zs) | (ys,zs) <- combination (n-1) xs ]
    ds = [ (ys,x:zs) | (ys,zs) <- combination  n    xs ]

group :: [Int] -> [a] -> [[[a]]]
group [] _ = [[]]
group (n:ns) xs =
    [ g:gs | (g,rs) <- combination n xs
           ,  gs    <- group ns rs ]

