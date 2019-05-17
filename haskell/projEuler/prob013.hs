{-
jh@jacobharder.dk
project euler
problem 13
data file: prob013data.data
-}
import System.IO
import Data.List

dataFileName = "prob013data.data"
--dataFileName = "prob013testdata.data"

main = do
  handle <- openFile dataFileName ReadMode
  contents <- hGetContents handle
  putStrLn ("> Contens of " ++ dataFileName)
  putStrLn contents
  putStrLn "> Calculation"
  putStrLn $ show $ proc contents
  hClose handle

proc = calc . getList
getList = (map read) . words :: String -> [Integer]

calc = sum