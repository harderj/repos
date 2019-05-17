
import Graphics.Gloss
import Graphics.Gloss.Data.Picture as P
import Numeric.Matrix as M hiding (map)
--import Data.Complex

main = do
  -- bmp <- loadBMP "bird.bmp"
  -- disp (Rotate 90 bmp)
  -- rotatePic bmp
  
  lerpPolygon path2 lerpM affine1 (unit 4)

affine1 = (transM 100 100 0) * (rotMXY pi)

lerpPolygon :: Path
            -> Lerp
            -> Affine
            -> Affine
            -> IO ()
lerpPolygon path lerp m1 m2
  = animate dis1 white polygon
    where polygon t = Color (greyN 0.2) (Polygon (newPath t))
          newPath t = map ((mat t) *.) path
          mat t = lerp m1 m2 t

path2 = [(-10,-20)
        ,(  0, 30)
        ,( 10,  0)
        ,( 20, 10)
        ,( 30,-10)] :: Path

rotatePic p = animate dis1 white (\t -> (Rotate (t * rad pi) p))

proc1 = display dis1 white pic1

proc2 = display dis1 blue pic2

proc3 = display dis1 white pic3

disp = display dis1 white

dis1 = InWindow "Dis1" (500,500) (10,10)

pic1 = Blank

pic2 = color green $ ThickCircle 10 10

path1 = [(-40,-40)
        ,(-40,40)
        ,(40,-40)] :: [(Float, Float)]

pic3 = color red $ Polygon path1

pic4 = Pictures [pic3
                ,Translate (20) (-30) pic2]

type Affine = Matrix Float

(*.) :: Affine -> Point -> Point
m *. (x, y) = (nx, ny) where
  nx : ny : _ = concat $ toList prod
  prod = m `times` (fromList [[x], [y], [0], [1]])

pic5 = Pictures [pic3
                ,color blue (Polygon (map (mat *.) path1))]
  where mat = transM 100 (-50) 0

getScale :: Affine -> (Float, Float, Float)
getScale m = let m3 = minorMatrix m (4,4)
                 rs = map ((flip row) m3) [1,2,3]
                 r1 = map (map (^2)) rs
                 r2 = map sum r1
                 r3 = map sqrt r2
                 [x, y, z] = r3
             in (x, y, z)

getRotXY :: Affine -> Float
getRotXY m = let c = col 1 m
                 [a, b] = take 2 c
             in atan2 b a

getTrans :: Affine -> (Float, Float, Float)
getTrans m = let c = col 4 m
                 [x, y, z] = take 3 c
             in (x, y, z)

transM :: Float -> Float -> Float -> Affine
transM x y z = fromList list
  where list = [[1,0,0,x]
               ,[0,1,0,y]
               ,[0,0,1,z]
               ,[0,0,0,1]]

rotMXY :: Float -> Affine
rotMXY x = fromList [[ cos x,-sin x, 0, 0]
                    ,[ sin x, cos x, 0, 0]
                    ,[0,0,1,0]
                    ,[0,0,0,1]]

scaleM :: Float -> Float -> Float -> Affine
scaleM x y z = fromList list
  where list = [[x, 0, 0, 0]
               ,[0, y, 0, 0]
               ,[0, 0, z, 0]
               ,[0, 0, 0, 1]]

wAveM :: MatrixElement a => [(Matrix a, a)] -> Matrix a
wAveM = (foldr1 (+)) . (map (\(m, k) -> k .* m))
-- wAveM = sum . (map (\(m, k) -> k .* m))
-- why does this not work? Exception: Matrix.plus dimensions don't match

(.*) :: MatrixElement a => a -> Matrix a -> Matrix a
k .* m = fromList modList
  where list = toList m
        modList = (map (map (*k))) list

-- lerpM :: (MatrixElement e)
--          => Matrix e
--          -> Matrix e
--          -> e
--          -> Matrix e
lerpM :: Lerp
lerpM m1 m2 t = wAveM [(m1, 1-t), (m2, t)]

type Lerp = Affine
            -> Affine
            -> Float
            -> Affine 

lerpUXY :: Lerp
lerpUXY m1 m2 t = let
  [r1, r2] = map getRotXY [m1, m2]
  [s1, s2] = map getScale [m1, m2]
  [t1, t2] = map getTrans [m1, m2]
  h (x, y, z) = [x, y, z]
  d1 = (r1 : (take 2 (h s1))) ++ (take 2 (h t1))
  d2 = (r2 : (take 2 (h s2))) ++ (take 2 (h t2))
  d = zip d1 d2
  lerped = map (\(v1, v2) -> (1-t) * v1 + t * v2) d
  [r, sx, sy, tx, ty] = lerped
  in (transM tx ty 0) * (scaleM sx sy 1) * (rotMXY r)

-- class Scalable a where
--   (.*) :: Num a => a -> a -> a

-- instance MatrixElement e => Scalable (Matrix e) where
--   k .* m = (fromList . (map (map (*k))) . toList) m

matrixMap f = fromList . (map (map f)) . toList

deg = (*(pi/180)) :: Floating a => a -> a
rad = (*(180/pi)) :: Floating a => a -> a
