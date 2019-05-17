module Hans.Graph (
  Graph,
  Vertex,
  Edge,
  UGraph,
  emptyGraph,
  gFind,
  gFilter,
  gAdd,
  gAddE,
  gClean,
  unVertex,
  toList,
  gReplace,
  gVertexId,
  gInEdge,
  gNeighbor,
  gGetNeighbors,
  gGet
  ) where

import Data.Maybe

type Graph a b = ([Vertex a], [(Int, Int, b)])
type Vertex a = (Int, a)
type Edge a = (Int, Int, a)
type UGraph a = Graph a ()

emptyGraph = ([],[]) :: Graph a b

gGet :: Graph a b -> Int -> Maybe a
gGet g id = listToMaybe
            $ map unVertex
            $ filter (\(n, _) -> n == id)
            $ fst g

gGetNeighbors :: Graph a b -> Int -> [Int]
gGetNeighbors g id
  = filter (gNeighbor g id) ids
  where (vs, es) = g
        ids = map gVertexId vs

gNeighbor :: Graph a b -> Int -> Int -> Bool
gNeighbor (vs, es) id id'
  = (&&) (id /= id')
    $ not $ null
    $ filter (gInEdge id) (filter (gInEdge id') es)

gInEdge :: Int -> Edge b -> Bool
gInEdge id (s, t, _) = id == s || id == t

gVertexId :: Vertex a -> Int
gVertexId = fst

gFind :: Eq a => Graph a b -> a -> Maybe Int
gFind g x = fmap fst ((listToMaybe . fst . (gFilter (==x))) g)

gReplace :: Graph a b -> Int -> a -> Graph a b
gReplace (vs, es) id x = (h vs id x, es)
    where h [] _ _ = []
          h ((id', y):vs') id x
              = if id == id'
                then (id, x):vs'
                else (id', y):(h vs' id x)

gAdd :: Graph a b -> a -> Graph a b
gAdd (vs, es) x = ((freshID,x):vs, es)
    where freshID = fromMaybe 1 first :: Int
          first = listToMaybe filtered :: Maybe Int
          filtered = filter (not . ((flip elem) ids)) [1..] :: [Int]
          ids = (map fst vs) :: [Int]

-- 'clean' meaning remove edges that are meaningless
gClean :: Graph a b -> Graph a b
gClean (vs, es) = (vs, filter f es)
    where f (v1, v2, _) = elem v1 ids && elem v2 ids
          ids = map fst vs

gFilter :: (a -> Bool) -> Graph a b -> Graph a b
gFilter f (vs, es) = gClean (newVs, es)
    where newVs = filter (f . snd) vs

unVertex :: Vertex a -> a
unVertex (_, x) = x

toList :: Graph a b -> [a]
toList (vs, _) = map unVertex vs

gAddE :: Graph a b -> Int -> Int -> b -> Graph a b
gAddE (vs, es) id id' x = (vs, (id, id', x) : es)
