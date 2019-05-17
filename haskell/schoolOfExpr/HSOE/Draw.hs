module Draw (inchToPixel,
             pixelToInch,
             intToFloat,
             xWin, yWin,
             trans,
             shapeToGraphic,
             spaceClose,
             drawShapes, -- these last two are not added in the book, I think
             ColoredShapes -- ...
            ) where

import Shape
import SOE

inchToPixel :: Float -> Int
inchToPixel x = round (100 * x) -- assume there are 100 pxls / inch
inchToPixel' = round . (100 * ) -- couldn't stop myself

pixelToInch :: Int -> Float
pixelToInch n = intToFloat n/100

intToFloat :: Int -> Float
intToFloat n = fromInteger (toInteger n)

-- Exercise 4.2
-- Because that would be very imprecise, and aethestically damaging.

xWin, yWin :: Int
xWin = 600
yWin = 500

trans :: Vertex -> Point
trans (x, y)
  = let x' = inchToPixel x
        y' = negate . inchToPixel $ y
    in (x' + xWin2, y' + yWin2)

-- trans (0, 0) = (xWin2, yWin2)

xWin2, yWin2 :: Int
xWin2 = xWin `div` 2
yWin2 = yWin `div` 2

transList :: [Vertex] -> [Point]
transList [] = []
transList (vt:vts) = trans vt : transList vts
-- in the book: transList (p:ps) = ...
-- I find that this is actually misleading,
-- since our input is vertices, not points
-- - they are the output!

shapeToGraphic :: Shape -> Graphic
shapeToGraphic (Rectangle s1 s2)
  = let s12 = s1 / 2
        s22 = s2 / 2
    in polygon (transList [(-s12, -s22),
                           (-s12,  s22),
                           ( s12,  s22),
                           ( s12, -s22)])
shapeToGraphic (Ellipse r1 r2)
  = ellipse (trans (-r1, -r2)) (trans (r1, r2))
shapeToGraphic (RtTriangle s1 s2)
  = polygon (transList [(0, 0), (s1, 0), (0, s2)])
shapeToGraphic (Polygon vts) = polygon . transList $ vts

-- Some Examples
sh1, sh2, sh3, sh4 :: Shape
sh1 = Rectangle 3 2
sh2 = Ellipse 1 1.5
sh3 = RtTriangle 3 2
sh4 = Polygon [(-2.5,  2.5),
               (-1.5,  2.0),
               (-1.1,  0.2),
               (-1.7, -1.0),
               (-3.0,  0.0)]

main0 = do w <- openWindow "Drawing Shapes" (xWin, yWin)
           drawInWindow w $ withColor Red  $ shapeToGraphic sh1
           drawInWindow w $ withColor Blue $ shapeToGraphic sh2
           spaceClose w

type ColoredShapes = [(Color,Shape)]

shs :: ColoredShapes
shs = [(Red, sh1), (Blue, sh2), (Yellow, sh3), (Magenta, sh4)]

drawShapes :: Window -> ColoredShapes -> IO ()
drawShapes w [] = return ()
drawShapes w ((c,s):cs)
  = do drawInWindow w $ withColor c $ shapeToGraphic s
       drawShapes w cs

main1 = do w <- openWindow "Drawing Shapes" (xWin, yWin)
           drawShapes w shs
           spaceClose w

-- == out of chronology == --

spaceClose :: Window -> IO ()
-- spaceClose w
--   = do k <- getKey w
--        if k == ' '
--          then closeWindow w
--          else spaceClose w
-- -- my getKey if not working properly so
-- -- I define spaceClose differently:
spaceClose w = do k <- getKey w
                  closeWindow w