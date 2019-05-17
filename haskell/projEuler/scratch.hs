
import Data.List

main = do
  putStrLn "This is a demo of one among many functions in the code.\nEnter number to be prime factorized: "
  input <- getLine
  putStrLn $ show $ pfacts (read input)

fib :: Integer -> Integer
fib 0 = 0
fib 1 = 1
fib n = if n > 0
        then fib (n-1) + fib (n-2)
        else fib (n+2) - fib (n+1)

-- the golden ratio and the other root of x^2 - x - 1
phi :: Double
phi = (1 + sqrt 5) / 2
cophi :: Double
cophi = (1 - sqrt 5) / 2

-- fast fibonacci function
-- error for negative n
-- prob. not correct for 'very large n' due to use of floating point values
fastFib :: Integer -> Integer
fastFib 0 = 0
fastFib 1 = 1
fastFib n = round $ (phi^n + cophi^n) / sqrt 5

-- fib n is even iff. 3 divides n (unproved spontaneous proposition)
evenFib n = fastFib $ 3 * n

prob2 =
  let h n =
        let f = evenFib n in
        if f > 4*10^6 then [] else f : h (n+1)
  in sum $ h 1

pfacts n =
  let h 1 p = []
      h n p = if mod n p == 0
              then p : (h (div n p) p)
              else h n (p + 1)
  in h n 2

-- the very big number in prob3.
bigNumberProb3 :: Integer
bigNumberProb3 = 600851475143

biggestPrimeFactor = head . reverse . pfacts

prob3 = biggestPrimeFactor bigNumberProb3

-- short digress from proj. Euler problems
factorial 0 = 1
factorial n = n * factorial (n - 1)

digress1 = pfacts . factorial -- hmm not than fun

-- I couldn't make the function returning the n'th prime elegantly
-- though I thought about it for 10 minutes... :(

-- back to proj. Euler.

palindrome n = show n == (reverse $ show n)

maks = head . reverse . sort

prob4 = maks $ filter palindrome [x*y | x <- [100..999], y <- [100..x]]

mfm (n : []) = n
mfm (n : ns) = lcm n $ mfm ns

prob5 = mfm [1..20]

sumOfSqs n = sum $ map (\x -> x*x) [1..n]

sqOfSum n = let s = sum [1..n] in s*s

prob6 = (\x -> sqOfSum x - sumOfSqs x) 100

listPrimes 1 = [2]
listPrimes 2 = [3,2]
listPrimes n =
  let l = listPrimes (n-1)
      h m = if all (\x -> mod m x /= 0) [2..sqrtFloor m]
            then m else h (m+2)
  in (h (head l + 2)) : l

sqrtFloor = floor . sqrt . fromIntegral

prob7 = head $ listPrimes 10001
