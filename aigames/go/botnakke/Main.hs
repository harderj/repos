module Main (main) where

import Control.Monad (unless)
import Control.Monad.IO.Class (liftIO)
import Control.Monad.Trans.State.Lazy (StateT, get, put, modify,  evalStateT)
import System.IO (hSetBuffering, BufferMode(LineBuffering), stdin, stdout, stderr, hFlush, isEOF, hPrint)

import qualified System.Random as R

import GameState
import Botnakke (findBestAction)

type Context = StateT GameState IO

main :: IO ()
main = do
  hSetBuffering stdin LineBuffering
  g <- R.getStdGen
  evalStateT loop ( GameState { myColor = White
                              , board = emptyBoard
                              , timePerMove = 200 } )

loop :: Context ()
loop = do
  line <- liftIO getLine
  case parse line of
    Nothing -> return ()
    Just (Info info)
      -> modify (setGameState info)
    Just (Action time)
      -> do gs <- get
            bestAction <- liftIO $ findBestAction gs time
            liftIO . print $ bestAction
            liftIO (hFlush stdout)
    Just (RoundNumber n)
      -> liftIO $ hPrint stderr ("Round " ++ show n)
  eof <- liftIO isEOF
  unless (line == "quit" || eof) loop
