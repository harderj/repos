module Kata.Cut.Cake (cut) where

import Data.Ord (comparing)
import Data.List (sortBy, findIndex)

                         
data CakeElem = Raisin | NoRaisin | Taken deriving Eq
instance Show CakeElem where
  show Raisin = "o"
  show NoRaisin = "."
  show Taken = "x"
type CakeRow = [CakeElem]
type Cake = [CakeRow]

-- TODO needs more testing
cut :: String -> [String]
cut str = let parsed = readCake str
              try = tryToCut parsed
          in case try of
               Nothing -> []
               Just cakes -> map showCake cakes

testCut1 = cut string1 -- Exception: Prelude.!!: index too large


-- TODO tests
tryToCut :: Cake -> Maybe [Cake]
tryToCut cake = let
  noRaisins = countRaisins cake
  cArea = cakeArea cake
  pArea = cArea `div` noRaisins
  -- convention on sideDimension: (column-height, row-width)
  sideDims = map (\n -> (n, pArea `div` n)) $ divisors pArea
  in case findCorner cake of
       Nothing -> Just []
       Just (i,j) -> case takePiece cake (i,j) sideDims of
         Nothing -> Nothing
         Just (piece, rest) -> fmap (piece:) $ tryToCut rest

-- TODO test
findCorner :: Cake -> Maybe (Int, Int)
findCorner cake = let
  firstRow = findIndex (not . rowTaken) cake
  in case firstRow of
       Nothing -> Nothing
       Just rowIndex -> case findIndex (/= Taken) (cake !! rowIndex) of
         Nothing -> Nothing
         Just columnIndex -> Just (rowIndex, columnIndex)

rowTaken :: CakeRow -> Bool
rowTaken = all (==Taken)

-- TODO test
takePiece :: Cake ->
             (Int, Int) ->
             [(Int,Int)] ->
             Maybe (Cake, Cake)
takePiece cake corner lengths = 
  case filter (takable cake corner) lengths of
    [] -> Nothing
    pieces -> let
      f p = tryToCut (cakeWithout cake corner p)
      trys = map f pieces
      first = dropWhile (== Nothing) trys
      in case findIndex (/= Nothing) trys of
           Nothing -> Nothing
           Just index -> let piece = pieces !! index in
             Just (makePiece cake corner piece,
                   cakeWithout cake corner piece)

takable :: Cake -> (Int, Int) -> (Int, Int) -> Bool
takable cake (x, y) (w, h) = let
  (nrows, ncols) = cakeDim cake
  piece = makePiece cake (x, y) (w, h)
  in (x + w - 1) < nrows && (y + h - 1) < ncols
     && countRaisins piece == 1
     && all (/=Taken) (concat piece)

testTakable1 = takable cake1 (1,4) (2,2) == False -- no raisin
testTakable2 = takable cake1 (0,0) (3,3) == True -- good
testTakable3 = takable cake1 (3,2) (3,5) == False -- out of bounds

-- TODO more tests
cakeWithout :: Cake -> (Int, Int) -> (Int, Int) -> Cake
cakeWithout cake (x, y) (w, h) = let
  indices = [ (i, j) |
              i <- [x .. x + w - 1],
              j <- [y .. y + h - 1] ]
  in foldr (\pr ck -> cakeSet ck Taken pr) cake indices

test_cakeWithout1 = printCake $ cakeWithout cake1 (1,1) (3,4)

-- (row, column)
cakeSet :: Cake -> CakeElem -> (Int, Int) -> Cake
cakeSet cake element (i, j) = indexApply cake f i
  where f row = listInsert row element j

indexApply :: [a] -> (a -> a) -> Int -> [a]
indexApply xs f i = take i xs ++ f (xs !! i) : drop (i+1) xs

listInsert :: [a] -> a -> Int -> [a]
listInsert xs e i = indexApply xs (\_ -> e) i
  
makePiece :: Cake -> (Int, Int) -> (Int, Int) -> Cake
makePiece cake (x, y) (w, h) = let
  rows = getRange x (x+w-1) cake
  in map (getRange y (y+h-1)) rows

