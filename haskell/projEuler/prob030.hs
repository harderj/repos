{-# LANGUAGE FlexibleContexts #-}

special :: Integer -> Bool
special n = n == (sum . (map (^5)) . toDigits) n

toDigits :: (Show a, Num a, Read a) => a -> [a]
toDigits n = (map (read . toList)) $ show n

toList :: a -> [a]
toList a = [a]

specials = filter special [4150..(36*10^4)]
specials' = filter special [4150..200000]

solution = sum specials

main = do print solution
