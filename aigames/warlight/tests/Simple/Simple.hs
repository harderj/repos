
import System.IO



main :: IO ()
main = do eof <- isEOF
          if eof then main
            else do ready <- hReady stdin
                    if ready then
                      do l <- getLine
                         if (l == "exit") then return ()
                           else do something l
                                   main
                      else main

something :: String -> IO ()
something l = let ws = words l in
  case ws of ("pick_starting_regions":t:xs) -> putStrLn $ unwords $ take 6 xs
             ("go":_) -> putStrLn "No moves"
             _ -> return ()




-- test :: IO ()
-- test = 

-- main = do comeOn <- hWaitForInput stdin 20
--           if comeOn
--             then do getLine
--                     putStrLn "No moves"
--                     main
--             else main

-- main :: IO ()
-- main =
--   let i = stdin
--       o = stdout
--   in do ready <- hReady i
--         if ready then do
--           line <- hGetLine i 
--           hPutStrLn o "Hi! Still no moves.."
--           main
--           else do
--           hPutStrLn o "No moves"
--           main

-- main :: IO ()
-- main =
--   do eof <- hIsEOF stdin
--      case eof of
--        True -> return ()
--        False
--          -> do putStrLn "No moves"
--                main

-- main :: IO ()
-- main = loop stdin stdout
-- -- main = do h <- openFile "./text.txt" ReadWriteMode
-- --           loop h

-- loop :: Handle -> Handle -> IO ()
-- loop i o = do
--   eof <- hIsEOF i
--   case eof of
--     True -> return ()
--     False
--       -> do line <- hGetLine i
--             hPutStrLn o "No moves"
--             loop i o


-- loop :: Handle -> Handle -> IO ()
-- loop i o =
--   do eof <- hIsEOF i
--      if eof then return () else do
--        line <- hGetLine i
--        let wds = words line
--        case wds of
--          "pick_starting_region":_
--            -> hPutStrLn o "pick"
--          "go":"place_armies":_
--            -> hPutStrLn o "place"
--          _ -> hPutStrLn o "what"
--        loop i o

