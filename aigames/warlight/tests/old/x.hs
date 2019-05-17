--
-- ghc chantest.hs -o chantest
-- Usage: Enter "1", "2" or "0" to exit.
--
 
import System.IO
import Control.Concurrent
import Control.Concurrent.Chan
import Text.Printf
 
--
-- Rather tha wait on multiple channels, it strikes me that you could
-- have a single channel, and tag each thread's input. then lazily
-- stream the chans contents through a filter, passing the *pure* list
-- of filtered elements to a consuming thread

type Pipe = Chan (Either String String)
 
main :: IO ()
main = do
    chan      <- newChan :: IO Pipe
    s         <- getChanContents chan   -- lazy list of chan elements
    c1Thread  <- forkIO $ reader "c1" (catLeft  s) -- read only Lefts
    c2Thread  <- forkIO $ reader "c2" (catRight s) -- read only Rights
    writer chan
  where
    catLeft :: [Either String String] -> [String]
    catLeft  ls = [x | Left  x <- ls]
    catRight ls = [x | Right x <- ls]
 
writer :: Pipe -> IO ()
writer chan = loop
  where
    loop = getChar >>= command
    command '0'  = print "done"
    command '1'  = writeChan chan (Left  "main: 1") >> loop
    command '2'  = writeChan chan (Right "main: 2") >> loop
    command '\n' = loop -- ignore
    command c    = printf "Illegal: %c\n" c         >> loop
 
reader :: String -> [String] -> IO ()
reader name xs = mapM_ (printf "%s %s\n" name) xs
