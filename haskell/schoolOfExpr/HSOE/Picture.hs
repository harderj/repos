
-- -- REMINDER: replace (..) with this when all is defined


module Picture (Picture (Region, Over, EmptyPic),
                Color (Black, Blue, Green, Cyan,
                       Red, Magenta, Yellow, White),
                regionToGRegion, shapeToGRegion,
                drawRegionInWindow, drawPic, draw, spaceClose,
                module Region
               ) where

import Draw
import Region
import SOE hiding (Region)
import qualified SOE as G (Region)

data Picture = Region Color Region
             | Picture `Over` Picture
             | EmptyPic
             deriving Show

drawRegionInWindow :: Window -> Color -> Region -> IO ()
drawRegionInWindow w c r
  = drawInWindow w
      (withColor c
         (drawRegion (regionToGRegion r)))

drawPic :: Window -> Picture -> IO ()
drawPic w EmptyPic = return ()
drawPic w (pic1 `Over` pic2) = do drawPic w pic2; drawPic w pic1
drawPic w (Region c r) = drawRegionInWindow w c r

regionToGRegion :: Region -> G.Region
regionToGRegion r = regToGReg (0,0) (1,1) r

regToGReg :: Vector -> Vector -> Region -> G.Region
type Vector = (Float, Float)
regToGReg loc sca (Shape s)
  = shapeToGRegion loc sca s
regToGReg loc (sx, sy) (Scale (u, v) r)
  = regToGReg loc (sx * u, sy * v) r
regToGReg (lx, ly) sca (Translate (u, v) r)
  = regToGReg (lx * u, ly * v) sca r
regToGReg loc sca Empty
  = createRectangle (0, 0) (0, 0)
regToGReg loc sca (r1 `Union` r2)
  = primGReg loc sca r1 r2 orRegion
regToGReg loc sca (r1 `Intersect` r2)
  = primGReg loc sca r1 r2 andRegion
regToGReg loc sca (Complement r)
  = primGReg loc sca winRect r diffRegion

primGReg loc sca r1 r2 op
  = let gr1 = regToGReg loc sca r1
        gr2 = regToGReg loc sca r2
    in op gr1 gr2

winRect :: Region
winRect = Shape (Rectangle
                   (pixelToInch xWin) (pixelToInch yWin))

shapeToGRegion :: Vector -> Vector -> Shape -> G.Region
shapeToGRegion (lx, ly) (sx, sy) (Rectangle s1 s2)
  = createRectangle(trans(-s1/2,-s2/2))(trans(s1/2,s2/2))
    where trans(x, y) = (xWin2 + inchToPixel(lx + x * sx),
                         yWin2 + inchToPixel(ly + y * sy))

xWin2 = xWin `div` 2
yWin2 = yWin `div` 2

draw = error "ND"