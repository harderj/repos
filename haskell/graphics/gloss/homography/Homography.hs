module Homography where

import Graphics.Gloss

import Numeric.Matrix

type Camera = Matrix Double

type Scene = [Object]

data Object = Parent Transform Form [Object]
            | Child Transform Form

type Transform = Matrix Double

data Form = Point
          | Mesh

render3d :: Camera -> Scene -> Picture
render3d = undefined





