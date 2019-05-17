
toDig :: Integer -> [Int]
toDig = (map (read . h)) . show
  where h c = c:""

selfPowers n = sum [m^m | m <- [1..n]]

solution = (reverse . (take 10) . reverse . toDig) n
  where n = selfPowers 1000

-- got an idea for a smarter solution:
-- look at the series in binary form
-- prove that if m is even and greater than 10,
-- it does not contribute to the binary version of the last 10 digits...