
import Numeric
import Data.Char
import Data.List

dgs :: (Num a, Show a, Read a) => a -> [a]
dgs = (map (read . (\c -> [c]))) . show

nmb :: (Num a, Show a, Read a) => [a] -> a
nmb = read . (map (head . show))

chr2Int c = ord c - 48

base2 n = map chr2Int $ showIntAtBase 2 (\x -> head $ show x) n ""

palindrome xs = reverse xs == xs

palindromeInBase2 = palindrome . base2

palindromes = map nmb $ concatMap step2 help1 ++ map (:[]) [1..9]
  where help1 = concat $ help2 ([[0,0],[]] ++ (map dgs ([0..9] ++ [11,22..99])))
        help2 xs = take 4 $ iterate (concatMap help3) xs
        help3 xs = map (palAppend xs) [0..9]

palAppend xs x = x : reverse (x : xs)

step2 xs = map (palAppend xs) [1..9]

step3 = filter palindromeInBase2 palindromes

step4 = nub step3 -- unnecessary.. apparently

step5 = filter (< 10^6) step4

solution = sum step5

-- this is some incomprehensive code
