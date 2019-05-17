import Data.Maybe
import Region

-- Exercise 8.1

oneCircle = Shape (Ellipse 1 1)
manyCircles = [Translate (x, 0) oneCircle | x <- [0,2..]]

fiveCircles = take 5 manyCircles
fiveCircles' = let m = intersectMany manyCircles
                   r = Translate (-1,-1) (Shape (Rectangle 10 2))
               in m `Intersect` r

intersectMany :: [Region] -> Region
intersectMany [] = Empty
intersectMany (r:rs) = r `Intersect` (intersectMany rs)

-- Exercise 8.2

-- area' :: Shape -> Float
-- area' (Rectangle s1 s2) = abs $ s1 * s2
-- ... this is not really funny

-- Exercise 8.3

annulus :: Radius -> Radius -> Region
annulus r1 r2 = Shape (Ellipse r1 r1) `difference` Shape (Ellipse r2 r2)

r1 `difference` r2 = r1 `Intersect` (Complement r2)

-- Exercise 8.4
-- Now I'm redefining 'containsS' so that is actually work.

type Matrix2x2 = ((Float, Float), (Float, Float))
det2 :: Matrix2x2 -> Float
det2 ((a, b), (c, d)) = a*d - b*c
type Line = (Coordinate, Coordinate)
intersection :: Line -> Line -> Coordinate
intersection ((x1, y1), (x2, y2)) ((x3, y3), (x4, y4))
  = let d1 = det2 ((x1, x2), (y1, y2))
        d2 = det2 ((x3, x4), (y3, y4))
        d3 = det2 ((x1 - x2, x3 - x4), (y1 - y2, y3 - y4))
        numX = det2 ((d1, d2), (x1 - x2, x3 - x4))
        numY = det2 ((d1, d2), (y1 - y2, y3 - y4))
        den = det2 ((x1 - x2, x3 - x4), (y1 - y2, y3 - y4))
    in (numX / den, numY / den)
type LineSeg = Line
containsRectangle :: (Coordinate, Coordinate) -> Coordinate -> Bool
containsRectangle ((x1', y1'), (x2', y2')) (x, y)
  = let (x1, y1) = (min x1' x2', min y1' y2')
        (x2, y2) = (max x1' x2', max y1' y2')
    in x1 <= x && x <= x2 && y1 <= y && y <= y2
lineIntersectLineSeg :: Line -> LineSeg -> Bool
lineIntersectLineSeg line (p1, p2)
  = let p = intersection line (p1, p2)
    in containsRectangle (p1, p2) p
type Ray = Line
rayIntersectLineSeg :: Ray -> LineSeg -> Bool
rayIntersectLineSeg ray lineSeg
  = let (x, y) = intersection ray lineSeg
        ((x1, y1), (x2, y2)) = ray
        sx = signum $ x2 - x1
        sy = signum $ y2 - y1
        rayTest = sx * (x - x1) >= 0 && sy * (y - y1) >= 0
    in lineIntersectLineSeg ray lineSeg && rayTest


bicycle xs = zip xs (drop 1 (cycle xs))
fromBool True = 1
fromBool False = 0
toBool 0 = False
toBool _ = True

-- containsPolygon :: [Vertex] -> Coordinate -> Bool
containsPolygon vts (x, y)
  = let pairs = bicycle vts
        f = rayIntersectLineSeg ((x, y), (x+1, y))
        n = sum $ map (fromBool . f) pairs :: (Integral a) => a
    in unlines [show (toBool (n `mod` 2)), show n]

pol1 = [(0,0),(0,5),(1,3),(2,5),(2,0),(1,2)] :: [Vertex]

-- Woaw det var haardt

-- Exercise 8.5

data Region' = HalfPlane Coordinate Coordinate
             | Snit Region' Region'
             | Tom
               
sub :: Coordinate -> Coordinate -> Coordinate
sub (x1, y1) (x2, y2) = (x1 - x2, y1 - y2)

containsS' :: Region' -> Coordinate -> Bool
containsS' Tom p = False
containsS' (Snit r1 r2) p
 = containsS' r1 p && containsS' r2 p
containsS' (HalfPlane p1 p2) p
  = let v = p2 `sub` p1
        p' = p `sub` p1
    in det2 (v, p') >= 0
       
hp1 = HalfPlane (0,1) (1,0)

-- Exercise 8.6
-- Only works if the vertices are oriented counterclockwise
polygon :: [Vertex] -> Region'
polygon vts = let pol :: [Vertex] -> Region'
                  pol (v1:v2:[])
                    = (HalfPlane v1 v2)
                  pol (v1:v2:vs)
                    = (HalfPlane v1 v2) `Snit` pol (v2:vs)
                  pol _ = Tom
              in pol (vts ++ (take 1 vts))

poly1 = polygon [(0,1),(1,0),(2,1),(1,2)]

-- Exercise 8.7

flipX = Scale ((-1), 1)
flipY = Scale (1, (-1))

