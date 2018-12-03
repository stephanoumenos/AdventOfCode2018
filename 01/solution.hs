import System.IO
import qualified Data.Set as S

removePlus s | head s == '+' = tail s
             | otherwise = s

firstRepeated numbers set currentSum | S.member (newSum) set = newSum
                                     | otherwise = firstRepeated (tail numbers) (S.insert (newSum) set) (currentSum + head numbers)
    where newSum = currentSum + head numbers

main = do
    handle <- openFile "input" ReadMode
    contents <- hGetContents handle
    let noPlusNumbers = map removePlus $ lines contents
    let intNumbers = map (\x -> read x::Int) noPlusNumbers
    -- Part 1
    putStr "Sum: "
    print $ sum intNumbers
    -- Part 2
    putStr "First repeated: "
    print $ firstRepeated (cycle intNumbers) S.empty 0
    hClose handle
