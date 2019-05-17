module Hans.Hans (
  hans,
  pureHans
  ) where

import System.IO
import Data.Maybe
import Data.List
import Hans.Graph
import Hans.Game

-- this is the fun part

type Attack = (Int, Int, Int)

attackTransfer :: State -> Maybe String
attackTransfer _ = Just "No moves"
-- attackTransfer s
--   = Just (unwords $ (myName gi)
--           : "attack/transfer"
--           : (map showAttack attacks)
--          )
--     where showAttack :: Attack -> String
--           showAttack (src, tar, n)
--             = unwords [show src, show tar, show n]
--           attacks = findAttacks s
--           (rN, aN, m, gi) = s

findAttacks :: State -> [Attack]
findAttacks (_, _, m, gi)
  = let myRegIds = territory m (Player (myName gi)) :: [Int]
        myRegs = catMaybes $ map (getRegion m) myRegIds :: [Region]
        myStrongRegs = filter strong myRegs :: [Region]
        whichNeighbor :: Region -> Maybe Attack
        whichNeighbor r
          = let nGIds = gGetNeighbors m gId :: [Int]
                rId = rGetId r :: Int
                gId = fromMaybe (-1) $ toGraphId m rId :: Int
                ns = catMaybes $ map (gGet m) nGIds :: [Region]
                target = listToMaybe ns :: Maybe Region
                force = (fromJust $ rGetArmies r) - 1 :: Int
            in case target of
              Nothing -> Nothing
              Just tar -> Just (rId, rGetId tar, force)
    in catMaybes $ map whichNeighbor myStrongRegs

strong :: Region -> Bool
strong (_, _, Just (_, n)) = n > 1
strong _ = False

pickStartingRegions :: State -> Maybe String
pickStartingRegions (_, _, m, gameInfo) =
  let (_, _, startRegs, _, _) = gameInfo
  in Just ((unwords . (take 6) . (map show)) startRegs)

placeArmies :: State -> Maybe String
placeArmies s
    = Just (unwords $ (myName gi)
            : "place_armies"
            : (show r)
            : [(show n)]
           )
      where r = bestRegion s
            (_, n, m, gi) = s

bestRegion :: State -> Int
bestRegion (_, _, m, gi)
    = head $ territory m $ Player (myName gi)














--- this is just utility

hans :: IO ()
hans = do s <- loop emptyGameState
          return ()

pureHans :: PureBot
pureHans (line, (hist, s)) = (a, (a:line:hist, newS))
    where wds = words line
          a = fromMaybe "roger that" (answer s wds)
          newS = makeSetting s wds

loop :: GameState -> IO String
loop (h, s) =
  do eof <- hIsEOF stdin
     line <- getLine
     if eof || line == "exit" then return (showHistory h)
       else do let newH = line : h
                   wds = words line
                   a = answer newS wds
                   newS = makeSetting s wds
               case a of
                 Nothing
                   -> do --putStrLn "No moves"
                         loop (newH, newS)
                 Just str
                   -> do putStrLn str
                         loop (str:newH, newS)

answer :: State -> [String] -> Maybe String
answer s input
    = case input of
        "pick_starting_regions":t:rs
            -> pickStartingRegions s
        "go":"place_armies":[t]
            -> placeArmies s
        "go":"attack/transfer":[t]
            -> attackTransfer s
        _ -> Nothing

makeSetting :: State -> [String] -> State
makeSetting s input
    = case input of
        "settings":"your_bot":[name]
          -> setOwnName s name
        "settings":"opponent_bot":[name]
          -> setOpponentName s name
        "update_map":wds
          -> updateMap s wds
        "setup_map":"super_regions":wds
          -> setupSuperRegions s wds
        "setup_map":"regions":wds
          -> setupRegions s wds
        "setup_map":"neighbors":wds
          -> setupNeighbors s wds
        "settings":"starting_armies":wd:wds
          -> updArmies s wd
        "pick_starting_regions":t:wds
          -> setupStartingRegions s wds
        _ -> s

setupStartingRegions :: State -> [String] -> State
setupStartingRegions (n, a, m, (n1, n2, _, p, sr)) wds
  = (n, a, m, (n1, n2, startingRegions, p, sr))
  where startingRegions = map read wds :: [Int]

updArmies :: State -> String -> State
updArmies (n, a, m, g) s = (n, read s, m, g)

setOwnName :: State -> String -> State
setOwnName (round, armies, map, (you, him, sRegs, pick, sr)) name
    = (round, armies, map, (name, him, sRegs, pick, sr))

setOpponentName :: State -> String -> State
setOpponentName (round, armies, map, (you, him, sRegs, pick, sr)) name
    = (round, armies, map, (you, name, sRegs, pick, sr))

updateMap :: State -> [String] -> State
updateMap (rN, aN, m, (y, h, sRs, pN, sr)) (w1:w2:w3:ws)
    = (rN, aN, um m (read w1) ow (read w3), (y, h, sRs, pN, sr))
      where ow = case w2 of "neutral" -> Neutral
                            name -> Player name
            um :: Map -> Int -> Ownership -> Int -> Map
            um m id own a
                = gReplace m gID newR
                  where gID = fromMaybe (-1) (gFind m oldR)
                        oldR = fromJust $ getRegion m id
                        (_, sr, _) = oldR
                        newR = (id, sr, Just (own, a))
updateMap s _ = s

setupSuperRegions :: State -> [String] -> State
setupSuperRegions s (w1:w2:ws)
    = (rN, aN, m, newGi)
    where (rN, aN, m, oldGi) = s :: State
          (y, h, sRegs, sPick, oldSrs) = oldGi :: GameInfo
          newSr = (read w1, read w2):oldSrs :: [SuperRegion]
          newGi = (y, h, sRegs, sPick, newSr) 

setupRegions :: State -> [String] -> State
setupRegions (rN, aN, m, gi) (w1:w2:ws)
    = (rN, aN, h m (read w1) (read w2), gi)
      where h :: Map -> Int -> Int -> Map
            h m id sId = gAdd m (id, sId, Nothing)
setupRegions s _ = s

setupNeighbors :: State -> [String] -> State
setupNeighbors s (w1:w2:ws)
    = let thisId = read w1 :: Int
          linkedIds = (map read) $ wordsBy ',' w2 :: [Int]
          f :: Int -> Map -> Map
          f n m = makeNeighbor m thisId n
          newMap = foldr f oldMap linkedIds :: Map
          (r, a, oldMap, g) = s :: State
      in (r, a, newMap, g)

wordsBy :: Eq a => a -> [a] -> [[a]]
wordsBy e xs = map (filter (/= e)) $ (groupBy (\x y -> e /= y)) xs

myName :: GameInfo -> String
myName (name, _, _, _, _) = name
