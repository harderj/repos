
import Data.Ratio

dgs :: (Num a, Show a, Read a) => a -> [a]
dgs = (map (read . (\c -> [c]))) . show

nmb :: (Num a, Show a, Read a) => [a] -> a
nmb = read . (map (head . show))

step1 = [(a,b) |
         a <- list,
         b <- list,
         a < b,
         condition a b]
  where list = filter (\n -> mod n 10 /= 0) [11..99]

condition x y =
  let x1:x2:_= dgs x
      y1:y2:_= dgs y
      xdy = x % y
  in (x2 == y2 && x1 % y1 == xdy)
     || (x1 == y2 && x2 % y1 == xdy)
     || (x2 == y1 && x1 % y2 == xdy)
     || (x1 == y1 && x2 % y2 == xdy)

solution = product $ map (\(a,b) -> (a % b))  step1
