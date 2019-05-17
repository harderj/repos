import System.Environment
import System.Directory
import Control.Monad
import System.FilePath
import Data.List

main :: IO ()
main = do
  args <- getArgs
  pwd <- getCurrentDirectory
  list <- ls pwd
  case args of
    [] -> mapM_ putStrLn list
    ext:_ -> let nList = filter (isInfixOf ext) list
             in mapM_ putStrLn nList

-- ls :: FilePath -> IO [FilePath]
-- ls path = do
--   pwd = getCurrentDirectory

ls :: FilePath -> IO [FilePath]
ls path = do
  setCurrentDirectory path
  conts <- getDirectoryContents path
  files <- getFiles conts
  dirs <- getDirs (filter helpf conts)
  pwd <- getCurrentDirectory
  moreFiles <- mapM ls (helpg pwd dirs)
  return ((helpg pwd files) ++ (concat moreFiles))
    where helpf :: FilePath -> Bool
          helpf p = let name = (last . splitDirectories) p
                    in name /= "." && name /= ".."
          helpg :: FilePath -> [FilePath] -> [FilePath]
          helpg p = map ((p++"/")++)
  

getFiles :: [FilePath] -> IO [FilePath]
getFiles [] = return []
getFiles (p:ps) = do
  b <- doesFileExist p
  r <- getFiles ps
  if b then return (p : r)
  else return r

getDirs :: [FilePath] -> IO [FilePath]
getDirs [] = return []
getDirs (p:ps) = do
  b <- doesDirectoryExist p
  r <- getDirs ps
  if b then return (p : r)
  else return r
