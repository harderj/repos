-- Ninety-Nine Haskell Problems
-- http://www.haskell.org/haskellwiki/H-99:_Ninety-Nine_Haskell_Problems

import Data.List
import Data.Function
import qualified Data.Foldable as DF
import qualified Data.Tree as DT
import qualified Data.Tree.Pretty as PT
import System.Random
import Control.Monad (replicateM)

-- prob 1

-- myLast returns last element in a list
-- error: on [] due to use of 'head'
myLast :: [a] -> a
myLast = head . reverse

-- prob 2

-- myButLast l returns second-last element in list
-- error: if length l < 2
myButLast :: [a] -> a
myButLast = head . tail . reverse

-- prob 3

-- elementAt [a_1,a_2..a_m] n returns a_n
-- error if not 1 < n <= m
elementAt :: [a] -> Int -> a
elementAt xs n = xs !! (n - 1)

-- prob 4

myLength :: [a] -> Int
myLength = length

-- prob 5

myReverse = reverse

-- prob 6

isPalindrome :: Eq a => [a] -> Bool
isPalindrome l = l == myReverse l

-- prob 7

data NestedList a = Elem a | List [NestedList a]

flatten :: NestedList a -> [a]
flatten (Elem x) = [x]
flatten (List xs) = concatMap flatten xs

-- prob 8

