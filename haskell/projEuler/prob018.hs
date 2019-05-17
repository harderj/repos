

--import System.IO
import Data.List

main = do
  c <- readFile "prob018.data"
  let d = readData c
      n = length d
      lookups = genWays n :: [[Int]]
      paths = map (path d) lookups :: [[Int]]
      sums = map sum paths :: [Int]
  print (maximum sums)

test = [[3],[7,4],[2,4,6],[8,5,9,3]] :: [[Int]]

--path :: [[Int]] -> [Int] -> [Int]
path = zipWith (!!)

readData c =
  let ls = lines c
      raw = map words ls
      d = map (map read) raw :: [[Int]]
  in d

genWays :: Int -> [[Int]]
genWays n =
  let wds = allWords (n-1)
  in map ((0:) . accumulate) wds

accumulate :: [Int] -> [Int]
accumulate = acc 0
  where acc :: Int -> [Int] -> [Int]
        acc m [] = []
        acc m (x:xs) = (m + x) : acc (m + x) xs

allWords n = (iterate newWords [[]]) !! n
  where newWords wds = (map (0:) wds) ++ (map (1:) wds)
