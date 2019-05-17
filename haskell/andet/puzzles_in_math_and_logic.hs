toDigits :: Integer -> [Integer]
toDigits = (map (read . (:""))) . show

nDigits :: Integer -> Integer
nDigits = toInteger . length . toDigits

seqn f n = map f [0..n]

-- problem #??
-- what is the largest number n, which is also an exact nth power?

digEqPow :: Integer -> Integer -> Bool
digEqPow n m = nDigits (n^m) == m

set = [ x^y
      | x <- [1..30],
        y <- [1..30],
        y == nDigits (x^y)]

solution = maximum set