compress :: Eq a => [a] -> [a]
compress [] = []
compress [x] = [x]
compress (x:x':xs) = if x==x'
                     then compress (x:xs)
                     else x:(compress (x':xs))
-- smarter alternative:
-- compress = map head . group

-- prob 9

pack :: Eq a => [a] -> [[a]]
pack = group

-- prob 10

encode :: Eq a => [a] -> [(Int, a)]
encode = map (\a -> (length a, head a)) . group

tryOut :: (Num a, Enum a) => (a -> b) -> a -> [(a, b)]
tryOut f n = map (\x -> (x, f x)) [1..n]

-- prob 11

data Encodoid a = Single a | Multiple Int a deriving Eq
type Code a = [Encodoid a]

encodeModified :: Eq a => [a] -> Code a
encodeModified = let f (1, x) = Single x
                     f (n, x) = Multiple n x
                 in map f . encode

-- prob 12

decode :: [(Int, a)] -> [a]
decode = concatMap (\(x,y) -> replicate x y)
-- decode concatMap $ replicate . curry
-- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- TODO understand why this second solution doesn't work

decodeModified :: Eq a => [Encodoid a] -> [a]
decodeModified = let f (Single x) = (1, x)
                     f (Multiple n x) = (n, x)
                 in decode . map f

-- prob 13 not done
-- okay I don't get the point

-- prob 14

dupli :: [a] -> [a]
dupli = concatMap $ replicate 2

-- prob 15

repli :: [a] -> Int -> [a]
repli = flip $ concatMap . replicate

-- prob 16

dropEvery :: [a] -> Int -> [a]
dropEvery l n = let h [] _ _ = []
                    h (x:xs) n c = if c==n
                                   then h xs n 1
                                   else x:(h xs n $ c+1)
                in h l n 1

-- prob 17

split :: Int -> [a] -> ([a], [a])
split n l = (take n l, drop n l)
{- CHALLENGE write split without the use of input pattern matching
   or splitAt -}

-- prob 18

slice :: [a] -> Int -> Int -> [a]
slice l n m = take (m-n+1) (drop (n-1) l)
-- more elegant:
-- slice xs i k = drop (i-1) $ take k xs

-- prob 19

rotate :: [a] -> Int -> [a]
rotate l n = let h [] = []
                 h (x:xs) = xs ++ [x]
             in iterate h l !! ((mod n $ (length l)))

-- prob 20

removeAt :: Int -> [a] -> [a]
removeAt n l = take (n-1) l ++ drop n l

-- prob 21

insertAt x xs n = take (n-1) xs ++ (x:(drop (n-1) xs))

-- prob 22

range n m = [n..m]

-- prob 22.5
-- i want to try to make something simpler with the Random library
-- before stepping to prob 23

-- rnd_bit :: Num a => IO a
-- rnd_bit n = do g <- replicateM n $ getStdRandom $ randomR (0,1)
--                return [i | i <- g]

-- prob 23

rnd_select l n =
  do idxs <- replicateM n $ getStdRandom $ randomR (0, length l - 1)
     return [l !! i | i <- idxs]

-- prob 24

diff_select n m = rnd_select [1..m] n

-- prob 25



-- prob 26-28 not done

-- prob 29-30 does not exists

-- prob 31

isPrime :: Integral a => a -> Bool
isPrime n = and $ (n > 1) : map (relPrim n) [x | x <- [2..n-1]]

-- prob 32

myGcd :: Integral a => a -> a -> a
myGcd a 0 = a
myGcd a b = myGcd b (mod a b)

-- prob 33

relPrim :: Integral a => a -> a -> Bool
relPrim a b = 1 == gcd a b

-- prob 34

totient :: Integral a => a -> a
totient n = sum [1 | x <- [1..n], relPrim x n]

-- prob 35

-- primeFactors is poorly optimized
primeFactors :: Integer -> [Integer]
primeFactors 1 = []
primeFactors n = let m = head $ filter ((1/=) . (gcd n)) [1..n]
                 in m : (primeFactors $ n `div` m)

-- prob 36

listCompr :: (Eq a) => [a] -> [(a, Int)]
listCompr [] = []
listCompr (x:xs) = let a = filter (==x) xs
                   in (x, 1 + length a) : (listCompr $ filter (/=x) xs)

prime_factors_mult = listCompr . primeFactors

-- prob 37

phi :: Integer -> Integer
phi = (foldr (\(p, m) r -> (p-1)*p^(m-1)*r) 1) . prime_factors_mult

-- prob 38
-- use ':set +s' in ghci to get this info:
-- *Main> totient 10090
-- 4032
-- (0.14 secs, 6208068 bytes)
-- *Main> phi 10090
-- 4032
-- (0.01 secs, 524788 bytes)

-- prob 39

primesR :: Integer -> Integer -> [Integer]
primesR n m = filter isPrime [n..m]

-- prob 40

goldbachList :: Integer -> [(Integer, Integer)]
goldbachList n = let ps = primesR 1 n
                 in [(x,y) | x <- ps, y <- ps, x + y == n, x >= y]

goldbach = head . goldbachList

-- prob 41

-- didn't really get this
goldbachList' n m p = take n
                      $ filter f
                      $ concatMap goldbachList [4,6..m]
  where f (a, b) = (a >= p) && (b >= p)

-- prob 42-45 does not exist

-- prob 46

and2, or2, nand2, nor2, xor2, impl2, equ2 :: Bool -> Bool -> Bool
and2 = (&&)
or2 = (||)
nand2 a b = not $ and2 a b
nor2 a b = not $ and2 a b
xor2 = (/=)
impl2 a b = or2 (not a) b
equ2 = (==)

table :: (Bool -> Bool -> Bool) -> IO ()
table gate = do
  mapM_ putStrLn t
    where
      t = map h list
      h (a, b) = show' a
                 ++ " "
                 ++ show' b
                 ++ " | "
                 ++ show' (gate a b)
      list = [ (v1,v2) | v1 <- [True,False], v2 <- [True,False] ]

show' :: Bool -> String
show' True = "T"
show' False = "F"

t = True
f = False

-- prob 47
-- it is trivial?

-- prob 48
tablen :: Int -> ([Bool] -> Bool) -> IO ()
tablen n f =
    let cs = comb n [True,False]
        vs = map f cs
        h :: ([Bool], Bool) -> String
        h (bs, b) = concatMap show' bs ++ "|" ++ show' b
        strs = map h (zip cs vs)
    in do mapM_ putStrLn strs

comb :: Int -> [a] -> [[a]]
comb n es = repN n (tunar es) [[]]

repN :: Int -> (a -> a) -> a -> a
repN n f x = (iterate f x) !! n

tunar :: [a] -> [[a]] -> [[a]]
tunar xs ls = concatMap (whale xs) ls

whale :: [a] -> [a] -> [[a]]
whale xs ls = map (:ls) xs

-- prob 49

squid :: [a] -> [[a]] -> [[a]]
squid [] ls = []
squid (x:xs) ls = (map (x:) ls) ++ squid xs (reverse ls)

grey n = repN n (squid "01") [[]]

-- prob 50
-- I did not get it.

-- prob 55

-- had a couple of failed tries ...
-- height :: Tree a -> Int
-- height Empty = 0
-- height (Branch _ t t') = (+) 1 $ max (height t) $ height t'
-- data TEither = L | R
-- type TPath = [TEither]
-- addT :: Tree a -> TPath -> Tree a -> Tree a
-- addT t _ Empty = t
-- addT Empty _ t' = t'
-- addT (Branch x b b') (h:hs) t'
--   = case h of
--       L -> Branch x (addT b hs t') b'
--       R -> Branch x b (addT b' hs t')
-- addT t [] t' = addT t (repeat L) t'
-- addTX :: a -> Tree a -> TPath -> Tree a
-- addTX x t p = addT t p (leaf x)

data Tree a = Empty | Branch a (Tree a) (Tree a)
              deriving (Show, Eq)
leaf x = Branch x Empty Empty

tree1 = Branch 'a' (Branch 'b' (Branch 'd' Empty Empty)
                               (Branch 'e' Empty Empty))
                   (Branch 'c' Empty
                               (Branch 'f' (Branch 'g' Empty Empty)
                                           Empty))

-- itT :: a -> Tree a -> [Tree a]
-- itT x Empty = [leaf x]
-- itT x (Branch y t t') =
--   [Branch x (Branch y t t') Empty,
--    Branch x Empty (Branch y t t')] ++ more
--   where more =
--           case (t,t') of
--             (Empty, Empty) -> [Branch y (leaf x) Empty,
--                                Branch y Empty (leaf x)]
--             (Empty, t_) -> [Branch y (leaf x) t_]
--             (t_, Empty) -> [Branch y t_ (leaf x)]
--             _ -> []

-- this is really awful optimization
addOneT :: a -> Tree a -> [Tree a]
addOneT x Empty = [leaf x]
addOneT x (Branch y t t') =
  mkBL y t' (addOneT x t) ++ mkBR y t (addOneT x t')
  where mkBL,mkBR :: a -> Tree a -> [Tree a] -> [Tree a]
        mkBL _ _ [] = []
        mkBL y t (b:bs) =
          (Branch y b t) : mkBL y t bs
        mkBR _ _ [] = []
        mkBR y t (b:bs) =
          (Branch y t b) : mkBR y t bs

allT :: (Eq a) => Int -> a -> [Tree a]
allT n x =
  nub (repN n (concatMap (addOneT x)) [Empty])

cbal :: Tree a -> Bool
cbal Empty = True
cbal (Branch _ t t') =
  abs (massT t - massT t') <= 1 && cbal t && cbal t'

massT :: Tree a -> Int -- counts nodes
massT Empty = 0
massT (Branch _ t t') = 1 + massT t + massT t'

cbalTree :: Int -> [Tree Char]
cbalTree n = filter cbal (allT n 'x')

-- prob 56

mirrorT :: Tree a -> Tree a
mirrorT Empty = Empty
mirrorT (Branch x t t') =
  Branch x (mirrorT t') (mirrorT t)

eraseT :: Tree a -> Tree ()
eraseT Empty = Empty
eraseT (Branch _ t t') =
  Branch () (eraseT t) (eraseT t')

symmetric :: Tree a -> Bool
symmetric t = mirrorT t' == t'
  where t' = eraseT t

-- prob 57

binTAdd :: Tree Int -> Int -> Tree Int
binTAdd Empty n = leaf n
binTAdd (Branch m t t') n =
  if n<m
  then Branch m (binTAdd t n) t'
  else Branch m t (binTAdd t' n)

construct :: [Int] -> Tree Int
construct = foldl binTAdd Empty
-- construct [] = Empty
-- construct (n:ns) = binTAdd (construct ns) n

-- prob 58

symCbal :: Tree a -> Bool
symCbal t = cbal t && symmetric t

symCbalTrees :: Int -> [Tree Char]
symCbalTrees n = filter symmetric (cbalTree n)

convert :: Tree a -> DT.Tree a
convert Empty = error "incompatible tree"
convert (Branch x t t') = DT.Node x subs
  where subs = p ++ p'
        p = case t of Empty -> []
                      b -> [convert b]
        p' = case t' of Empty -> []
                        b' -> [convert b']

convertSpecial :: Tree String -> DT.Tree String
convertSpecial Empty = DT.Node "*" []
convertSpecial (Branch x t t') =
  DT.Node x [convertSpecial t, convertSpecial t']

prettyT :: Show a => Tree a -> String
prettyT = PT.drawVerticalTree . convertSpecial . (mapT show)

mapT :: (a -> b) -> Tree a -> Tree b
mapT f Empty = Empty
mapT f (Branch x t t') =
  Branch (f x) (mapT f t) (mapT f t')

-- prob 59

