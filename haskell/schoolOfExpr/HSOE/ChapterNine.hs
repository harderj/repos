
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

-- twice f = f . f --  this would be cheating

twice f x =  f (f x)

-- twice :: (a -> a) -> a -> a
-- twice twice f x

-- twice :: (a -> a) -> a -> a
-- correct

-- twice twice :: (a -> a) -> a -> a
{- twice twice f x => twice f (twice f x)
                   => twice f (f (f x))
                   => f (f (f (f x))) -}
-- so twice twice applies a function 4 times

{- twice twice twice *args*
=> twice (twice twice) *args*
=> (twice twice) ((twice twice) *args*)
=> (twice twice) (twice (twice *args*))
=> twice (twice (twice (twice *args*))) -}
-- so twice twice twice applies a function maybe 8 times?
-- no! Actually 16 times.. gotta think that over
