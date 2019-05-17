module PIN where

getPINs :: String -> [String]
getPINs [] = []
getPINs (c:[]) = map (:[]) $ adjacents c
getPINs (c:cs) = concatMap (\c -> map (c:) $ getPINs cs) $ adjacents c

adjacents :: Char -> String
adjacents c =
  case c of
    '1' -> "124"
    '2' -> "1235"
    '3' -> "236"
    '4' -> "1457"
    '5' -> "24568"
    '6' -> "3569"
    '7' -> "478"
    '8' -> "57890"
    '9' -> "689"
    '0' -> "08"
    _ -> ""
