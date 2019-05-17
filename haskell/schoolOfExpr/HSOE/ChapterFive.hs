

import Draw
import Shape
import SOE

conCircles = map circle [2.4,2.1..0.3]
coloredCircles = zip [(Black)..] conCircles

main0 = runGraphics (
  do w <- openWindow "Bull's Eye" (xWin, yWin)
     drawShapes w coloredCircles
     spaceClose w
  )

-- Exercise 5.1

area' :: Shape -> Float
area' (Polygon vts) = abs $ sum $ map trapezArea $ bicycle vts
  where trapezArea :: (Vertex, Vertex) -> Float
        trapezArea ((x1, y1), (x2, y2))
          = (x2 - x1) * (y2 + y1) / 2
area' otherShapes = area otherShapes
-- not tested properly, but it does calculate:
-- area' $ Polygon [(1,0),(0,1),(-1,0),(0,-1)]
-- correctly to be: 2.0

bicycle :: [a] -> [(a, a)]
bicycle xs = zip xs $ drop 1 $ cycle xs

-- Exercise 5.2
-- "
-- What is the principal type of each of the following expressions:
-- map map
-- map foldl
-- "
-- Answer:
-- map :: (a -> b) -> [a] -> [b]
-- so my best guess is..
-- map map :: [(a -> b) -> [a]] -> [b]
-- oh fuck.. it was
-- map map :: [a -> b] -> [[a] -> [b]]
-- how come?
-- aha, its because if
-- g :: a -> b -> c
-- (an example could be: g _ _ = error "")
-- then map g :: [a] -> [b -> c]
--
-- now about the map foldl:
-- let me for the sake of getting started rewrite the foldfunctions
--
-- foldRight :: (a -> b -> b) -> b -> [a] -> b
-- foldRight f last [] = last
-- foldRight f last (first : rest) = f first $ foldRight f last rest
--
-- foldLeft :: (a -> b -> a) -> a -> [b] -> a
-- foldLeft f first [] = first
-- foldLeft f first (second : rest) = foldLeft f (f first second) rest
--
-- well then. What is the type of map foldl?
-- best guess would be:
-- map foldl :: [a -> b -> a] -> [[a -> [b]] -> [a]]
-- oooops wrong again.. the answer was:
-- map foldl :: [a -> b -> a] -> [a -> [b] -> a]
-- moving on..

-- Exercise 5.3
-- "Rewrite 'length' nonrecursively"

length' :: Integral n => [a] -> n
length' xs = foldl (\x y -> x + 1) 0 xs

-- Exercise 5.4
-- I've denoted the recursive functions with a >>'<< in the function name

doubleEach, doubleEach' :: Num a => [a] -> [a]
doubleEach = map (2*)
doubleEach' [] = []
doubleEach' (x:xs) = 2 * x : doubleEach' xs

pairAndOne, pairAndOne' :: Num a => [a] -> [(a,a)]
pairAndOne = map (\x -> (x, x + 1))
pairAndOne' [] = []
pairAndOne' (x:xs) = (x, x + 1) : pairAndOne' xs

addEachPair, addEachPair' :: Num a => [(a, a)] -> [a]
addEachPair = map (uncurry (+))
addEachPair' [] = []
addEachPair' ((a, b) : pairs) = a + b : addEachPair pairs

-- Exercise 5.5
-- define a function 'maxList' that returns the maximum element in a list
-- similarly define 'minList'
maxList :: Ord a => [a] -> a
maxList = foldl1 max

minList :: Ord a => [a] -> a
minList = foldl1 min

-- Exercise 5.6
addPairsPointwise :: Num a => [(a, a)] -> (a, a)
addPairsPointwise = foldl (\(a, b) (c, d) -> (a + c, b + d)) (0, 0)

-- Exercise 5.7
encrypt, decrypt :: String -> String
encrypt = map (toEnum . (  1  +) . fromEnum)
decrypt = map (toEnum . ((-1) +) . fromEnum)

-- Exercise 5.8
makeChange :: Int -> [Int] -> [Int]
makeChange 0 cs = map (\x -> 0) cs
makeChange n [] = error "Can't make change with no coins"
makeChange n (c:cs)
  = let rm = n `rem` c
        dv = n `div` c
    in dv : (makeChange rm cs)
-- this is not correct, but not optimal, damn it

