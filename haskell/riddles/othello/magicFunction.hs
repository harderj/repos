import Foreign.Marshal.Utils
import Data.Word

instance Num Bool where
  x + y = (x /= y)
  x * y = (x && y)
  negate True = False
  negate False = True
  abs x = x
  signum x = x
  fromInteger n = toBool n


magicFunction :: [Bool] -> [Bool]
magicFunction = hCalc . hExtend
  where hExtend bs = bs ++ (take (toNext2n $ length bs) $ repeat False)
        hCalc :: [Bool] -> [Bool]
        hCalc bs = reverse $ map hSum $ getCuts bs
        hSum = foldr (+) False

getCuts xs = take m $ map (flip takeNdropN $ xs) (iterate (*2) 1)
  where m = floor $ logBase 2 $ fromIntegral $ length xs

toNext2n :: Int -> Int
toNext2n n = round (2 ** m) - n
  where m = fromIntegral $ ceiling $ logBase 2 $ fromIntegral n

takeNdropN :: Int -> [a] -> [a]
takeNdropN n xs = if n > length xs
                  then []
                  else take n xs ++ takeNdropN n (drop (2*n) xs)


-- magicFunc :: Integral a => a -> a
-- magicFunc n = undefined --

-- toBits :: Integral a => a -> [Bool]
-- toBits n = map helper [2..]
--   where helper m = toBool $ div (mod n 2^m) 2^(m-1)

