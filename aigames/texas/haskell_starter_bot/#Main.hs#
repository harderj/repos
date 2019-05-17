import Control.Monad (unless)
import Control.Monad.IO.Class (liftIO)
import Control.Monad.Trans.State.Lazy (StateT, get, put, modify,  evalStateT)
import System.IO (hSetBuffering, BufferMode(LineBuffering), stdin, stdout, stderr, hFlush, isEOF)

import Game.GameState
import Game.Input
import Intelligence (findBestMove)

main :: IO()
main = do
  hSetBuffering stdin LineBuffering
  evalStateT loop initialGameState

-- GameState in a State-IO-monad
type Context = StateT GameState IO

loop :: Context ()
loop = do
  -- Read and parse one line from stdin
  line  <- liftIO getLine
  case parse line of
    Nothing -> return ()
    -- If necessary update the gamestate ...
    Just (SettingsUpdate setting) ->  modify (applySettingsUpdate setting)
    Just (MatchUpdate update) -> modify (applyMatchUpdate update)
    Just (ActionRequest time) -> do
      -- ...or perform your move. For that we need the current gamestate
      gamestate <- get
      -- Logging the gamestate, so we can improove out bot
      debug $ "Current gamestate:":(showGameState gamestate)
      let bestMove = findBestMove gamestate
      liftIO . print $ bestMove
      liftIO (hFlush stdout)
  eof   <- liftIO isEOF
  unless eof loop

debug :: [String] -> Context()
debug logLines = do
  if doLog then do
    liftIO . putStrLn . unlines $ logLines
    liftIO . hFlush $ stderr
  else return ()
  -- enable logging here
  where doLog = True
