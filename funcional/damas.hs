-------------------------- Iniciando a matriz --------------------------

initialize :: [[String]]
initialize  = [ [ mapValue m n  | m <- [0..8] ] | n <- [0..8] ]

mapValue :: Int -> Int -> String
mapValue x y	| (y == 0 && x == 0) = "-"
		| (x == 0) = show(y)
		| (y == 0) = " " ++ show(x)
		| (y >= 1 && y <= 3) && (y `mod` 2 /= 0 && x `mod` 2 == 0) = "O"
		| (y >= 1 && y <= 3) && (y `mod` 2 == 0 && x `mod` 2 /= 0) = "O"
		| (y >= 6 && y <= 8) && (y `mod` 2 /= 0 && x `mod` 2 == 0) = "X"
		| (y >= 6 && y <= 8) && (y `mod` 2 == 0 && x `mod` 2 /= 0) = "X"
		| otherwise = " " 

-------------------------- Exibindo a matriz ---------------------------

showMatrix :: [[String]] -> String
showMatrix m = concat ( concat [ [ mapMatrix y | y <- x] ++ ["\n"]| x <- m])

mapMatrix :: String -> String
mapMatrix value	| (value == "O") = " O"
		| (value == "X") = " X"
		| (value == "M") = " M"
		| (value == "Y") = " Y"
		| (value == "-") = "-"
		| (value /= " ") = value
		| otherwise = " ~"

-------------------------- Logica das jogadas --------------------------

-- Muda a posicao das pecas passando linhas e colunas antigas e novas
changePosition :: Int -> Int -> String -> [[String]] -> [[String]]
changePosition x y value matrix = [ [ verifyPosition x y m n value ( ( matrix !! n ) !! m) | m <- [0..8] ] | n <- [0..8] ]

-- Verifica as posicoes no tabuleiro mudar o valor da peca especificada
verifyPosition :: Int -> Int -> Int -> Int -> String -> String -> String
verifyPosition x y m n value old_value	| (x == n && y == m) = value
					| otherwise = old_value

-- Verifica se uma posicao eh valida nos limites do tabuleiro
verifyIndex :: Int -> Int -> Int -> Int -> Bool
verifyIndex oldL oldC newL newC	| ((oldL >= 1 && oldL <= 8) && (oldC >= 1 && oldC <= 8) && (newL >= 1 && newL <= 8) && (newC >= 1 && newC <= 8)) = True
				| otherwise = False

-- Verifica se as pecas passadas como parametro podem usar os metodos de mover e comer
verifyPeacesByPosition :: Int -> Int -> String -> String -> String -> [[String]] -> Bool
verifyPeacesByPosition oldL oldC v1 v2 v3 matrix	| ((( matrix !! oldL ) !! oldC) == v1) || ((( matrix !! oldL ) !! oldC) == v2) || ((( matrix !! oldL ) !! oldC) == v3) = True
							| otherwise = False

-- Move a peca do tipo "X" "M" "Y" para a esquerda ou para a direita, respeitando as regras de locomocao do jogo
moveToLeftOrRightO :: Int -> Int -> Int -> Int -> [[String]] -> Bool
moveToLeftOrRightO oldL oldC newL newC matrix	| (not (verifyPeacesByPosition oldL oldC "O" "M" "Y" matrix)) = False
						| (((oldL - newL == -1) && (oldC - newC == 1) && (((matrix !! newL) !! newC) == " ")) || ((oldL - newL == -1) && (oldC - newC == -1) && (((matrix !! newL) !! newC) == " "))) = True
						| otherwise = False

-- Come a peca do tipo "X" "M" "Y" para a direita, respeitando as regras de locomocao do jogo
eatToRightO :: Int -> Int -> Int -> Int -> [[String]] -> Bool
eatToRightO oldL oldC newL newC matrix	| (not (verifyPeacesByPosition oldL oldC "O" "M" "Y" matrix)) = False
					| ((oldL - newL == -2) && (oldC - newC == 2) && (((matrix !! newL) !! newC) == " ") && (((matrix !! (newL - 1)) !! (newC + 1)) /= ((matrix !! oldL) !! oldC)) && (((matrix !! (newL - 1)) !! (newC + 1)) /= " ")) = True
					| otherwise = False