-- getRange 1 3 [a, b, c, d, e, ...] = [b, c, d]
getRange :: Int -> Int -> [a] -> [a]
getRange n m xs = take (m-n+1) $ drop n xs

-- area of (remaining) cake (not taken)
cakeArea :: Cake -> Int
cakeArea cake = length $ filter (/= Taken) $ concat cake

transpose :: [[a]] -> [[a]]
transpose [] = []
transpose m = if (length . head) m == 0
              then []
              else concatMap (take 1) m : transpose (map (drop 1) m)

chunksOf :: Int -> [a] -> [[a]]
chunksOf n [] = []
chunksOf n xs = take n xs : (chunksOf n (drop n xs))

-- (rows, columns)
cakeDim :: Cake -> (Int, Int)
cakeDim [] = (0,0)
cakeDim (r:rs) = (length rs + 1, length r)

countRaisins :: Cake -> Int
countRaisins = length . (filter isRaisin) . concat

isRaisin = (== Raisin) :: CakeElem -> Bool

readCake :: String -> Cake
readCake = (map (map f)) . lines
  where f 'o' = Raisin
        f '.' = NoRaisin
        f 'x' = Taken
        f _ = error "No readCake."

getCakeRow :: Int -> Cake -> CakeRow
getCakeRow n c = c !! n

-- (row, column), that is row-major
(!) :: Cake -> (Int, Int) -> CakeElem
c ! (n,m) = (c !! n) !! m

showCake :: Cake -> String
showCake = ( unlines . (map (map f)) )
  where f Raisin = 'o'
        f NoRaisin = '.'
        f Taken = 'x'

printCake = putStrLn . showCake :: Cake -> IO ()

--- Auxiliaries

fi = fromIntegral

--factor :: Integral a => a -> [a] -- why is this type bound to Integer?
factor n = help n [2.. ceiling (sqrt (fi n))]
  where help n [] = [n]
        help 1 _ = []
        help n (x:xs) =
          if n `mod` x == 0
          then x : factor (n `div` x)
          else help n xs

divisors :: Integral a => a -> [a]
divisors n = filter (\m -> n `mod` m == 0) [1..n]

commonDivisors n m = filter (flip elem (divisors n)) $ divisors m

string1 = "........\n..o.....\n...o....\n........\n" :: String
cake1 = readCake string1 :: Cake

string2 = ".o......\n......o.\n....o...\n..o.....\n" :: String
cake2 = readCake string2 :: Cake

--- Dead ends

-- cut cake = let
--   c = readCake cake
--   n = countRaisins c
--   (w,h) = cakeDim c
--   divs = [ (a, b) | a <- divisors w
--                   , b <- divisors h
--                   , a * b == n ]
--   cuts = [ divideCake (a, b) c | (a, b) <- divs ]
--   gCuts = filter goodCut cuts
--   sortedCuts = sortBy (comparing (length . head)) gCuts
--   in if w < 1 || h < 1 || null sortedCuts then []
--      else map showCake $ head $ reverse sortedCuts

-- cut_debug :: String -> IO ()
-- cut_debug cake = let
--   c = readCake cake
--   n = countRaisins c
--   (w,h) = cakeDim c
--   divs = [ (a, b) | a <- divisors w
--                   , b <- divisors h
--                   , a * b == n ]
--   cuts = [ divideCake (a, b) c | (a, b) <- divs ]
--   gCuts = filter goodCut cuts
--   sortedCuts = sortBy (comparing (length . head)) gCuts
--   in

-- goodCut :: [Cake] -> Bool
-- goodCut cs = all (==1) $ map countRaisins cs

-- divideCake :: (Int, Int) -> Cake -> [Cake]
-- divideCake (a,b) c =
--   concatMap (divideCakeColumns b) $ divideCakeRows a c

-- -- assumes n divides row-dimension of cake
-- divideCakeRows :: Int -> Cake -> [Cake]
-- divideCakeRows n c = let
--   (w,h) = cakeDim c
--   nw = w `div` n
--   in chunksOf nw c

-- divideCakeColumns :: Int -> Cake -> [Cake]
-- divideCakeColumns n c =
--   map transpose $ divideCakeRows n $ transpose c
