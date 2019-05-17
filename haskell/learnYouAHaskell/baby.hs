-- Exercises for Learn you a Haskell
-- Jacob Harder
-- 12. nov. 2013

doubleMe x = x + x
doubleUs x y = x*2 + y*2

doubleSmallNumber x = (if x > 100 then x else x*2) + 1

conanO'Brien = "It's a-me, Conan O'Brien!"

boomBangs xs = [ if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]

length' xs = sum [ 1 | _ <- xs ]

removeNonUppercase :: [Char] -> [Char]
removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]

addThree :: Int -> Int -> Int -> Int
addThree x y z = x + y + z

factorial :: Integer -> Integer
factorial n = product [1..n]

circumference :: Float -> Float
circumference r = 2 * pi * r

circumference' :: Double -> Double
circumference' r = 2 * pi * r

lucky :: (Integral a) => a -> String
lucky 7 = "LUCKY NUMBER SEVEN!"
lucky x = "Sorry, you're out of luck, pal!"

sayMe :: (Integral a) => a -> String
sayMe 1 = "One!"
sayMe 2 = "Two!"
sayMe 3 = "Three!"
sayMe 4 = "Four!"
sayMe 5 = "Five!"
sayMe _ = "Not between one and five!"

divides :: (Integral a) => a -> a -> Bool
divides a n = (0 == mod n a)

divisors :: Integer -> [Integer]
divisors n = [x | x <- [1..n], divides x n] 

perfectNumbers :: Integer -> [Integer]
perfectNumbers n = [x | x <- [1..n], sum (divisors x
                                         ) == x]