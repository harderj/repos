
fibSlow :: Integer -> Integer
fibSlow 0 = 0
fibSlow 1 = 1
fibSlow n = fibSlow (n-1) + fibSlow (n-2)


fibFast :: Integer -> Integer
fibFast n = round expr
  where expr = invSqrt5 * (phi^n - psi^n) :: Double
        sqrt5 = sqrt 5 :: Double
        invSqrt5 = 1 / sqrt5 :: Double
        phi = (1 + sqrt5) / 2 :: Double
        psi = (1 - sqrt5) / 2 :: Double

fibFaster n = round expr
  where expr = (phi^n) / (sqrt 5)
        phi = (1 + sqrt 5) / 2

countDigits :: Integer -> Int
countDigits = length . show

cdFast n = 1 + floor (log10 n)

log10 x = (log x) / (log 10)

bigEnoughs n = filter pred $ map fibFast [1..]
  where pred = (>=n) . countDigits

solutionSlow = head $ bigEnoughs $ 1000


-- did a bit of math by hand..

solutionFast = ceiling $ ((log 10)*(999) + log(sqrt 5)) / (log phi)
  where phi = (1 + sqrt 5) / 2


