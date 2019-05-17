
import System.IO

main :: IO ()
main = loop ""

loop :: String -> IO ()
loop history =
    let hIn = stdin
        hOut = stdout
    in do line <- hGetLine hIn
          hPutStr hOut (answer (history ++ ('\n' : line)))
          eof <- hIsEOF hIn
          if eof || line == "exit"
          then return () -- game over
          else loop (history ++ ('\n' : line))

type History = String
type Event = String
type Region = Int

lastEvent :: History -> Event
lastEvent h = last . lines $ h

answer :: History -> Event
answer h =
    let le = lastEvent h
        parts = words le
    in case parts 
       of "pick_starting_regions":t:_ -> pickStartingRegions le
          "go":"place_armies":[t] -> placeArmies h
          "go":"attack/transfer":[t] -> attackTransfer h
          _ -> "Bot failure: Couldn't understand given command!"

pickStartingRegions :: Event -> Event
pickStartingRegions _ = "pickStartingRegions? But how.."

placeArmies :: History -> Event
placeArmies h = "placeArmies? But how.."

attackTransfer :: History -> Event
attackTransfer h = "attack/transfer? But how.."
