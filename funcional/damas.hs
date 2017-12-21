-------------------------- Iniciando a matrix -------------------------

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

--------------------- Lógica das jogadas ----------------------

showMatrix :: [[String]] -> String
showMatrix m = concat ( concat [ [ mapMatrix y | y <- x] ++ ["\n"]| x <- m])

mapMatrix :: String -> String
mapMatrix value	| (value == "O") = " O"
		| (value == "X") = " X"
		| (value == "-") = "-"
		| (value /= " ") = value
		| otherwise = " ~"

-- Muda a posição das minhas pecas passando linha  e coluna antigas por linha e coluna novas
changePosition :: Int -> Int -> String -> [[String]] -> [[String]]
changePosition x y value matrix = [ [ verifyPosition x y m n value ( ( matrix !! n ) !! m) | m <- [0..8] ] | n <- [0..8] ]

-- Verifica se uma posição er valida no tabuleiro
verifyPosition :: Int -> Int -> Int -> Int -> String -> String -> String
verifyPosition x y m n value old_value	| (x == n && y == m) = value
					| otherwise = old_value

-- Verifica se uma posicao faz parte do tabuleiro
verifyIndex :: Int -> Int -> Int -> Int -> Bool
verifyIndex oldL oldC newL newC	| ((oldL >= 1 && oldL <= 8) && (oldC >= 1 && oldC <= 8) && (newL >= 1 && newL <= 8) && (newC >= 1 && newC <= 8)) = True
				| otherwise = False

-- Move a peca do tipo "O" da esquerda para a direita, respeitando as regras de locomocao do jogo
moveToLeftOrRightO :: Int -> Int -> Int -> Int -> [[String]] -> Bool
moveToLeftOrRightO oldL oldC newL newC matrix	| ((( matrix !! oldL ) !! oldC) /= "O") = False
						| (((oldL - newL == -1) && (oldC - newC == 1) && (((matrix !! newL) !! newC) == " ")) || ((oldL - newL == -1) && (oldC - newC == -1) && (((matrix !! newL) !! newC) == " "))) = True
						| otherwise = False

-- Come a peca do tipo "O" para a direita, respeitando as regras de locomocao do jogo
eatToRightO :: Int -> Int -> Int -> Int -> [[String]] -> Bool
eatToRightO oldL oldC newL newC matrix	| ((( matrix !! oldL ) !! oldC) /= "O") = False
					| ((oldL - newL == -2) && (oldC - newC == 2) && (((matrix !! newL) !! newC) == " ") && (((matrix !! (newL - 1)) !! (newC + 1)) == "X")) = True
					| otherwise = False

-- Come a peca do tipo "O" para a esquerda, respeitando as regras de locomocao do jogo
eatToLeftO :: Int -> Int -> Int -> Int -> [[String]] -> Bool
eatToLeftO oldL oldC newL newC matrix	| ((( matrix !! oldL ) !! oldC) /= "O") = False
					| ((oldL - newL == -2) && (oldC - newC == -2) && (((matrix !! newL) !! newC) == " ") && (((matrix !! (newL - 1)) !! (newC - 1)) == "X")) = True
					| otherwise = False

-- Move a peca do tipo "X" da esquerda para a direita, respeitando as regras de locomocao do jogo
moveToLeftOrRightX :: Int -> Int -> Int -> Int -> [[String]] -> Bool
moveToLeftOrRightX oldL oldC newL newC matrix	| ((( matrix !! oldL ) !! oldC) /= "X") = False
						| (((oldL - newL == 1) && (oldC - newC == -1) && (((matrix !! newL) !! newC) == " ")) || ((oldL - newL == 1) && (oldC - newC == 1) && (((matrix !! newL) !! newC) == " "))) = True
						| otherwise = False
						
-- Come a peca do tipo "X" para a direita, respeitando as regras de locomocao do jogo
eatToRightX :: Int -> Int -> Int -> Int -> [[String]] -> Bool
eatToRightX oldL oldC newL newC matrix	| ((( matrix !! oldL ) !! oldC) /= "X") = False
					| ((oldL - newL == 2) && (oldC - newC == -2) && (((matrix !! newL) !! newC) == " ") && (((matrix !! (newL + 1)) !! (newC - 1)) == "O")) = True
					| otherwise = False

-- Come a peca do tipo "X" para a esquerda, respeitando as regras de locomocao do jogo
eatToLeftX :: Int -> Int -> Int -> Int -> [[String]] -> Bool
eatToLeftX oldL oldC newL newC matrix	| ((( matrix !! oldL ) !! oldC) /= "X") = False
					| ((oldL - newL == 2) && (oldC - newC == 2) && (((matrix !! newL) !! newC) == " ") && (((matrix !! (newL + 1)) !! (newC + 1)) == "O")) = True
					| otherwise = False

