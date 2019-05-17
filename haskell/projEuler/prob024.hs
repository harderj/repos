

import Data.List

--solution = (!!(10^6-1)) $ sort $ permutations [0..9]

solGen n m = (!!(n-1)) $ sort $ permutations [0..m]

solution = solGen (10^6) 9 :: [Int]