-- Come a peca do tipo "X" "M" "Y" para a esquerda, respeitando as regras de locomocao do jogo
eatToLeftO :: Int -> Int -> Int -> Int -> [[String]] -> Bool
eatToLeftO oldL oldC newL newC matrix	| (not (verifyPeacesByPosition oldL oldC "O" "M" "Y" matrix)) = False
					| ((oldL - newL == -2) && (oldC - newC == -2) && (((matrix !! newL) !! newC) == " ") && (((matrix !! (newL - 1)) !! (newC - 1)) /= ((matrix !! oldL) !! oldC)) && (((matrix !! (newL - 1)) !! (newC - 1)) /= " ")) = True
					| otherwise = False

-- Move a peca do tipo "O" "M" "Y" para a esquerda ou para a direita, respeitando as regras de locomocao do jogo
moveToLeftOrRightX :: Int -> Int -> Int -> Int -> [[String]] -> Bool
moveToLeftOrRightX oldL oldC newL newC matrix	| (not (verifyPeacesByPosition oldL oldC "X" "M" "Y" matrix)) = False
						| (((oldL - newL == 1) && (oldC - newC == -1) && (((matrix !! newL) !! newC) == " ")) || ((oldL - newL == 1) && (oldC - newC == 1) && (((matrix !! newL) !! newC) == " "))) = True
						| otherwise = False
						
-- Come a peca do tipo "O" "M" "Y" para a direita, respeitando as regras de locomocao do jogo
eatToRightX :: Int -> Int -> Int -> Int -> [[String]] -> Bool
eatToRightX oldL oldC newL newC matrix	| (not (verifyPeacesByPosition oldL oldC "X" "M" "Y" matrix)) = False
					| ((oldL - newL == 2) && (oldC - newC == -2) && (((matrix !! newL) !! newC) == " ") && (((matrix !! (newL + 1)) !! (newC - 1)) /= ((matrix !! oldL) !! oldC)) && (((matrix !! (newL + 1)) !! (newC - 1)) /= " ")) = True
					| otherwise = False

-- Come a peca do tipo "O" "M" "Y" para a esquerda, respeitando as regras de locomocao do jogo
eatToLeftX :: Int -> Int -> Int -> Int -> [[String]] -> Bool
eatToLeftX oldL oldC newL newC matrix	| (not (verifyPeacesByPosition oldL oldC "X" "M" "Y" matrix)) = False
					| ((oldL - newL == 2) && (oldC - newC == 2) && (((matrix !! newL) !! newC) == " ") && (((matrix !! (newL + 1)) !! (newC + 1)) /= ((matrix !! oldL) !! oldC)) && (((matrix !! (newL + 1)) !! (newC + 1)) /= " ")) = True
					| otherwise = False

verifyLady :: Int -> Int -> String -> [[String]] -> Bool
verifyLady oldL oldC value matrix	| ((( matrix !! oldL ) !! oldC) == value) = True
							| otherwise = False

