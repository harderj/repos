
import System.Random
import Control.Monad
import Data.List

rnd_select :: [a] -> Int -> IO [a]
rnd_select l n =
  do idxs <- replicateM n $ getStdRandom $ randomR (0, length l - 1)
     return [l !! i | i <- idxs]

rnd_permu :: Eq a => [a] -> IO [a]
rnd_permu [] = return []
rnd_permu l = do
  x <- liftM head $ rnd_select l 1
  xs <- rnd_permu (delete x l)
  return (x : xs)

permute :: [Int] -> [a] -> [a]
permute p l = map (\n -> l !! n) p



