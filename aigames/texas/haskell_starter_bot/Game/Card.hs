module Game.Card where

-- Data types for single cards

data Card = Card {
  height :: Height,
  suit :: Suit
  }

data Height = Two
            | Three
            | Four
            | Five
            | Six
            | Seven
            | Eight
            | Nine
            | Ten
            | Jack
            | Queen
            | King
            | Ace
            deriving (Ord, Eq, Enum)

data Suit = Spades
          | Hearts
          | Clubs
          | Diamonds
          deriving Eq

-- Show

instance Show Card where
  show card = show (height card) ++ show (suit card)

instance Show Suit where
  show Spades   = "s"
  show Hearts   = "h"
  show Clubs    = "c"
  show Diamonds = "d"

instance Show Height where
  show Two   = "2"
  show Three = "3"
  show Four  = "4"
  show Five  = "5"
  show Six   = "6"
  show Seven = "7"
  show Eight = "8"
  show Nine  = "9"
  show Ten   = "T"
  show Jack  = "J"
  show Queen = "Q"
  show King  = "K"
  show Ace   = "A"

-- Read

instance Read Height where
  readsPrec _ ('2':str) = [(Two, str)]
  readsPrec _ ('3':str) = [(Three, str)]
  readsPrec _ ('4':str) = [(Four, str)]
  readsPrec _ ('5':str) = [(Five, str)]
  readsPrec _ ('6':str) = [(Six, str)]
  readsPrec _ ('7':str) = [(Seven, str)]
  readsPrec _ ('8':str) = [(Eight, str)]
  readsPrec _ ('9':str) = [(Nine, str)]
  readsPrec _ ('T':str) = [(Ten, str)]
  readsPrec _ ('J':str) = [(Jack, str)]
  readsPrec _ ('Q':str) = [(Queen, str)]
  readsPrec _ ('K':str) = [(King, str)]
  readsPrec _ ('A':str) = [(Ace, str)]
instance Read Suit where
  readsPrec _ ('s':str) = [(Spades, str)]
  readsPrec _ ('h':str) = [(Hearts, str)]
  readsPrec _ ('c':str) = [(Clubs, str)]
  readsPrec _ ('d':str) = [(Diamonds, str)]
instance Read Card where
  readsPrec _ (h:s:str) = [(Card {height = read [h], suit = read [s]}, str)]
  -- I guess this is not the easiest way to do this
  readList (',':str) = readList str
  readList (' ':str) = readList str
  readList [h,s] = [([Card {height = read [h], suit = read [s]}], "")]
  readList (h:s:str) = zip (map ((card:) . fst) list) (map snd list)
    where
      suit :: Suit
      suit = read [s]
      height :: Height
      height = read [h]
      card = Card height suit
      list = readList $ str
  readList _ = []

