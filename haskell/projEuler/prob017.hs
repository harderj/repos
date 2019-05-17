import Data.Char

spoken :: Integer -> String
spoken 0 = "zero"
spoken 1 = "one"
spoken 2 = "two"
spoken 3 = "three"
spoken 4 = "four"
spoken 5 = "five"
spoken 6 = "six"
spoken 7 = "seven"
spoken 8 = "eight"
spoken 9 = "nine"
spoken 10 = "ten"
spoken 11 = "eleven"
spoken 12 = "twelve"
spoken 13 = "thirteen"
spoken 14 = "fourteen"
spoken 15 = "fifteen"
spoken 16 = "sixteen"
spoken 17 = "seventeen"
spoken 18 = "eighteen"
spoken 19 = "nineteen"
spoken 20 = "twenty"
spoken 30 = "thirty"
spoken 40 = "forty"
spoken 50 = "fifty"
spoken 60 = "sixty"
spoken 70 = "seventy"
spoken 80 = "eighty"
spoken 90 = "ninety"
spoken 1000 = "one thousand"
spoken n
  = if n < 100 -- tens
    then spoken (10 * (n `div` 10)) ++ "-" ++ spoken (n `mod` 10)
    else if n < 1000 -- hundreds
         then if n `mod` 100 == 0
              then spoken (n `div` 100) ++ " hundred"
              else spoken (n `div` 100)
                   ++ " hundred and "
                   ++ spoken (n `mod` 100)
         else error $ "Not defined for numbers larger than "
              ++ spoken 1000 -- thousands

rmGlyphs :: String -> String
rmGlyphs = filter isAlpha

solution = length . rmGlyphs . concat $ map spoken [1..1000]
