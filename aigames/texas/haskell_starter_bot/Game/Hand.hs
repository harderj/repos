module Game.Hand(Hand) where

import Game.Card
import Data.List(sort, sortOn, group)

type Hand = (Card, Card, Card, Card, Card)

-- The AbstractHand is what is compared in the showdown. The
-- constructor should be selfexplaining. The arguments after that specify
-- the hights of the relevant cards in the AbstractHand.

-- For example: 5h 5c 5d 9d 9s would get you a FullHouse 5 9
data AbstractHand = StraightFlush Height -- hight of highest card
                  | FourOfAKind Height Height
                  | FullHouse Height Height
                  | Flush Height Height Height Height Height
                  | Straight Height -- Height of highest card
                  | ThreeOfAKind Height Height Height
                  | TwoPair Height Height Height
                  | OnePair Height Height Height Height
                  | HighCard Height Height Height Height Height
                  deriving (Eq, Show)

instance Ord AbstractHand where
  -- compare abstract hands against themselfs
  compare (StraightFlush g) (StraightFlush h) = compare g h
  compare (FourOfAKind g1 g2) (FourOfAKind h1 h2) = compare (g1, g2) (h1, h2)
  compare (FullHouse g1 g2) (FullHouse h1 h2) = compare (g1, g2) (h1, h2)
  compare (Flush g1 g2 g3 g4 g5) (Flush h1 h2 h3 h4 h5) = compare (g1, g2, g3, g4, g5) (h1, h2, h3, h4, h5)
  compare (Straight g1) (Straight h1) = compare g1 h1
  compare (ThreeOfAKind g1 g2 g3) (ThreeOfAKind h1 h2 h3) = compare (g1, g2, g3) (h1, h2, h3)
  compare (TwoPair g1 g2 g3) (TwoPair h1 h2 h3) = compare (g1, g2, g3) (h1, h2, h3)
  compare (OnePair g1 g2 g3 g4) (OnePair h1 h2 h3 h4) = compare (g1, g2, g3, g4) (h1, h2, h3, h4)
  compare (HighCard g1 g2 g3 g4 g5) (HighCard h1 h2 h3 h4 h5) = compare (g1, g2, g3, g4, g5) (h1, h2, h3, h4, h5)

  -- compare abstract hands against each other
  compare   (StraightFlush _) _    = GT
  compare _ (StraightFlush _)      = LT
  compare   (FourOfAKind _ _) _    = GT
  compare _ (FourOfAKind _ _)      = LT
  compare   (FullHouse _ _) _      = GT
  compare _ (FullHouse _ _)        = LT
  compare   (Flush _ _ _ _ _) _    = GT
  compare _ (Flush _ _ _ _ _)      = LT
  compare   (Straight _) _         = GT
  compare _ (Straight _)           = LT
  compare   (ThreeOfAKind _ _ _) _ = GT
  compare _ (ThreeOfAKind _ _ _)   = LT
  compare   (TwoPair _ _ _) _      = GT
  compare _ (TwoPair _ _ _)        = LT
  compare   (OnePair _ _ _ _) _    = GT
  compare _ (OnePair _ _ _ _)      = LT

abstract :: Hand -> AbstractHand
abstract hand = case (isStraight hand, isFlush hand, heightPattern hand) of
-- Flush       Straight   Pattern
  (Just high, Just _    , HighCard _ _ _ _ _) -> StraightFlush high
  (Nothing  , Nothing   , FourOfAKind a b)    -> FourOfAKind a b
  (Nothing  , Nothing   , FullHouse a b)      -> FullHouse a b
  (Nothing  , Just flush, HighCard _ _ _ _ _) -> flush
  (Just high, Nothing   , HighCard _ _ _ _ _) -> Straight high
  (Nothing  , Nothing   , ThreeOfAKind a b c) -> ThreeOfAKind a b c
  (Nothing  , Nothing   , TwoPair a b c)      -> TwoPair a b c
  (Nothing  , Nothing   , OnePair a b c d)    -> OnePair a b c d
  (Nothing  , Nothing   , HighCard a b c d e) -> HighCard a b c d e
  unknown                                     -> error $ "unknown pattern: " ++ (show unknown)
  where

    heightPattern :: Hand -> AbstractHand
    heightPattern hand = case groupedHeights hand of
      [[a,_,_,_],[b]]       -> FourOfAKind a b
      [[a,_,_],[b,_]]       -> FullHouse a b
      [[a,_,_],[b],[c]]     -> ThreeOfAKind a b c
      [[a,_],[b,_],[c]]     -> TwoPair a b c
      [[a,_],[b],[c],[d]]   -> OnePair a b c d
      [[a],[b],[c],[d],[e]] -> HighCard a b c d e
      otherwise -> error $ "Unexpected pattern : " ++ (show (groupedHeights hand))
      where
        groupedHeights :: Hand -> [[Height]]
        groupedHeights = reverse         -- [[7,7],[5,5],6]
                         . sortOn length -- [[6],[5,5],[7,7]]
                         . group         -- [[5,5],[6],[7,7]]
                         . sort          -- [5,5,6,7,7]
                         . map height    -- [7,5,6,7,5]
                         . handToList    -- [7c, 5s, 6h, 7h, 5d]

    isFlush :: Hand -> Maybe AbstractHand
    isFlush hand = if ((==) 1 . length . group . map suit . handToList $ hand)
                   then Just $ Flush a b c d e
                   else Nothing
      where [a,b,c,d,e] = sort
                          . map height
                          . handToList
                          $ hand


    isStraight :: Hand -> Maybe Height
    isStraight = isStraight' . sort . map height . handToList
      where
        isStraight' :: [Height] -> Maybe Height
        isStraight' [Ace, Two, Three, Four, Five] = Just Five
        isStraight' [Two, Three, Four, Five, Six] = Just Six
        isStraight' [Three, Four, Five, Six, Seven] = Just Seven
        isStraight' [Four, Five, Six, Seven, Eight] = Just Eight
        isStraight' [Five, Six, Seven, Eight, Nine] = Just Nine
        isStraight' [Six, Seven, Eight, Nine, Ten] = Just Ten
        isStraight' [Seven, Eight, Nine, Ten, Jack] = Just Jack
        isStraight' [Eight, Nine, Ten, Jack, Queen] = Just Queen
        isStraight' [Nine, Ten, Jack, Queen, King] = Just King
        isStraight' [Ten, Jack, Queen, King, Ace] = Just Ace
        isStraight' _ = Nothing

showDown :: [Card] -> AbstractHand
showDown = maximum
           . map abstract
           . map listToHand
           . sublistsOfLength 5
  where
    sublistsOfLength :: Int -> [a] -> [[a]]
    sublistsOfLength 0 _ = [[]]
    sublistsOfLength _ [] = []
    sublistsOfLength n (x:xs) = (sublistsOfLength n xs) ++ map (x:) (sublistsOfLength (n-1) xs)

handToList :: Hand -> [Card]
handToList (a,b,c,d,e) = [a,b,c,d,e]

listToHand :: [Card] -> Hand
listToHand [a,b,c,d,e] = (a,b,c,d,e)






