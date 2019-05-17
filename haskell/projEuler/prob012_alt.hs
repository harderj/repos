import Data.List

triNumbers = map (\n -> (n^2 + n) `div` 2) [1..]

factors n = length $ lows ++ (reverse $ map (div n) lows) where lows = filter ((== 0) . mod n) [1..truncate . sqrt $ fromIntegral n]

main = print . head . dropWhile ((<500).snd) . map (tuplize) $ triNumbers

tuplize x = (x,factors x)