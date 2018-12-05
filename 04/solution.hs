import Text.Regex.Posix
import Data.List
import System.IO

data GuardState = Asleep | Awake

getYear :: String -> Int
getYear l = read yearString :: Int
    where yearString = l =~ "[0-9]+"

getMonth :: String -> Int
getMonth l = read (init $ tail monthString) :: Int
    where monthString = l =~ "-[0-9]+-"

getDay :: String -> Int
getDay l = read (init $ tail dayString) :: Int
    where dayString = l =~ "-[0-9]+ "

getHour :: String -> Int
getHour l = read (init minuteString) :: Int
    where minuteString = l =~ "[0-9]+:"

getMinute :: String -> Int
getMinute l = read (init minuteString) :: Int
    where minuteString = l =~ "[0-9]+]"

getChronologicalValue :: String -> Float
getChronologicalValue line = k**5 * year + k**4 * month + k**3 * day + k**2 * hour + k**1 * min
    where year = fromIntegral $ getYear line   -- 5
          month = fromIntegral $ getMonth line -- 4
          day = fromIntegral $ getDay line     -- 3
          hour = fromIntegral $ getHour line   -- 2
          min = fromIntegral $ getMinute line  -- 1
          k = 61

organizeInput i = sortOn getChronologicalValue i

findGuadAsleepTheMost = undefined

main = do
    handle <- openFile "input" ReadMode
    contents <- hGetContents handle
    let organizedInput = organizeInput (lines contents)
    print organizedInput
    -- part 1
    let ourGuy = findGuadAsleepTheMost
    hClose handle
