
module Geometry
       ( sphereVolume
       , sphereArea
       , cubeVolume
       , cubeArea
       , cuboidVolume
       , cuboidArea
       ) where

sphereVolume :: Float -> Float
sphereVolume r = (4.0 / 3.0) * pi * r ^ 3

sphereArea :: Float -> Float
sphereArea r = 4 * pi * r ^ 2

cubeVolume :: Float -> Float
cubeVolume side = cuboidVolume side side side

cubeArea :: Float -> Float
cubeArea side = cuboidArea side side side

cuboidVolume :: Float -> Float -> Float -> Float
cuboidVolume a b c = rectangleArea a b * c

cuboidArea :: Float -> Float -> Float -> Float
cuboidArea a b c =
  2 * (rectangleArea a b + rectangleArea a c + rectangleArea b c)

rectangleArea :: Float -> Float -> Float
rectangleArea a b = a * b