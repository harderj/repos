-- Jacob Harder, 21-03-2014
-- solution to prob9
-- from projecteuler.net

-- a Pythagorian triple is three natural numbers,
-- a, b and c with a < b < c and a^2 + b^2 = c^2.
-- there's exactly one such triple such that
-- a + b + c = 1000
-- find the product a*b*c of that unique
-- Pythagorian tripe.

step1 = [ a*b*c |
         c <- [1..1000],
         b <- [1..(c-1)],
         a <- [1..(b-1)],
         a^2 + b^2 == c^2,
         a+b+c == 1000 ]
