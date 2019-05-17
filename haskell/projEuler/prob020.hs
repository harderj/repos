-- ...

fac 0 = 1
fac n = n * fac (n - 1)

toDig :: Integer -> [Int]
toDig = (map (read . h)) . show
  where h c = c:""

digSum :: Integer -> Integer
digSum = toInteger . sum . toDig

facDigSum :: Integer -> Integer
facDigSum = digSum . fac

solution = facDigSum 100