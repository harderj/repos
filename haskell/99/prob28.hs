import GHC.Exts

lsort :: [[a]] -> [[a]]

lsort = sortWith length


lfsort :: [[a]] -> [[a]]
lfsort xs = sortWith f xs
  where f x = length $ filter (g x) xs
        g x y = length x == length y
