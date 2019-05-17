module SimpleGraphics where
import SOE

--main = do main0
--          main1

main0
  = runGraphics (
    do w <- openWindow
            "My First Graphics Program" (300,300)
       drawInWindow w (text (100,200) "HelloGraphicsWorld")
       k <- getKey w
       closeWindow w
    )

-- Exercise 3.1

putStr' :: String -> IO ()
putStr' "" = return ()
putStr' (c:cs) = do putChar c
                    putStr' cs

getLine' :: IO String
getLine' = do c <- getChar
              if c == '\n'
                then return ""
                else do rest <- getLine'
                        return $ c:rest

-- Exercise 3.2

-- dont use: *, abs, signum and fromInteger,
-- since they are not probably defined

data Vect2 a = Vect2 a a
instance Num a => Num (Vect2 a) where
  (Vect2 a1 b1) + (Vect2 a2 b2) = Vect2 (a1 + a2) (b1 + b2)
  negate (Vect2 a b) = Vect2 (negate a) (negate b)
  (Vect2 a1 b1) - (Vect2 a2 b2) = Vect2 (a1 - a2) (b1 - b2)
  (Vect2 a1 b1) * (Vect2 a2 b2) = Vect2 (a1 * a2) (b1 * b2)
  abs (Vect2 a b) = Vect2 (abs a) (abs b)
  signum (Vect2 a b) = Vect2 (signum a) (signum b)
  fromInteger n = Vect2 (fromInteger n) (fromInteger n)
instance Show a => Show (Vect2 a) where
  show (Vect2 a b) = "Vect2 " ++ show a ++ " " ++ show b

toPoint :: RealFrac a => Vect2 a -> Point
toPoint (Vect2 x y) = (round x, round y)

regularPolygon :: Vect2 Double -> Double -> Double -> Int -> [Vect2 Double]
regularPolygon (Vect2 x y) size angle n
  = let h m = let v = 2 * pi * m' / n' + angle
                  m' = fromIntegral m
                  n' = fromIntegral n
              in Vect2 (x + size * sin(v)) (y + size * cos(v))
    in map h [1..n]

minSize :: Double
minSize = 8

snowFlake :: Window -> Vect2 Double -> Double -> IO ()
snowFlake w p s = do eqlTri w p (s/2) 0 White
                     eqlTri w p (s/2) pi White
                     flakes w p (s/2) Blue

flakes :: Window -> Vect2 Double -> Double -> Color -> IO ()
flakes w p s c
  = let ps = regularPolygon p (2*s/3) 0 6
        f :: (Vect2 Double, Bool) -> IO () -- 
        f (pt, d) = flake w pt (s/3) c d
    in sequence_ $ map f $ zip ps $ cycle [False, True]

flake w p s c b = if s >= minSize
                  then do eqlTri w p s (pi * iverson b) c
                          flakes w p s $ nextColor c
                  else return ()

nextColor :: Color -> Color
nextColor White = Black
nextColor c = succ c

eqlTri w p s a c = drawInWindow w $ withColor c $ polygon $ map toPoint $ regularPolygon p s a 3

iverson :: Num a => Bool -> a
iverson True = 1
iverson False = 0

main1
  = runGraphics (
    do w <- openWindow "Snowflake Fractal" (500,500)
       snowFlake w (Vect2 250 250) 500
       k <- getKey w
       closeWindow w
       )

-- flake :: Window -> Int -> Int -> Int -> IO ()
-- flake w x y size
--   = drawInWindow w (withColor Blue 
--                     (polygon [(x - 2 * s, y + s), (x + 2 * s, y + s), (x, y - 2 * s)]))
--   where s = size `div` 3

-- -- downTri :: Window -> Int -> Int -> Int -> IO ()
-- -- downTri w x y size
-- --   = drawInWindow w (withColor Blue 
-- --                     (polygon [(x-s,y-s),(x+s,y-s),(x,y+s)]))
-- --   where s = size `div` 2

-- flakes w x y size 1 = flake w x y size
-- flakes w x y size n
--   = let s = size `div` 3
--     in do flakes w (x - s) (y - s) s (n - 1)
--           flakes w (x + s) (y - s) s (n - 1)
--           flakes w x       (y + s) s (n - 1)

-- snowFlake w x y size n = sequence_ [flakes w x y size m | m <- [1..n]]

