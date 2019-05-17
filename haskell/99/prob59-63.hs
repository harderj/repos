-- haskell problems 59-63

import Data.List
import qualified Data.Tree as DT
import qualified Data.Tree.Pretty as PT

data Tree a = Empty | Branch a (Tree a) (Tree a)
              deriving (Show, Eq)
leaf x = Branch x Empty Empty

tree1 = Branch 'a' (Branch 'b' (Branch 'd' Empty Empty)
                               (Branch 'e' Empty Empty))
                   (Branch 'c' Empty
                               (Branch 'f' (Branch 'g' Empty Empty)
                                           Empty))

convert :: Tree a -> DT.Tree a
convert Empty = error "incompatible Tree"
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

putT :: Show a => Tree a -> IO ()
putT = putStr . prettyT

putTs :: Show a => [Tree a] -> IO ()
putTs = mapM_ putT

mapT :: (a -> b) -> Tree a -> Tree b
mapT f Empty = Empty
mapT f (Branch x t t') =
  Branch (f x) (mapT f t) (mapT f t')

addOne :: a -> Tree a -> Tree a
addOne x t = helper x t 0 where
  m = maxHeight t
  helper x t n
    = let (nt, f) = addOneAtHeight n x t
      in if f then nt
         else helper x t (n+1)

addOneAtHeight :: Int -> a -> Tree a -> (Tree a, Bool)
addOneAtHeight 0 x Empty = (Branch x Empty Empty, True)
addOneAtHeight n x Empty = (Empty, False)
addOneAtHeight n x (Branch y t t')
  = let (nt, f) = addOneAtHeight (n-1) x t
        (nt', f') = addOneAtHeight (n-1) x t'
    in if f then (Branch y nt t', True)
       else if f' then (Branch y t nt', True)
            else (Branch y t t', False)


maxHeight :: Tree a -> Int
maxHeight = helper 0 where
  helper n Empty = n
  helper n (Branch _ t t') = max (helper (n+1) t) (helper (n+1) t')

hbal :: Tree a -> Bool
hbal Empty = True
hbal (Branch _ t t') = abs (h - h') <= 1 && hbal t && hbal t'
  where h = maxHeight t
        h' = maxHeight t'

allTrees :: a -> Int -> [Tree a]
allTrees x n = nubBy strEq $ helper [Empty] n where
  helper ts 0 = ts
  helper ts n = let nts = ts ++ [Branch x t t' | t <- ts, t' <- ts]
                in helper nts (n-1)

strEq :: Tree a -> Tree b -> Bool
strEq Empty Empty = True
strEq Empty _ = False
strEq _ Empty = False
strEq (Branch _ l r) (Branch _ l' r') = strEq l l' && strEq r r'

hFunc1 :: [a] -> [(a,a)]
hFunc1 [] = []
hFunc1 (x:xs) = [(x,y)|y<-(x:xs)] ++ hFunc1 xs

-- problem 59
hbalTree :: a -> Int -> [Tree a]
hbalTree x n = filter hbal $ allTrees x n

countNodes :: Tree a -> Int
countNodes Empty = 0
countNodes (Branch _ t t') = 1 + countNodes t + countNodes t'

-- problem 60 (too slow)
hbalTreeNodes :: a -> Int -> [Tree a]
hbalTreeNodes x n = let m = 2 * log2 n in
  filter (\t -> hbal t && countNodes t == n) $ hbalTrees x m

log2 :: Int -> Int
log2 n = ceiling (logBase 2 (fromIntegral n))

hbalTrees :: a -> Int -> [Tree a]
hbalTrees x n = nubBy strEq $ helper [Empty] n where
  helper ts 0 = ts
  helper ts n = let nts = ts ++ [Branch x t t'
                                | t <- ts
                                , t' <- ts
                                , abs(maxHeight t - maxHeight t') <= 1]
                in helper nts (n-1)

tree4 = Branch 1 (Branch 2 Empty (Branch 4 Empty Empty))
        (Branch 2 Empty Empty)

-- problem 61
countLeaves = length . leaves

-- problem 61A
leaves :: Tree a -> [a]
leaves Empty = []
leaves (Branch x Empty Empty) = [x]
leaves (Branch x t t') = leaves t ++ leaves t'

-- problem 62

internals :: Tree a -> [a]
internals Empty = []
internals (Branch x Empty Empty) = []
internals (Branch x t t') = x : (internals t ++ internals t')

-- problem 62B

atLevel :: Tree a -> Int -> [a]
atLevel Empty _ = []
atLevel (Branch x l r) 0 = [x]
atLevel (Branch _ l r) n = atLevel l (n-1) ++ atLevel r (n-1)

-- problem 63

completeBinaryTree :: Int -> Tree Char
completeBinaryTree n = helper Empty n where
  helper t 0 = t
  helper t n = helper (addOne 'x' t) (n-1)
