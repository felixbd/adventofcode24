import Data.List (sort)

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

d2xss :: [[Int]]
d2xss = [[7, 6, 4, 2, 1], [1, 2, 7, 8, 9], [9, 7, 6, 2, 1],
         [1, 3, 2, 4, 5], [8, 6, 4, 4, 1], [1, 3, 6, 7, 9]]

predicate :: Int -> Int -> Bool
predicate a b = (a /= b) && if a > b then a - b <= 3 else b - a <= 3

numSafeReports :: [[Int]] -> Int
numSafeReports xss = sum [1 | e <- map isReportSafe xss, e]
  where
    isReportSafe :: [Int] -> Bool
    isReportSafe xs = (xs == sort xs || xs == reverse (sort xs)) &&
      and [predicate t z | (t, z) <- zip xs (tail xs)]

numSafeReportsV2 :: [[Int]] -> Int
numSafeReportsV2 xss = sum [1 | e <- map isReportSafe xss, e]
  where
    isReportSafe :: [Int] -> Bool
    isReportSafe xs = (xs == sort xs || xs == reverse (sort xs)) &&  -- todo ...
      sum [1 | j <- [predicate t z | (t, z) <- zip xs (tail xs)], not j] < 2


main :: IO ()
main = do
  putStrLn "day 1"
  print $ totalDistance d1xs d1ys
  print $ similarityScore d1xs d1ys

  putStrLn "day 2"
  print $ numSafeReports d2xss
  print $ numSafeReportsV2 d2xss
