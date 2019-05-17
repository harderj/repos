-- Jacob Harder 21-03-2014
-- solution to problem number 10
-- from projecteuler.net

-- find the sum of all primes below 2 million

import Data.Numbers.Primes

sqrtFloor n = floor $ sqrt $ fromIntegral n

prime n = all (\x -> (mod n x /= 0)) [2..sqrtFloor n]

listPrimesBelow n =
  filter prime [2..(n-1)]

step1 = sum $ listPrimesBelow 2000000

-- new solution 19-12-2017

problem10 = sum $ takeWhile (<m) $ wheelSieve j
  where m = 2*10^6
        k = ceiling $ sqrt $ fromIntegral m -- this is 1415
        j = 223 -- the 223th prime is 1423
