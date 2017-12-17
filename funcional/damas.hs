
initialize :: [[String]]
initialize  = [ [ mapValue m n  | m <- [0..8] ] | n <- [0..8] ]

mapValue :: Int -> Int -> String
mapValue x y	| (x == 0 && y == 0) = "-"
		| (x == 0) = show(y)
		| (y == 0) = " " ++ show(x)
		| (y >= 1 && y <= 3) && (y `mod` 2 /= 0 && x `mod` 2 == 0) = "O"
		| (y >= 1 && y <= 3) && (y `mod` 2 == 0 && x `mod` 2 /= 0) = "O"
		| (y >= 6 && y <= 8) && (y `mod` 2 /= 0 && x `mod` 2 == 0) = "X"
		| (y >= 6 && y <= 8) && (y `mod` 2 == 0 && x `mod` 2 /= 0) = "X"
		| otherwise = " " 

showMatrix :: [[String]] -> String
showMatrix m = concat ( concat [ [ mapMatrix y | y <- x] ++ ["\n"]| x <- m])

mapMatrix :: String -> String
mapMatrix value	| (value == "O") = " O"
		| (value == "X") = " X"
		| (value == "-") = "-"
		| (value /= " ") = value
		| otherwise = " ~"

changePosition :: Int -> Int -> String -> [[String]] -> [[String]]
changePosition x y value matrix = [ [ verifyPosition x y m n value ( ( matrix !! n ) !! m) | m <- [0..8] ] | n <- [0..8] ]

verifyPosition :: Int -> Int -> Int -> Int -> String -> String -> String
verifyPosition x y m n value old_value	| (x == n && y == m) = value
					| otherwise = old_value

verifyIndex :: Int -> Int -> Int -> Int -> Bool
verifyIndex oldL oldC newL newC	| ((oldL >= 1 && oldL <= 8) && (oldC >= 1 && oldC <= 8) && (newL >= 1 && newL <= 8) && (newC >= 1 && newC <= 8)) = True
				| otherwise = False

moveToLeftOrRightO :: Int -> Int -> Int -> Int -> [[String]] -> Bool
moveToLeftOrRightO oldL oldC newL newC matrix	| (((oldL - newL == -1) && (oldC - newC == 1) && (((matrix !! newL) !! newC) == " ")) || ((oldL - newL == -1) && (oldC - newC == -1) && (((matrix !! newL) !! newC) == " "))) = True
						| otherwise = False

eatToRightO :: Int -> Int -> Int -> Int -> [[String]] -> Bool
eatToRightO oldL oldC newL newC matrix	| ((oldL - newL == -2) && (oldC - newC == 2) && (((matrix !! newL) !! newC) == " ") && (((matrix !! (newL - 1)) !! (newC + 1)) == "X")) = True
					| otherwise = False

eatToLeftO :: Int -> Int -> Int -> Int -> [[String]] -> Bool
eatToLeftO oldL oldC newL newC matrix	| ((oldL - newL == -2) && (oldC - newC == -2) && (((matrix !! newL) !! newC) == " ") && (((matrix !! (newL - 1)) !! (newC - 1)) == "X")) = True
					| otherwise = False

moveToLeftOrRightX :: Int -> Int -> Int -> Int -> [[String]] -> Bool
moveToLeftOrRightX oldL oldC newL newC matrix	| (((oldL - newL == 1) && (oldC - newC == -1) && (((matrix !! newL) !! newC) == " ")) || ((oldL - newL == 1) && (oldC - newC == 1) && (((matrix !! newL) !! newC) == " "))) = True
						| otherwise = False

eatToRightX :: Int -> Int -> Int -> Int -> [[String]] -> Bool
eatToRightX oldL oldC newL newC matrix	| ((oldL - newL == 2) && (oldC - newC == -2) && (((matrix !! newL) !! newC) == " ") && (((matrix !! (newL + 1)) !! (newC - 1)) == "O")) = True
					| otherwise = False

eatToLeftX :: Int -> Int -> Int -> Int -> [[String]] -> Bool
eatToLeftX oldL oldC newL newC matrix	| ((oldL - newL == 2) && (oldC - newC == 2) && (((matrix !! newL) !! newC) == " ") && (((matrix !! (newL + 1)) !! (newC + 1)) == "O")) = True
					| otherwise = False

makePlay :: Int -> Int -> Int -> Int -> String -> [[String]] -> [[String]]
makePlay oldL oldC newL newC value matrix	| ((verifyIndex oldL oldC newL newC) && ((( matrix !! oldL ) !! oldC) == " ")) = error "Movimento inválido"
						| ((verifyIndex oldL oldC newL newC) && (moveToLeftOrRightO oldL oldC newL newC matrix)) = changePosition newL newC value (changePosition oldL oldC " " matrix)
						| ((verifyIndex oldL oldC newL newC) && (eatToRightO oldL oldC newL newC matrix)) = changePosition newL newC value (changePosition oldL oldC " " (changePosition (newL - 1) (newC + 1) " " matrix))
						| ((verifyIndex oldL oldC newL newC) && (eatToLeftO oldL oldC newL newC matrix)) = changePosition newL newC value (changePosition oldL oldC " " (changePosition (newL - 1) (newC - 1) " " matrix))
						| ((verifyIndex oldL oldC newL newC) && (moveToLeftOrRightX oldL oldC newL newC matrix)) = changePosition newL newC value (changePosition oldL oldC " " matrix)
						| ((verifyIndex oldL oldC newL newC) && (eatToRightX oldL oldC newL newC matrix)) = changePosition newL newC value (changePosition oldL oldC " " (changePosition (newL + 1) (newC - 1) " " matrix))
						| ((verifyIndex oldL oldC newL newC) && (eatToLeftX oldL oldC newL newC matrix)) = changePosition newL newC value (changePosition oldL oldC " " (changePosition (newL + 1) (newC + 1) " " matrix))
						| otherwise = error "Movimento inválido"

main :: IO()
main = do
	let matrix = initialize
	let viewMatrix = showMatrix (matrix)
	putStrLn(viewMatrix)
	let moveOnMatrix1 = makePlay 3 2 4 3 "O" matrix
	let moveOnMatrix2 = makePlay 6 5 5 4 "X" moveOnMatrix1
	let moveOnMatrix3 = makePlay 5 4 3 2 "X" moveOnMatrix2
	let viewMoveOnMatrix = showMatrix (moveOnMatrix3)
	putStrLn(viewMoveOnMatrix)
