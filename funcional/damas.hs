
initialize :: Int -> Int -> [[String]]
initialize x y  = [ [ mapValue m n  | m <- [0..(x - 1)] ] | n <- [0..(y - 1)] ]

mapValue :: Int -> Int -> String
mapValue x y	| (y >= 0 && y <= 2) && (y `mod` 2 /= 0 && x `mod` 2 == 0) = "O"
				| (y >= 0 && y <= 2) && (y `mod` 2 == 0 && x `mod` 2 /= 0) = "O"
				| (y >= 5 && y <= 7) && (y `mod` 2 /= 0 && x `mod` 2 == 0) = "X"
				| (y >= 5 && y <= 7) && (y `mod` 2 == 0 && x `mod` 2 /= 0) = "X"
				| otherwise = " " 

showMatrix :: [[String]] -> String
showMatrix m = concat ( concat [ [ mapMatrix y | y <- x] ++ ["\n"]| x <- m])

mapMatrix :: String -> String
mapMatrix value	| (value == "O") = " O"
				| (value == "X") = " X"
				| otherwise = " ~"

changePosition :: Int -> Int -> String -> [[String]] -> [[String]]
changePosition x y value matrix = [ [ verifyPosition  x y m n value ( ( matrix !! n ) !! m) | m <- [0..7] ] | n <- [0..7] ]

verifyPosition :: Int -> Int -> Int -> Int -> String -> String -> String
verifyPosition x y m n value old_value	| (x == n && y == m) = value
										| otherwise = old_value

main = do
	let matrix = (initialize 8 8)
	let viewMatrix = showMatrix (matrix)
	putStrLn(viewMatrix)
	let moveOnMatrix = changePosition 3 0 "O" (changePosition 2 1 "~" matrix)
	let viewMoveOnMatrix = showMatrix (moveOnMatrix)
	putStrLn(viewMoveOnMatrix)
