
import Text.Printf


-- Exercise 7.1

data Tree a = Leaf a
            | Branch (Tree a) (Tree a)
instance (Show a) => Show (Tree a) where
  show (Leaf a) = show a
  show (Branch t1 t2) = '(' : show t1 ++ ", " ++ show t2 ++ ")"

foldrl :: (a -> b -> b) -> b -> (Tree a) -> b
foldrl f x (Leaf a) = f a x
foldrl f x (Branch t1 t2) = foldrl f (foldrl f x t1) t2

foldlr :: (a -> b -> b) -> b -> (Tree a) -> b
foldlr f x (Leaf a) = f a x
foldlr f x (Branch t1 t2) = foldlr f (foldrl f x t2) t1

fringe :: (Tree a) -> [a]
fringe = foldlr (:) []

treeSize :: (Tree a) -> Integer
treeSize = foldlr (\x -> (1+)) 0

foldup :: (b -> b -> b) -> b -> (Tree a) -> b
foldup f x (Leaf a) = x
foldup f x (Branch t1 t2) = f (foldup f x t1) (foldup f x t2)

treeHeight = foldup (\x y -> 1 + max x y) 0

-- Exercise 7.2

data InternalTree a = ILeaf
                    | IBranch a (InternalTree a) (InternalTree a)
instance (Show a) => Show (InternalTree a) where
  show ILeaf = "*"
  show (IBranch v t1 t2) = show v ++ "{" ++ show t1 ++ ", " ++ show t2 ++ "}"

takeTree :: Int -> InternalTree a -> InternalTree a
takeTree 0 _ = ILeaf
takeTree _ ILeaf = ILeaf
takeTree n (IBranch v t1 t2)
  = IBranch v (takeTree (n-1) t1) (takeTree (n-1) t2)

takeTreeWhile :: (a -> Bool) -> InternalTree a -> InternalTree a
takeTreeWhile _ ILeaf = ILeaf
takeTreeWhile c (IBranch v t1 t2)
  = if c v
    then IBranch v (takeTreeWhile c t1) (takeTreeWhile c t2)
    else ILeaf

-- Exercise 7.3

foldITree f x ILeaf = x
foldITree f x (IBranch v t1 t2) 
  = foldITree f (f v (foldITree f x t1)) t2

-- Exercise 7.4

zipTree :: Tree a -> Tree b -> Tree (a, b)
zipTree (Leaf a) (Leaf b) = Leaf (a, b)
zipTree (Branch a1 a2) (Branch b1 b2)
  = Branch (zipTree a1 b1) (zipTree a2 b2)
zipTree (Leaf a) _ = error "zipTree: only identically structured trees can be zipped"
zipTree _ (Leaf b) = error "zipTree: only identically structured trees can be zipped"

zipTreeWith :: (a -> b -> c) -> Tree a -> Tree b -> Tree c
zipTreeWith f (Leaf a) (Leaf b) = Leaf (f a b)
zipTreeWith f (Branch a1 a2) (Branch b1 b2)
  = Branch (zipTreeWith f a1 b1) (zipTreeWith f a2 b2)
zipTreeWith _ (Leaf a) _ = error "zipTreeWith: only identically structured trees can be zipped"
zipTreeWith _ _ (Leaf b) = error "zipTreeWith: only identically structured trees can be zipped"

-- Exercise 7.5

showFloat :: Float -> String
showFloat = (++ ".") . show . floor

data Expr = C Float | V String | Let String Expr Expr
          | Expr :+ Expr | Expr :- Expr | Expr :* Expr | Expr :/ Expr
instance (Show Expr) where
  show (C x) = showFloat x
  show (V n) = n
  show (Let n e1 e2) = "( let x = " ++ show e1 ++ " in " ++ show e2 ++ " )"
  show (e1 :+ e2) = "( " ++ show e1 ++ " + " ++ show e2 ++ " )"
  show (e1 :- e2) = "( " ++ show e1 ++ " - " ++ show e2 ++ " )"
  show (e1 :* e2) = "( " ++ show e1 ++ " * " ++ show e2 ++ " )"
  show (e1 :/ e2) = "( " ++ show e1 ++ " / " ++ show e2 ++ " )"

rmLets :: Expr -> Expr
rmLets (Let n e (C x)) = C x
rmLets (Let n1 e (V n2)) = if n1 == n2 then rmLets e else (V n2)
rmLets (Let n e (e1 :+ e2)) = (rmLets (Let n e e1)) :+ (rmLets (Let n e e2))
rmLets (Let n e (e1 :- e2)) = (rmLets (Let n e e1)) :- (rmLets (Let n e e2))
rmLets (Let n e (e1 :* e2)) = (rmLets (Let n e e1)) :* (rmLets (Let n e e2))
rmLets (Let n e (e1 :/ e2)) = (rmLets (Let n e e1)) :/ (rmLets (Let n e e2))
rmLets (Let n1 e1 (Let n2 e2 e3)) = rmLets (Let n1 e1 (rmLets (Let n2 e2 e3)))
rmLets (e1 :+ e2) = (rmLets e1) :+ (rmLets e2)
rmLets (e1 :- e2) = (rmLets e1) :- (rmLets e2)
rmLets (e1 :* e2) = (rmLets e1) :* (rmLets e2)
rmLets (e1 :/ e2) = (rmLets e1) :/ (rmLets e2)
rmLets e = e

evaluate (Let n e1 e2) = evaluate $ rmLets $ Let n e1 e2
evaluate (C x) = x
evaluate (V n) = error "evaluate: undefined variables"
evaluate (e1 :+ e2) = (evaluate e1) + (evaluate e2)
evaluate (e1 :- e2) = (evaluate e1) - (evaluate e2)
evaluate (e1 :* e2) = (evaluate e1) * (evaluate e2)
evaluate (e1 :/ e2) = (evaluate e1) / (evaluate e2)

-- Tests

testTree = Branch (Branch (Leaf 'a') (Leaf 'b')) (Leaf 'c')
testITree = IBranch 'a' (IBranch 'b' ILeaf ILeaf) ILeaf

test1 = (show $ takeTreeWhile ('b' /=) testITree) == "'a'{*, *}"
test2 = zipTree testTree testTree

testExpr1 = Let "x" (C 5) (V "x" :+ V "x")