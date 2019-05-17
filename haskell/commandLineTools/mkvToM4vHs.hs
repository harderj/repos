

import System.Cmd
import System.Directory
import Text.Regex
import Data.Maybe
import Data.List

main = do
  cs <- ls
  let mkvs = filter isMkv cs
  mapM_ conv mkvs

--conv :: String -> IO
conv str = do createDirectoryIfMissing False "conv"
              system cmd
  where cmd = "avconv -i "
              ++ str
              ++ " -c copy "
              ++ "conv/"
              ++ (dropL 4 str)
              ++ ".m4v"

dropL n = reverse . (drop n) . reverse

ls = getDirectoryContents "."

isHs = isSuffixOf ".hs"

isMkv = isSuffixOf ".mkv"
