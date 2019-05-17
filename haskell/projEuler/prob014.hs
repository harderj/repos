{-
jh@jacobharder.dk
project euler
problem 14
-}

--even = (==0) . (mod 2)
collatzN n = h 1 n
    where h c 1 = c
          h c n = h (c+1) m
            where m = if even n
                      then n `div` 2
                      else 3*n + 1

findMax [] = error "empty list"
findMax (x:xs) = h 1 2 x xs
  where h m n x [] = (m, x)
        h m n x (y:ys)
          = if y >= x
            then h n (n+1) y ys
            else h m (n+1) x ys

sol n = findMax $ map collatzN [1..n]
