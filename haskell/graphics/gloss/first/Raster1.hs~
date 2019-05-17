
import Graphics.Gloss
import Graphics.Gloss.Raster.Field
import Data.Complex

type Field = Point -> Color

main :: IO ()
-- main = undefined
-- main = display d c p
--   where d = display1
--         c = aquamarine
--         p = mandelbrot
-- main = displayField display1 mandelbrot2
main = displayField' display1 mandelbrot2

displayField' w im
  = display w white (makePicture 500 500 1 1 im)
--displayField w im = animateField w (10, 10) (\t -> im)

dSize1 = (600, 600) :: (Int, Int)
dPos1 = (10, 10) :: (Int, Int)
display1 = InWindow "Hello" dSize1 dPos1

image1 :: Field
image1 (x, y) = rgb r g b
  where r = bound 0 1 x
        g = bound 0 1 y
        b = 0
image2 _ = greyScale 0.5
image3 (x, y) = greyScale $ bound 0 1 x
image4 = greyScale . magnitude . toC

fromBool :: Num a => Bool -> a
fromBool True = 0
fromBool False = 1

mandelbrot = greyScale . fromBool . (mandelbrotN 10) . toC
mandelbrot2 = colorScheme1
              . magnitude
              . (mandelN 10)
              . (+ ((-0.5):+0)) . (*1.5)
              . toC

rTo01 = (/(pi/2)) . atan . log

colorScheme1 :: Float -> Color
colorScheme1 x = makeColor r g b 1
  where (r, g, b) = if x < 2
                    then (1, 1, x/2)
                    else (rTo01 x, 1, 1)

floor' :: (RealFrac a, Num b) => a -> b
floor' = fromIntegral . floor

toC :: Point -> Complex Float
toC (x, y) = x:+y

bound :: Ord a => a -> a -> a -> a
bound a b x = min b (max a x)


greyScale f = greyN f

mandelbrotN :: RealFloat a => Int -> Complex a -> Bool
mandelbrotN n = (2>) . magnitude . (mandelN n)

mandelN :: RealFloat a => Int -> Complex a -> Complex a
mandelN n z = (iterate f z) !! n
  where f w = w^2 + z

mandelMag n = magnitude . (mandelN n) . toC