-- Faz a jogada, movendo ou comendo uma peca de um lugar para outro, respeitando as regras de locomocao do jogo
makePlay :: Int -> Int -> Int -> Int -> String -> String -> [[String]] -> [[String]]
makePlay oldL oldC newL newC value ladyValue matrix	| (not (verifyIndex oldL oldC newL newC)) = matrix
						| ((( matrix !! oldL ) !! oldC) == " ") = matrix
						| (verifyLady oldL oldC ladyValue matrix) && (moveToLeftOrRightO oldL oldC newL newC matrix) = changePosition newL newC ladyValue (changePosition oldL oldC " " matrix)
						| (verifyLady oldL oldC ladyValue matrix) && (((matrix !! (newL - 1)) !! (newC + 1)) /= value) && (eatToRightO oldL oldC newL newC matrix) = changePosition newL newC ladyValue (changePosition oldL oldC " " (changePosition (newL - 1) (newC + 1) " " matrix))
						| (verifyLady oldL oldC ladyValue matrix) && (((matrix !! (newL - 1)) !! (newC - 1)) /= value) && (eatToLeftO oldL oldC newL newC matrix) = changePosition newL newC ladyValue (changePosition oldL oldC " " (changePosition (newL - 1) (newC - 1) " " matrix))
						| (verifyLady oldL oldC ladyValue matrix) && (moveToLeftOrRightX oldL oldC newL newC matrix) = changePosition newL newC ladyValue (changePosition oldL oldC " " matrix)
						| (verifyLady oldL oldC ladyValue matrix) && (((matrix !! (newL + 1)) !! (newC - 1)) /= value) && (eatToRightX oldL oldC newL newC matrix) = changePosition newL newC ladyValue (changePosition oldL oldC " " (changePosition (newL + 1) (newC - 1) " " matrix))
						| (verifyLady oldL oldC ladyValue matrix) && (((matrix !! (newL + 1)) !! (newC + 1)) /= value) && (eatToLeftX oldL oldC newL newC matrix) = changePosition newL newC ladyValue (changePosition oldL oldC " " (changePosition (newL + 1) (newC + 1) " " matrix))
						| ((( matrix !! oldL ) !! oldC) /= value) = matrix
						| (value == "O") && (newL == 8) && (moveToLeftOrRightO oldL oldC newL newC matrix) = changePosition newL newC "M" (changePosition oldL oldC " " matrix)
						| (value == "O") && (newL == 8) && (((matrix !! (newL - 1)) !! (newC + 1)) /= ladyValue) && (eatToRightO oldL oldC newL newC matrix) = changePosition newL newC "M" (changePosition oldL oldC " " (changePosition (newL - 1) (newC + 1) " " matrix))
						| (value == "O") && (newL == 8) && (((matrix !! (newL - 1)) !! (newC - 1)) /= ladyValue) && (eatToLeftO oldL oldC newL newC matrix) = changePosition newL newC "M" (changePosition oldL oldC " " (changePosition (newL - 1) (newC - 1) " " matrix))
						| (value == "X") && (newL == 1) && (moveToLeftOrRightX oldL oldC newL newC matrix) = changePosition newL newC "Y" (changePosition oldL oldC " " matrix)
						| (value == "X") && (newL == 1) && (((matrix !! (newL + 1)) !! (newC - 1)) /= ladyValue) && (eatToRightX oldL oldC newL newC matrix) = changePosition newL newC "Y" (changePosition oldL oldC " " (changePosition (newL + 1) (newC - 1) " " matrix))
						| (value == "X") && (newL == 1) && (((matrix !! (newL + 1)) !! (newC + 1)) /= ladyValue) && (eatToLeftX oldL oldC newL newC matrix) = changePosition newL newC "Y" (changePosition oldL oldC " " (changePosition (newL + 1) (newC + 1) " " matrix))
						| (moveToLeftOrRightO oldL oldC newL newC matrix) = changePosition newL newC value (changePosition oldL oldC " " matrix)
						| (eatToRightO oldL oldC newL newC matrix) && (((matrix !! (newL - 1)) !! (newC + 1)) /= ladyValue) = changePosition newL newC value (changePosition oldL oldC " " (changePosition (newL - 1) (newC + 1) " " matrix))
						| (eatToLeftO oldL oldC newL newC matrix) && (((matrix !! (newL - 1)) !! (newC - 1)) /= ladyValue) = changePosition newL newC value (changePosition oldL oldC " " (changePosition (newL - 1) (newC - 1) " " matrix))
						| (moveToLeftOrRightX oldL oldC newL newC matrix) = changePosition newL newC value (changePosition oldL oldC " " matrix)
						| (eatToRightX oldL oldC newL newC matrix) && (((matrix !! (newL + 1)) !! (newC - 1)) /= ladyValue) = changePosition newL newC value (changePosition oldL oldC " " (changePosition (newL + 1) (newC - 1) " " matrix))
						| (eatToLeftX oldL oldC newL newC matrix) && (((matrix !! (newL + 1)) !! (newC + 1)) /= ladyValue) = changePosition newL newC value (changePosition oldL oldC " " (changePosition (newL + 1) (newC + 1) " " matrix))
						| otherwise = matrix

