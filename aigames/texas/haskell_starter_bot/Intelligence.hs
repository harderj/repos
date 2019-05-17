module Intelligence where

import Game.Action
import Game.GameState

-- TODO some more intelligence would be usefull
findBestMove :: GameState -> Action
findBestMove _ = Raise 4000

