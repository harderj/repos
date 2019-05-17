module Game (
  Bot,
  PureBot,
  History,
  GameState,
  State,
  Map,
  Region,
  Ownership (..),
  GameInfo,
  SuperRegion,
  emptyRegion,
  emptyMap,
  emptyState,
  emptyGameState,
  showHistory,
  rGetId,
  getRegion,
  territory,
  makeNeighbor,
  toGraphId,
  emptyPureBot,
  rGetArmies,
  toRegionId
  ) where

import Graph
import Data.Maybe

type Bot = IO ()
type PureBot = (String, GameState) -> (String, GameState)
type History = [String]
data Ownership = Player String | Neutral
                 deriving (Show, Eq)
-- Region ~ (ID, owner, 'if known' (#armies, superRegion))
type Region = (Int, Int, Maybe (Ownership, Int))
type SuperRegion = (Int, Int)
type Map = UGraph Region
-- GameInfo ~ (yourName, opp.Name, startRegs, pickAmount, superRegs)
type GameInfo = (String, String, [Int], Int, [SuperRegion])
-- State ~ (round#, #armies, map, gameinfo)
type State = (Int, Int, Map, GameInfo)
type GameState = (History, State)

emptyBot = return () :: Bot
emptyPureBot :: PureBot
emptyPureBot _ = ("", emptyGameState)
emptyMap = emptyGraph :: Map
emptyState = (0, 0, emptyGraph, ("","",[],0,[])) :: State
emptyGameState = ([], emptyState) :: GameState
emptyRegion = (0,0,Nothing) :: Region

rGetArmies :: Region -> Maybe Int
rGetArmies (_, _, info) = case info of
  Nothing -> Nothing
  Just (_, n) -> Just n

toRegionId :: Map -> Int -> Maybe Int
toRegionId m gId
  = let r = gGet m gId
    in case r of
      Nothing -> Nothing
      Just (rId, _, _) -> Just rId

showHistory :: History -> String
showHistory = unlines . reverse

makeNeighbor :: Map -> Int -> Int -> Map
makeNeighbor m rID rID'
    = case (eID, eID') of
        (Just id, Just id') -> gAddE m id id' ()
        _ -> m
    where eID = toGraphId m rID
          eID' = toGraphId m rID'

toGraphId :: Map -> Int -> Maybe Int
toGraphId m n = gFind m reg
    where potentialRegion = getRegion m n :: Maybe Region
          reg = fromMaybe emptyRegion potentialRegion :: Region

rGetId :: Region -> Int
rGetId (n, _, _) = n

getRegion :: Map -> Int -> Maybe Region
getRegion m id
    = let one = gFilter ((==id) . rGetId) m :: Map
          two = listToMaybe $ map snd $ fst one :: Maybe Region
      in two

territory :: Map -> Ownership -> [Int]
territory m owner
    = map rGetId (toList $ gFilter f m)
      where f :: Region -> Bool
            f (_, _, Just (own, _)) = own == owner
            f _ = False