-- Verifica se as pecas de um tipo ou de outro nao existem mais no tabuleiro						
verifyBoard :: String -> String -> [[String]] -> Bool
verifyBoard v1 v2 [] = False
verifyBoard v1 v2 (a:as)	| ((v1 `elem` a) || (v2 `elem` a)) = True
				| otherwise = False || (verifyBoard v1 v2 as)

-- Retorna o vencedor do jogo
verifyWinner :: [[String]] -> String
verifyWinner matrix	| (not (verifyBoard "O" "M" matrix)) = "X"
			| (not (verifyBoard "X" "Y" matrix)) = "O"
			| otherwise = " "

------------------------------- Jogadas -------------------------------

changePlayer value
	| value == "O" = "X" 
	| otherwise = "O"

changeLady value
	| value == "O" = "M" 
	| otherwise = "Y"

verifyPlay matrix changedMatrix = do
	if (matrix == changedMatrix) then
		putStrLn("Jogada Inválida!")
	else
		putStrLn("Jogada aceita!")
	
verifyPlayer value matrix changedMatrix
	| (matrix == changedMatrix) = game (verifyWinner matrix) value matrix
	| otherwise = game (verifyWinner changedMatrix) (changePlayer value) changedMatrix

printMatrix matrix = do
	let viewMatrix = showMatrix (matrix)
	putStrLn(viewMatrix)

game "O" _ matrix = do 
	printMatrix matrix
	putStrLn("Fim de jogo! O vencedor é: O")

game "X" _ matrix = do
	printMatrix matrix
	putStrLn("Fim de jogo! O vencedor é: X")

game _ value matrix = do
	printMatrix matrix

	putStrLn("Jogador da rodada: " ++ value)

	putStrLn("Digite a linha na qual a peca se encontra:")
	oldL <- getLine
	putStrLn("Digite a coluna na qual a peca se encontra:")
	oldC <- getLine
	putStrLn("Digite a linha que desejas para nova posicao da peca:")
	newL <- getLine
	putStrLn("Digite a coluna que desejas para nova posicao da peca:")
	newC <- getLine
	
	putStrLn(value ++ " " ++ (changeLady value)) 
	
	let changedMatrix = (makePlay (read oldL) (read oldC) (read newL) (read newC) value (changeLady value) matrix)
	
	verifyPlay matrix changedMatrix
	
	verifyPlayer value matrix changedMatrix

choose opcao
	| (opcao == 1) = game (verifyWinner initialize) "X" initialize
	| (opcao == 2) = putStrLn("\n_____________________________O QUE EH O JOGO?_______________________________" 
					++ "\n\n\t      O jogo de damas eh constituido por um tabuleiro quadratico,\n\tdividido em 64 quadrados com 24 pecas, sendo 12 de cor branca e\n\t12 de cor preta. Existem 8 linhas que estao na posicao vertical,\n\te 8 colunas na posicao horizantal e dois jogadores 'O' e 'X',\n\tonde a dama de O é 'M' e a de X é 'Y'.\n"
				 	++ "\n______________________________  O OBJETIVO  ________________________________"
				 	++ "\n\n\t      Comer todas as pecas do adversario. Quem comer todas as pecas\n\tdo adversario eh o vencedor!\n\n"
				 	++ "\n______________________________REGRAS O JOGO_________________________________"
					++ "\n\n\t1- Nao eh permitido comer para tras.\n\t2- Pode comer apenas uma peca.\n\t3- Pecas normais so andam uma casa por vez.\n\t4- O Jogo dura 10 ou mais minutos.\n\t5- Nao eh permitido jogar com uma peca do adversario.\n"
					++ "____________________________________________________________________________\n\n")
	| otherwise = main

main :: IO()
main = do
	putStrLn("Escolha uma opcao (digite o numero): 1. Jogar | 2. Ajuda")
	opcao <- getLine
	choose (read opcao)
	main