-- Faz a jogada, movendo uma peca de um lugar para outro, respeitando as regras de locomocao das pecas
makePlay :: Int -> Int -> Int -> Int -> String -> [[String]] -> [[String]]
makePlay oldL oldC newL newC value matrix	| (not (verifyIndex oldL oldC newL newC)) = matrix
						| ((( matrix !! oldL ) !! oldC) == " ") = matrix
						| ((( matrix !! oldL ) !! oldC) /= value) = matrix
						| (moveToLeftOrRightO oldL oldC newL newC matrix) = changePosition newL newC value (changePosition oldL oldC " " matrix)
						| (eatToRightO oldL oldC newL newC matrix) = changePosition newL newC value (changePosition oldL oldC " " (changePosition (newL - 1) (newC + 1) " " matrix))
						| (eatToLeftO oldL oldC newL newC matrix) = changePosition newL newC value (changePosition oldL oldC " " (changePosition (newL - 1) (newC - 1) " " matrix))
						| (moveToLeftOrRightX oldL oldC newL newC matrix) = changePosition newL newC value (changePosition oldL oldC " " matrix)
						| (eatToRightX oldL oldC newL newC matrix) = changePosition newL newC value (changePosition oldL oldC " " (changePosition (newL + 1) (newC - 1) " " matrix))
						| (eatToLeftX oldL oldC newL newC matrix) = changePosition newL newC value (changePosition oldL oldC " " (changePosition (newL + 1) (newC + 1) " " matrix))
						| otherwise = matrix

-- Verifica se as pecas de um tipo ou de outro nao existem mais no tabuleiro						
verifyPeaces :: String -> [[String]] -> Bool
verifyPeaces value [] = False
verifyPeaces value (a:as)	| (value `elem` a) = True
				| otherwise = False || (verifyPeaces value as)
				


-------------------------------- Jogadas -------------------------------------

changeValue value
	| value == "X" = "O" 
	| otherwise = "X"

verifyPlayer value matrix changedMatrix
	| (matrix == changedMatrix) = game value matrix
	| otherwise = game (changeValue value) changedMatrix

verifyWinner :: [[String]] -> Int
verifyWinner matrix	| (verifyPeaces "O" matrix) = 0
			| (verifyPeaces "X" matrix) = 0
			| otherwise = 1

game value matrix = do

	let viewMatrix = showMatrix (matrix)
	putStrLn(viewMatrix)

	putStrLn("Jogador da rodada: " ++ value)

	putStrLn("Digite a linha na qual a peca se encontra:")
	oldL <- getLine
	putStrLn("Digite a coluna na qual a peca se encontra:")
	oldC <- getLine
	putStrLn("Digite a linha que desejas para nova posicao da peca:")
	newL <- getLine
	putStrLn("Digite a coluna que desejas para nova posicao da peca:")
	newC <- getLine

	let changedMatrix = (makePlay (read oldL) (read oldC) (read newL) (read newC) value matrix)
	
	let viewMatrix = showMatrix (changedMatrix)
	putStrLn(viewMatrix)

	if ((verifyWinner changedMatrix) == 0) then
		putStrLn("Fim de jogo! Vencedor: " ++ value)
	else
		verifyPlayer value matrix changedMatrix

	

{-menu = do
    return "Escolha uma das opcoes abaixo:\n"
    return "\t 1- Jogar.\n\t 2- Ajuda.\n\n"
    return "Opcao: "	


verifica_opcao x | x == 1 = movePiece "X" matriz
				 | x == 2 = putStrLn ajuda
				 | otherwise = "Opcao invalida."
				 where matriz = initialize
				       ajuda = "\n_____________________________O QUE EH O JOGO?_______________________________" 
  				 		++ "\n\n\t     O jogo de Damas eh constituido por um tabuleiro quadratico,\n\tdividido em 64 quadrados com 24 pecas, sendo 12 de cor branca\n\te 12 de cor preta. Exitem  8 linhas que estao na posicao vertical,\n\te com 8 colunas na posicao horizantal.\n"
				 		++ "\n_____________________________  O OBJETIVO  _______________________________"
				 		++ "\n\n\t      Comer o maior numero de pecas possiveis do adversario. Quem \n\tdurante os 3 minutos tiver mais pecas, eh o vencedor!\n\n"
				 		++ "\n______________________________REGRAS O JOGO_________________________________"
						++ "\n\n\t1- Nao eh permitido comer para tras.\n\t2- Pode comer uma peca, nao duas de uma vez.\n\t3- Soh anda uma casa por vez.\n\t4- O Jogo dura 3 Minutos.\n\t5- Nao eh permitido jogar com uma peca do adversario.\n"
						++ "____________________________________________________________________________\n\n"

main :: IO()
main = do

	x <- menu
	putStrLn x
	opcao <- getLine
	let result = verifica_opcao opcao

	print result
-}
main :: IO()
main = do
	let matrix = initialize	
	game "X" matrix

