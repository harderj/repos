
module Shape (Shape (Rectangle,
                     Ellipse,
                     RtTriangle,
                     Polygon),
              Radius, Side, Vertex,
              square, circle, area
             ) where

data Shape = Rectangle Side Side
           | Ellipse Radius Radius
           | RtTriangle Side Side
           | Polygon [Vertex]
           deriving Show
                    
type Radius = Float
type Side   = Float
type Vertex = (Float,Float)

square s = Rectangle s s
circle r = Ellipse r r

-- Exercise 2.1
rectangle :: Side -> Side -> Shape
rectangle w h = Polygon [(0,0),(0,w),(w,h),(0,h)]

rtTriangle :: Side -> Side -> Shape
rtTriangle w h = Polygon [(0,0),(0,w),(w,h)]

-- Exercise 2.2
regularPolygon :: Int -> Side -> Shape
regularPolygon n s = let h :: Int -> Vertex
                         h m = let a = 2*pi*m'/n'
                                   m' = fromIntegral m
                                   n' = fromIntegral n
                               in (s*cos(a),s*sin(a))
                     in Polygon $ map h [1..n]

-- Exercise 2.4

trizip :: [a] -> [b] -> [c] -> [(a,b,c)]
trizip (x:xs) (y:ys) (z:zs) = (x,y,z) : trizip xs ys zs
trizip _ _ _ = []

parallelogram :: (Vertex, Vertex) -> Float
parallelogram ((x1, y1), (x2, y2)) = x1*y2 - x2*y1

twocycle :: [a] -> [(a,a)]
twocycle (x:xs) = zip (x : xs) (xs ++ [x])

tricycle :: [a] -> [(a,a,a)]
tricycle (x1:x2:xs) = trizip (x1:x2:xs) ((x2:xs) ++ [x1]) (xs ++ [x1,x2])

toVectors :: (Vertex, Vertex, Vertex) -> (Vertex, Vertex)
toVectors ((x1,y1),(x2,y2),(x3,y3)) = ((x1-x2,y1-y2),(x3-x2,y3-y2))

same :: (Eq a) => [a] -> Bool
same (x:xs) = and $ map (x==) xs

convex :: Shape -> Bool
convex (Polygon vs)
  = same $ map ((0<) . parallelogram . toVectors) $ tricycle vs
-- convex (Polygon (v1:v2:vs)) = 
--   let h :: (Vertex,Vertex,Vertex) -> Bool
--       h ((x1, y1), (x2,y2), (x3,y3))
--         = (0 < parallelogram ((x3 - x2, y3 - y2), (x1 - x2, y1 - y2)))
--       (x : xs) = map h $ trizip (v1:v2:vs) ((v2:vs) ++ [v1]) (vs ++ [v1,v2])
--   in and $ map (==x) xs 
convex _ = True

-- Exercise 2.5
-- alternative polygon area calc
area :: Shape -> Float
area (Rectangle s1 s2) = s1*s2
area (Ellipse r1 r2) = pi*r1*r2
area (RtTriangle s1 s2) = s1*s2/2
area (Polygon (v1:vs)) = abs $ sum $ map h $ twocycle vs
  where h :: (Vertex, Vertex) -> Float
        h ((x1,y1), (x2,y2)) = (x2-x1)*(y1+y2)/2
area (Polygon _) = 0
