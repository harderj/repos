
simple x y z = x * (y + z)


-- Exercise 9.4

applyEach [] v = []
applyEach (f:fs) v = (f v) : applyEach fs v

-- how to make this with high-order functions?

-- Exercise 9.5

applyAll [] v = v
applyAll (f:fs) v = f $ applyAll fs v

-- i can't make these higherorder...

-- Exercise 9.6
-- I don't know :(

-- Exercise 9.7
twice :: (a -> a) -> a -> a
twice f = f . f
t = twice -- this abbrivation becomes handy for the follwing explainations
-- t t :: (a -> a) -> a -> a
-- the type of t can be interpreted: (b -> b) -> (b -> b)
-- making it a type (a -> a) function,
-- thus enabling it to fit into itself.
-- wasting my time explaining..
-- reaching my level of understanding I can conclude:
-- t t = t . t = t^2
-- t t t = (t . t) t = t^2 t = t t^2 = t^4
-- t t t f = t^4 f = t^3 f^2 = t^2 f^4 = t f^8 = f^16
-- t t t :: (a -> a) -> a -> a
-- t (t t) = t t^2 = t^4 = t t t
-- this is a wierd function, reflecting over it

-- Exercise 9.8
power :: (a -> a) -> Integer -> (a -> a)
power f 0 = id
power f n = f . (power f (n-1))

magicCosine = power cos 100 0 -- damn.. not usefull at all.

-- Exercise 9.9
fix f = f (fix f)
fix :: (a -> a) -> a
--remainder :: Integer -> Integer -> Integer
--remainder = fix (\a -> if a < 4 then (\a' -> 
--                         else a - b)
-- Wow, I couldn't do this.

-- Exercise 9.10
-- rewrite: map (\x -> (x + 1)/2) xs :using composition of sections.
-- what do they mean by 'of sections?'
-- best answer: map ((/2) . (+1)) xs

-- Exercise 9.11
-- map (f . g) xs
-- map (/2) (map (+1) xs)

-- Exercise 9.12
-- too long

-- Exercise 9.13
-- f2 = map
-- f1 = applyEach
f1 = applyEach
f2 = map
e9_13 = f1 (f2 (*) [1,2,3,4]) 5

