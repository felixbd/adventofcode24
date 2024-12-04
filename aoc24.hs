-- | aoc 2024

{-# LANGUAGE LambdaCase #-}

import Data.List (sort, nub, tails, stripPrefix, isSuffixOf)

-- day 1 --------------------------------------------------------------------

-- [e.split()[0] for e in  x.split("\n")[:-1]]

d1xs :: [Int]
d1xs = [3, 4, 2, 1, 3, 3]

d1ys :: [Int]
d1ys = [4, 3, 5, 3, 9, 3]

totalDistance :: [Int] -> [Int] -> Int
totalDistance xs ys = sum [abs (x - y) | (x, y) <- zip (sort xs) (sort ys)]

similarityScore :: [Int] -> [Int] -> Int
similarityScore xs ys = sum [x * sum [1 | y <- ys, y == x] | x <- xs]

-- day 2 --------------------------------------------------------------------

-- [[int(g) for g in e.split()] for e in x.split("\n")]
-- [list(map(lambda g: int(g), e.split())) for e in x.split("\n")[:-1]]

d2xss :: [[Int]]
d2xss = [[7, 6, 4, 2, 1], [1, 2, 7, 8, 9], [9, 7, 6, 2, 1],
         [1, 3, 2, 4, 5], [8, 6, 4, 4, 1], [1, 3, 6, 7, 9]]

isSafeBasic :: [Int] -> Bool
isSafeBasic levels =
    allIncreasing || allDecreasing
  where
    diffs = zipWith (-) (tail levels) levels
    allIncreasing = all (\d -> d >= 1 && d <= 3) diffs
    allDecreasing = all (\d -> d <= -1 && d >= -3) diffs

isSafeWithDampener :: [Int] -> Bool
isSafeWithDampener levels
    | isSafeBasic levels = True
    | otherwise = any (isSafeBasic . removeAt) [0 .. length levels - 1]
  where
    removeAt i = take i levels ++ drop (i + 1) levels


-- day 3 ------------------------------------------------------------------------

-- v2

getBrackets :: String -> [Int]
getBrackets xs = concat [[li | ri <- r, li + 1 == ri] | li <- l]
  where
    l = [i | (c, i) <- zip xs [1..], c == '(']
    r = [i | (c, i) <- zip xs [1..], c == ')']

-- check if the bracket is prefixed by a "don't" or "do"

data PrefixType = No | Dont | Do deriving (Show, Eq)

checkBracketPrefix :: String -> [Int] -> [(Int, PrefixType)]
checkBracketPrefix xs ys = filter (\(u, v) -> v /= No) [(y, f y) | y <- ys]
  where
    f j = p $ take 5 (drop (j - 6) xs)
      where
        p s = if isSuffixOf "don't" s then Dont else if isSuffixOf "do" s then Do else No


findDropRanges :: [(Int, PrefixType)] -> [(Int, Int)]
findDropRanges = undefined

d3helper :: String -> [(Int, PrefixType)]
d3helper xs = checkBracketPrefix xs $ getBrackets xs



mullItOver :: FilePath -> IO [(Int, PrefixType)]
mullItOver fp = readFile fp >>= \c -> return $ d3helper c

-- stripPrefix
-- isPrefixOf


---------------------------------------------------------------------------------

main :: IO ()
main = do
  putStrLn "day 1"
  print $ totalDistance d1xs d1ys
  print $ similarityScore d1xs d1ys

  putStrLn "day 2"
  print $ sum [1 | e <- map isSafeBasic d2xss, e]
  print $ sum [1 | e <- map isSafeWithDampener d2xss, e]

  putStrLn "day 3"
  d3xs <- mullItOver "mul.txt"
  print d3xs
