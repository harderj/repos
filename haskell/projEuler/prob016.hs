
digitSum :: Integer -> Integer
digitSum = sum . toDigits

toDigits :: Integer -> [Integer]
toDigits = (map (read . (:""))) . show

solution = digitSum $ 2^1000