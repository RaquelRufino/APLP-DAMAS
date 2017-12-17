
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
changePosition x y value matrix = [ [ verifyPosition x y m n value ( ( matrix !! n ) !! m) | m <- [0..7] ] | n <- [0..7] ]

verifyPosition :: Int -> Int -> Int -> Int -> String -> String -> String
verifyPosition x y m n value old_value	| (x == n && y == m) = value
										| otherwise = old_value

verifyPlay :: Int -> Int -> Int -> Int -> String -> [[String]] -> [[String]]
verifyPlay oldL oldC newL newC value matrix	| ((oldC - newC == 1) && (oldL - newL == -1) && (( ( matrix !! newL ) !! newC) == " ")) || ((oldL - newL == -1) && (oldC - newC == -1) && (( ( matrix !! newL ) !! newC) == " ")) = changePosition newL newC value (changePosition oldL oldC " " matrix)
											| ((oldC - newC == 2) && (oldL - newL == -2) && (( ( matrix !! newL ) !! newC) == " ") && (( ( matrix !! (newL - 1) ) !! (newC + 1)) == "X")) = changePosition newL newC value (changePosition oldL oldC " " (changePosition (newL - 1) (newC + 1) " " matrix))
											| ((oldL - newL == -2) && (oldC - newC == -2) && (( ( matrix !! newL ) !! newC) == " ") && (( ( matrix !! (newL - 1) ) !! (newC - 1)) == "X")) = changePosition newL newC value (changePosition oldL oldC " " (changePosition (newL - 1) (newC - 1) " " matrix))
											| otherwise = matrix

main :: IO()
main = do
	let matrix = (initialize 8 8)
	let viewMatrix = showMatrix (matrix)
	putStrLn(viewMatrix)
	let moveOnMatrix = verifyPlay 2 5 3 4 "O" matrix
	let moveOnMatrix2 = changePosition 4 3 "X" (changePosition 5 2 " " moveOnMatrix)
	let moveOnMatrix3 = verifyPlay 3 4 5 2 "O" moveOnMatrix2
	let viewMoveOnMatrix = showMatrix (moveOnMatrix3)
	putStrLn(viewMoveOnMatrix)
