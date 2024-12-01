import Data.List (sort)

xs = [7, 4, 1]
ys = [9, 6, 3]

main :: IO ()
main = do
        print $ sum [abs (x - y) | (x, y) <- zip (sort xs) (sort ys)]
        print $ sum [x * (sum [1 | y <- ys, y == x]) | x <- xs]
