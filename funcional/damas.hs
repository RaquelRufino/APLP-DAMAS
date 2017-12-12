
initialize :: Int -> Int -> [[String]]
initialize x y  = [ [ mapValue m n  | m <- [0..(x - 1)] ] | n <- [0..(y - 1)] ]

mapValue :: Int -> Int -> String
mapValue x y	| (y >= 0 && y <= 2) && (y `mod` 2 /= 0 && x `mod` 2 == 0) = "O"
				| (y >= 0 && y <= 2) && (y `mod` 2 == 0 && x `mod` 2 /= 0) = "O"
				| (y >= 5 && y <= 7) && (y `mod` 2 /= 0 && x `mod` 2 == 0) = "X"
				| (y >= 5 && y <= 7) && (y `mod` 2 == 0 && x `mod` 2 /= 0) = "X"
				| otherwise = " " 

showMat :: [[String]] -> String
showMat m  = concat (concat [ [ mapMat y | y <- x] ++ ["\n"]| x <- m])

mapMat :: String -> String
mapMat value	| (value == "O") = "O "
				| (value == "X") = "X "
				| otherwise = "~ "

main = do
	let matrix = showMat(initialize 8 8)
	putStrLn(matrix)
