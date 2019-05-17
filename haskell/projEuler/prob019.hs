
import Data.Time.Calendar
import Data.Time.Calendar.WeekDate

sunday :: Day -> Bool
sunday = (7==) . (\(x, y, z) -> z) . toWeekDate

isBefore :: Day -> Day -> Bool
isBefore d d' = LT == compare d d'

firstDay = fromGregorian 1901 1 1 :: Day
lastDay = fromGregorian 2000 12 31 :: Day

-- firstDay = fromGregorian 2012 6 25 :: Day
-- lastDay = fromGregorian 2015 3 18 :: Day

monthly
  = iterate (addGregorianMonthsClip 1) :: Day -> [Day]

-- paydays of the 20th century
paydays = takeWhile (`isBefore` lastDay)
          $ monthly firstDay :: [Day]

solution1 = length $ filter sunday paydays

solution2 = let days = takeWhile (`isBefore` lastDay)
                       $ iterate (addDays 1) firstDay :: [Day]
                sun = filter sunday :: [Day] -> [Day]
                pay = filter ((\(x,y,z) -> z == 1)
                              . toGregorian) :: [Day] -> [Day]
            in length $ sun $ pay days
