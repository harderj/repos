module Perimeter (perimeter,
                  module Shape
                 ) where
import Shape
import Data.List

perimeter :: Shape -> Float
perimeter (Rectangle s1 s2) = 2 * (s1 + s2)
perimeter (RtTriangle s1 s2) = s1 + s2 + sqrt (s1^2 + s2^2)
perimeter (Polygon vts) = sum $ map (uncurry distBetween) $ bicycle vts
perimeter (Ellipse r1 r2)
  | r1 > r2   = ellipsePerim r1 r2
  | otherwise = ellipsePerim r2 r1
  where ellipsePerim r1 r2
          = let e = sqrt (r1^2 - r2^2)
                s = scanl aux (0.25 * e^2) [2..]
                aux s i = nextEl e s i
                test x = x > epsilon
                sSum = foldl (+) 0 (takeWhile test s)
            in 2 * r1 * pi * (1 - sSum)
--perimeter _ = error "'perimeter' is not completely defined yet"

epsilon = 0.0001 :: Float
nextEl :: Float -> Float -> Float -> Float
nextEl e s i = s * (2 * i - 1) * (2 * i - 3) * (e^2) / (4 * i^2)

-- auxiliary functions

bicycle :: [a] -> [(a, a)]
bicycle xs = zip xs $ drop 1 $ cycle xs

-- displacement activities

approksimatePi = putShows $ map ((/2) . perimeter . rPolygon) [1..20]

rPolygon n = Polygon [aux a | a <- [1..n]]
  where aux b = (cos c, sin c)
          where c = 2 * pi * b / n

putShows :: Show a => [a] -> IO ()
putShows = putStr . unlines . (map show)