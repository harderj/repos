
import System.Timeout
import Control.Exception
import System.IO

main = do print "first line"
          hPrint stderr "first error"
          print "second line"

