
import Game
import Hans

main :: IO ()
main = putStr $ runPure botA botB
  where botA = pureHans
        botB = emptyPureBot

emptyBState = ("", emptyGameState)

type BState = (String, GameState)
type GState = (BState, BState)

runPure :: PureBot -> PureBot -> String
runPure botA botB = showHistory history
  where first = setupGame botA botB :: GState
        final = first :: GState -- << fix here!
        (finalA, _) = final
        (_, finalGameState) = finalA
        (history, _) = finalGameState

setupGame :: PureBot -> PureBot -> GState
setupGame botA _
  = (foldl h emptyBState (lines text1),
     emptyBState)
  where h :: BState -> String -> BState
        h (a, gs) str = botA (str, gs)

text1 = "settings timebank 10000\nsettings time_per_move 500\nsettings max_rounds 50\nsettings your_bot player1\nsettings opponent_bot player2\nsetup_map super_regions 1 2 2 5\nsetup_map regions 1 1 2 1 3 2 4 2 5 2\nsetup_map neighbors 1 2,3,4 2 3 4 5\nsetup_map wastelands 3\nsettings starting_regions 2 4\nsettings starting_pick_amount 1\npick_starting_region 10000 2 4\nsettings starting_armies 7\nupdate_map 1 player1 2 2 player1 4 3 neutral 10 4 player2 5\ngo place_armies 10000\ngo attack/transfer 10000\n"
