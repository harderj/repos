
import Data.List
import Data.Char

main = do c <- readFile "prob022_names.txt"
          let ns = loadNames c
              s = solution ns
          print s

test_names = "\"ANE\",\"JACOB\",\"MORTEN\",\"BODIL\""

names = loadNames test_names

alphPos :: Char -> Int
alphPos c = fromEnum (toLower c) - 96

alphVal :: String -> Int
alphVal = sum . map (alphPos)

solution names
  = let sl = sort names -- sorted list
        avs = map alphVal sl -- alphvalues
        wIds = zip avs [1..] -- with ids
        ps = map (\(x,y) -> x*y) wIds -- products
    in sum ps
        

loadNames :: String -> [String]
loadNames s = groups (`elem` "\",") s

--- THIS IS STOLEN FROM
---http://hackage.haskell.org/package/base-4.7.0.2/docs/src/Data-List.html#words
--- just made more general
groups :: (a -> Bool) -> [a] -> [[a]]
groups f s = case dropWhile f s of
  [] -> []
  s' -> w : groups f s''
    where (w, s'') =
            break f s'

