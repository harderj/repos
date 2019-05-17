import System.Process
import System.Directory
import System.Environment

main :: IO ()
main = do
  args <- getArgs
  if length args < 2
    then putStrLn "Please supply two players."
    else let (command1:command2:_) = args
         in do perms1 <- getPermissions command1
               perms2 <- getPermissions command2
               if executable perms1
                 then runProcess [] Nothing


loop :: IO 




