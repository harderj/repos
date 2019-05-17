module Haskell.Codewars.MorseDecoder where 
--import Haskell.Codewars.MorseDecoder.Preloaded (morseCode)
import Data.Maybe
import Data.List
import Data.Char
import Control.Monad (msum)

decode = decodeMorse . decodeBitsAdvanced

decodeBitsAdvanced :: String -> String
decodeBitsAdvanced str = let
  crpd = crop '0' str
  grps = group crpd
  (n, m) = analyseBits grps
  in concatMap (binToMorse n m) grps

decodeMorse :: String -> String
decodeMorse str = let
  crpd = crop ' ' str
  grps = groupBy (\a b -> (a == ' ' && b == ' ') || (a /= ' ' && b /= ' ')) crpd
  in concatMap ((map toUpper) . morseToStr) grps

analyseBits :: [String] -> (Int, Int)
analyseBits grps = let
  srt = sort $ map length grps  
  means = threeMeans1d (map fromIntegral srt)
  limits = map floor $ pairWiseMeans means
  (a,b) = case length limits of
            0 -> let n = round $ head means in (n, n)
            1 -> let n = head limits in (n, n+2) -- +2 very arbitrary
            2 -> let [n,m] = limits in (n, m)
            otherwise -> (0,0)
  in (a,b)

analyseBits_2 :: [String] -> IO ()
analyseBits_2 grps = let
  srt = sort $ map length grps  
  means = threeMeans1d (map fromIntegral srt)
  limits = map floor $ pairWiseMeans means
  (a,b) = case length limits of
            0 -> let n = round $ head means in (n, n)
            1 -> let n = head limits in (n, n+2)
            2 -> let [n,m] = limits in (n, m)
            otherwise -> (0,0)
  in mapM_ putStrLn ["str: " ++ show srt,
                     "means: " ++ show means,
                     "limits: " ++ show limits,
                     "(a,b): " ++ show (a,b)]

mean :: Fractional a => [a] -> a
mean [] = 0
mean xs = sum xs / fromIntegral (length xs)

-- assumes xs ordered and of length >= 2
-- returns 1<= <=3 means
threeMeans1d :: (Fractional a, Ord a) => [a] -> [a]
threeMeans1d xs = let
  h = head xs
  l = last xs
  m = mean [h,l]
  in kMeans1d xs [h,m,l] 5 -- 5 is arbitrary
          
-- assumes xs and ms are ordered
-- returns 1<= <=|ms| means
kMeans1d :: (Fractional a, Ord a) => [a] -> [a] -> Int -> [a]
kMeans1d xs ms 0 = ms
kMeans1d xs (m:ms) n = let
  limits = zipWith (\a b -> (a+b)/2) (m:ms) ms
  clusters = cutBy limits xs
  newMs = filter (/= 0) $ map mean clusters
  in kMeans1d xs newMs (n-1)

pairWiseMeans [] = []
pairWiseMeans (x:xs) = zipWith (\a b -> (a+b)/2) (x:xs) xs

cutBy [] xs = [xs]
cutBy (l:ls) xs = let
  (fsts,lsts) = break (>l) xs
  in fsts : (cutBy ls lsts)

-- strings of length <= n
-- are short, e.g. in-character pauses "" or dots "."
-- strings of length <= m
-- are between characters pauses " " or dashes "-"
-- strings of length > m
-- are between words pauses "   " or dashes "-"
binToMorse :: Int -> Int -> String -> String
binToMorse n m (c:str)
  | c == '0' && length str < n = ""
  | c == '0' && length str < m = " "
  | c == '0' = "   "
  | c == '1' && length str < n = "."
  | c == '1' = "-"
  | otherwise = ""

-- space for optimization
crop :: Eq a => a -> [a] -> [a]
crop c str = let one = dropWhile (==c) $ reverse str
  in dropWhile (==c) $ reverse one

morseToStr :: String -> String
morseToStr str = case str of
  "   " -> " "
  " " -> ""
  ".-" -> "a"
  "-..." -> "b"
  "-.-." -> "c"
  "-.." -> "d"
  "." -> "e"
  "..-." -> "f"
  "--." -> "g"
  "...." -> "h"
  ".." -> "i"
  ".---" -> "j"
  "-.-" -> "k"
  ".-.." -> "l"
  "--" -> "m"
  "-." -> "n"
  "---" -> "o"
  ".--." -> "p"
  "--.-" -> "q"
  ".-." -> "r"
  "..." -> "s"
  "-" -> "t"
  "..-" -> "u"
  "...-" -> "v"
  ".--" -> "w"
  "-..-" -> "x"
  "-.--" -> "y"
  "--.." -> "z"
  "-----" -> "0"
  ".----" -> "1"
  "..---" -> "2"
  "...--" -> "3"
  "....-" -> "4"
  "....." -> "5"
  "-...." -> "6"
  "--..." -> "7"
  "---.." -> "8"
  "----." -> "9"
  ".-.-.-" -> "."
  "--..--" -> ","
  "..--.." -> "?"
  ".----." -> "'"
  "-.-.--" -> "!"
  "...---..." -> "SOS"
  _ -> ""

testString = "0000000011011010011100000110000001111110100111110011111100000000000111011111111011111011111000000101100011111100000111110011101100000100000"

--

-- analyseBits grps = let
--   defaultOnes = [1,1,1,2,2,2,2,4,4,5,5]
--   defaultZeros = [1,1,1,2,2,2,2,2,5,6,9]
--   ones = sort $ defaultOnes ++ (map length $ filter ((=='1') . head) grps)
--   zeros = sort $ defaultZeros ++ (map length $ filter ((=='0') . head) grps)
--   len1 = fromIntegral $ length ones
--   len0 = fromIntegral $ length zeros
--   threshold1 = ceiling $ len1 * 0.5
--   threshold0low = ceiling $ len0 * 0.6
--   threshold0high = ceiling $ len0 * 0.9
--   in (zeros !! (threshold0low - 1),
--       zeros !! (threshold0high - 1),
--       ones !! (threshold1 - 1))

-- analyseBits_ grps = let
--   defaultOnes = [1,1,2,2,2,4,4,5,5]
--   defaultZeros = [1,2,2,3,5,6,9]
--   ones = sort $ defaultOnes ++ (map length $ filter ((=='1') . head) grps)
--   zeros = sort $ defaultZeros ++ (map length $ filter ((=='0') . head) grps)
--   len1 = fromIntegral $ length ones
--   len0 = fromIntegral $ length zeros
--   threshold1 = ceiling $ len1 * 0.6
--   threshold0low = ceiling $ len0 * 0.5
--   threshold0high = ceiling $ len0 * 0.8
--   in sequence_ [print (len0, len1),
--                 print (threshold1 - 1),
--                 print (threshold0low - 1),
--                 print (threshold0high - 1),
--                 print ones,
--                 print zeros]

-- analyseBits_1 :: [String] -> IO ()
-- analyseBits_1 grps = let
--   srt = sort $ map length grps
--   len = fromIntegral $ length srt
--   low = floor $ (len - 1) * 0.3
--   high = floor $ (len - 1) * 0.7
--   in mapM_ putStrLn ["str: " ++ show srt,
--                      "len: " ++ show len,
--                      "low: " ++ show low,
--                      "high: " ++ show high,
--                      "(n,m): " ++ show (srt !! low, srt !! high + 2)]
