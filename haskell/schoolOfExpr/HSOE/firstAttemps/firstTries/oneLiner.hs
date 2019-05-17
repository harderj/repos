
data Vec2D a = Vec2D a a
instance Num a => Num (Vec2D a) where
  (Vec2D x1 y1) + (Vec2D x2 y2)= Vec2D (x1+x2) (y1+y2)
  negate (Vec2D x1 y1) = Vec2D (negate x1) (negate y1)
  
det (Vec2D x1 y1) (Vec2D x2 y2) = x1*y2 - x2*y1
eps = 0.001
convex2 vs = foldr1 (==) . map (<0) . filter (<eps) . map (uncurry det) . take (length vs) $ zipWith3 toVec vsc (drop 1 vsc) (drop 2 vsc)
  where toVec x y z = (x-y,z-y)
        vsc = cycle vs