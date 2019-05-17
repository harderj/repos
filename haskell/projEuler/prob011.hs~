
-- Jacob Harder, 2/4-2014

-- project euler problem 11

--import System.IO

import Data.List
import qualified Data.Vector 
import Data.Matrix hiding (transpose)

main :: IO ()
main = do
  c <- readFile "prob011.data"
  let m = readMatrix c :: Matrix Int
  print $ solution m

solution = maximum . (map product) . fourUp

testM = fromLists [[1,2,3,0,8],
                   [7,7,2,1,3],
                   [2,4,1,2,6],
                   [4,5,6,7,8],
                   [0,0,1,1,9]] :: Matrix Int

testM2 = setSize 0 4 4 testM

readMatrix :: Read a => String -> Matrix a
readMatrix = lines
             >>> (map words)
             >>> (map (map read))
             >>> fromLists

(>>>) :: (a -> b) -> (b -> c) -> (a -> c)
a >>> b = b . a

printMatrix :: Show a => Matrix a -> IO ()
printMatrix = putStrLn . prettyMatrix

mirror :: Matrix a -> Matrix a
mirror = toLists >>> reverse >>> fromLists

diag = getDiag >>> Data.Vector.toList

fourUp :: Matrix a -> [[a]]
fourUp mat =
  let ms = submatrices 4 4 mat
      h = toLists -- horizontal
      v = toLists >>> transpose -- vertical
      d m = (diag m) : [diag (mirror m)]
      all m = h m ++ v m ++ d m
  in concatMap all ms

submatrices :: Int -> Int -> Matrix a -> [Matrix a]
submatrices n m mat =
  let (x, y) = (ncols mat, nrows mat)
  in [submatrix i (i+n-1) j (j+m-1) mat
     | i <- [1..(x-n+1)], j <- [1..(y-m+1)]]

-- ... previous attempt.. dont know what went wrong..

-- dataFileName = "prob11_matrix.txt"

-- main = do  
--   handle <- openFile dataFileName ReadMode
--   contents <- hGetContents handle
--   putStrLn ("\nLoading " ++ dataFileName ++ " ...")
--   -- putStrLn contents
--   putStrLn ("Calculating ... ")
--   putStrLn $ show $ findMaxProd $ toMatrix contents
--   hClose handle

-- findMaxProd :: Matrix Int -> Int
-- findMaxProd = maximum . (map product) . takeFours

-- type Matrix a = [[a]]
-- type Indices = (Int, Int)

-- tMat :: Indices -> Matrix Int
-- tMat (n, m) = [[(k+1)..(k+m)] | k <- [0,m..(n-1)*m]]

-- getRow :: Matrix a -> Int -> [a]
-- getRow mat n = mat !! (n-1)
-- getCol :: Matrix a -> Int -> [a]
-- getCol mat m = map (!! (m-1)) mat

-- --toMatrix :: (Read r) => String -> Matrix r
-- toMatrix = ((map . map) read) . (map words) . lines

-- takeFourDiag :: Matrix a -> Indices -> [a]
-- takeFourDiag mat (i,j) =
--   let n = length mat
--       m = length (mat !! 0)
--   in [mat !! (i-1) !! (j-1),
--       mat !! (i+0) !! (j+0),
--       mat !! (i+1) !! (j+1),
--       mat !! (i+2) !! (j+2)]

-- getI a b = (take (b-a+1)) . (drop (a-1))

-- takeFourRow :: Matrix a -> Indices -> [a]
-- takeFourRow mat (i,j)
--   = getI j (j+3) $ getRow mat i

-- takeFourCol :: Matrix a -> Indices -> [a]
-- takeFourCol mat (i,j)
--   = getI i (i+3) $ getCol mat j

-- takeFours mat =
--   let n = length mat
--       m = length (mat !! 0)
--       d = map (takeFourDiag mat) [(x,y) | x <- [1..n-3], y <- [1..m-3]]
--       r = map (takeFourRow mat) [(x,y) | x <- [1..n], y <- [1..m]]
--       c = map (takeFourCol mat) [(x,y) | x <- [1..n], y <- [1..m]]
--   in d ++ r ++ c
