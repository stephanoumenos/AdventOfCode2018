import qualified Data.Set as S
import Data.List
import System.IO

numberOfOcurrences e [] n = n
numberOfOcurrences e (x:xs) n | x == e = numberOfOcurrences e xs (n + 1)
                              | otherwise = numberOfOcurrences e xs n


calculateOcurrences [] s two three = (two, three)
calculateOcurrences (c:cs) s two three | S.member c s = calculateOcurrences cs s two three
                                       | otherwise = calculateOcurrences cs (S.insert c s) isTwo isThree
    where ocurrences = (numberOfOcurrences c cs 0) + 1
          isTwo = two || ocurrences == 2
          isThree = three || ocurrences == 3

calculateChecksum [] numberOfTwos numberOfThrees = numberOfTwos * numberOfThrees
calculateChecksum (w:ws) numberOfTwos numberOfThrees = calculateChecksum ws newTwos newThrees
    where ocurrences = calculateOcurrences w S.empty False False
          newTwos | fst ocurrences == True = numberOfTwos + 1
                  | otherwise = numberOfTwos
          newThrees | snd ocurrences == True = numberOfThrees + 1
                    | otherwise = numberOfThrees

-- part 2 functions

differByOne [] [] x = x == 1
differByOne (w1:w1s) (w2:w2s) x | w1 == w2 = differByOne w1s w2s x
                                | otherwise = differByOne w1s w2s (x+1)

possibleMatches :: [String] -> Maybe (String, String)
possibleMatches [] = Nothing
possibleMatches (w:ws) | length matches > 0 = Just (w, head matches)
                       | otherwise = possibleMatches ws
    where matches = filter (\w' -> differByOne w w' 0) ws

main = do
    handle <- openFile "input" ReadMode
    contents <- hGetContents handle
    -- part 1
    putStr "Checksum: "
    print $ calculateChecksum (lines contents) 0 0
    -- part 2
    putStr "Matches with 1 char different: "
    print $ possibleMatches (lines contents)
    hClose handle
