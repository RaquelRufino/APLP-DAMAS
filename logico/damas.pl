% Cria um tabuleiro.  
%  
novoTabuleiro( [["-"," ","1"," ","2"," ","3"," ","4"," ","5"," ","6"," ","7"," ","8"],
            ["1","~","O","~","O","~","O","~","O"],
            ["2","O","~","O","~","O","~","O","~"],
            ["3","~","O","~","O","~","O","~","O"],
            ["4","~","~","~","~","~","~","~","~"],
            ["5","~","~","~","~","~","~","~","~"],
            ["6","X","~","X","~","X","~","X","~"],
            ["7","~","X","~","X","~","X","~","X"],
            ["8","X","~","X","~","X","~","X","~"]] ).

% Retorna o valor de uma casa.  
%   Tabuleiro - tabuleiro.  
%   Posicao   - posicao.  
%   Retorno   - valor da posicao.  
%   
returnaPosicao(Tabuleiro, Posicao, Returno :-   
    convertePosicao(Posicao, SPosicao),                      % converte a posicao de entrada para sua representacao no tabuleiro.  
    retorna_valor_na_linha(Tabuleiro, SPosicao, Returno).   % retorna o valor da casa.  
 
% Converte a posicao de entrada em sua representacao no tabuleiro.  
%   Posicao     -  posicao de 1 .. 9.  
%   [Linha, Coluna] -  representacao da posicao em uma matriz 9x9. 
%  
convertePosicao(Posicao, [Linha, Coluna]) :-  
    Temp is Posicao - 1,            % diminui a posicao em 1.  
    Linha is 1 + (Temp // 9),        % temp // 3 retorna a linha.   
    Coluna is 1 + (Temp mod 9).     % temp mod 3 retorna a coluna.  


% Sempre retorna a 1ª linha em array de 9 linhas.
retorna_valor_na_linha([Linha1, Linha2, Linha3, Linha4, Linha5, Linha6, Linha7, Linha8, Linha9], [1, Coluna], Retorno) :- 
    retorna_valor_na_coluna(Linha1, Coluna, Retorno).   

% Sempre retorna a 2ª linha em array de 9 linhas.
retorna_valor_na_linha([Linha1, Linha2, Linha3, Linha4, Linha5, Linha6, Linha7, Linha8, Linha9], [2, Coluna], Retorno) :- 
    retorna_valor_na_coluna(Linha2, Coluna, Retorno). 

% Sempre retorna a 3ª linha em array de 9 linhas.
retorna_valor_na_linha([Linha1, Linha2, Linha3, Linha4, Linha5, Linha6, Linha7, Linha8, Linha9], [3, Coluna], Retorno) :- 
    retorna_valor_na_coluna(Linha3, Coluna, Retorno).

% Sempre retorna a 4ª linha em array de 9 linhas.
retorna_valor_na_linha([Linha1, Linha2, Linha3, Linha4, Linha5, Linha6, Linha7, Linha8, Linha9], [4, Coluna], Retorno) :- 
    retorna_valor_na_coluna(Linha4, Coluna, Retorno).   

% Sempre retorna a 5ª linha em array de 9 linhas.
retorna_valor_na_linha([Linha1, Linha2, Linha3, Linha4, Linha5, Linha6, Linha7, Linha8, Linha9], [5, Coluna], Retorno) :- 
    retorna_valor_na_coluna(Linha5, Coluna, Retorno). 

% Sempre retorna a 6ª linha em array de 9 linhas.
retorna_valor_na_linha([Linha1, Linha2, Linha3, Linha4, Linha5, Linha6, Linha7, Linha8, Linha9], [6, Coluna], Retorno) :- 
    retorna_valor_na_coluna(Linha6, Coluna, Retorno). 

% Sempre retorna a 7ª linha em array de 9 linhas.
retorna_valor_na_linha([Linha1, Linha2, Linha3, Linha4, Linha5, Linha6, Linha7, Linha8, Linha9], [7, Coluna], Retorno) :- 
    retorna_valor_na_coluna(Linha7, Coluna, Retorno).  

% Sempre retorna a 8ª linha em array de 9 linhas.
retorna_valor_na_linha([Linha1, Linha2, Linha3, Linha4, Linha5, Linha6, Linha7, Linha8, Linha9], [8, Coluna], Retorno) :- 
    retorna_valor_na_coluna(Linha8, Coluna, Retorno). 

% Sempre retorna a 9ª linha em array de 9 linhas.
retorna_valor_na_linha([Linha1, Linha2, Linha3, Linha4, Linha5, Linha6, Linha7, Linha8, Linha9], [9, Coluna], Retorno) :- 
    retorna_valor_na_coluna(Linha9, Coluna, Retorno). 


% Sempre o 1° valor em um array de 9 caracteres.
retorna_valor_na_coluna([Casa1, Casa2, Casa3, Casa4, CAsa5, Casa6, Casa7, Casa8, Casa9], 1, Casa1).   

% Sempre o 2° valor em um array de 9 caracteres.
retorna_valor_na_coluna([Casa1, Casa2, Casa3, Casa4, CAsa5, Casa6, Casa7, Casa8, Casa9], 2, Casa2).   

% Sempre o 3° valor em um array de 9 caracteres.
retorna_valor_na_coluna([Casa1, Casa2, Casa3, Casa4, CAsa5, Casa6, Casa7, Casa8, Casa9], 3, Casa3).  
  
% Sempre o 4° valor em um array de 9 caracteres.
retorna_valor_na_coluna([Casa1, Casa2, Casa3, Casa4, CAsa5, Casa6, Casa7, Casa8, Casa9], 4, Casa4).  

% Sempre o 5° valor em um array de 9 caracteres.
retorna_valor_na_coluna([Casa1, Casa2, Casa3, Casa4, CAsa5, Casa6, Casa7, Casa8, Casa9], 5, Casa5).

% Sempre o 6° valor em um array de 9 caracteres.
retorna_valor_na_coluna([Casa1, Casa2, Casa3, Casa4, CAsa5, Casa6, Casa7, Casa8, Casa9], 6, Casa6).  

% Sempre o 7° valor em um array de 9 caracteres.
retorna_valor_na_coluna([Casa1, Casa2, Casa3, Casa4, CAsa5, Casa6, Casa7, Casa8, Casa9], 7, Casa7).  

% Sempre o 8° valor em um array de 9 caracteres.
retorna_valor_na_coluna([Casa1, Casa2, Casa3, Casa4, CAsa5, Casa6, Casa7, Casa8, Casa9], 8, Casa8).  

% Sempre o 9° valor em um array de 9 caracteres.
retorna_valor_na_coluna([Casa1, Casa2, Casa3, Casa4, CAsa5, Casa6, Casa7, Casa8, Casa9], 9, Casa9).  



% Desenha o tabuleiro.  
% [L1, L2, L3, L4, L5, L6, L7, L8, L9] - array de 9 linhas. 
% 
desenhaTabuleiro([L1, L2, L3, L4, L5, L6, L7, L8, L9]) :-  
    nl,  
    desenhaLinha(L1),  
        print('     -------------------------------------------------------------------'), nl,  
    desenhaLinha(L2),  
        print('     -------------------------------------------------------------------'), nl,  
    desenhaLinha(L3),
        print('     -------------------------------------------------------------------'), nl,
    desenhaLinha(L4),  
        print('     -------------------------------------------------------------------'), nl,
    desenhaLinha(L5),  
        print('     -------------------------------------------------------------------'), nl,
    desenhaLinha(L6),  
        print('     -------------------------------------------------------------------'), nl,
    desenhaLinha(L7),  
        print('     -------------------------------------------------------------------'), nl,
    desenhaLinha(L8),  
        print('     -------------------------------------------------------------------'), nl,
    desenhaLinha(L9),  
    nl.  
  
% Desenha uma linha.
% [A1, A2, A3, A4, A5, A6, A7, A8, A9] - array de 9 caracteres.
%      
desenhaLinha([A1, A2, A3, A4, A5, A6, A7, A8, A9]) :-  
    print('      '),  
    print(A1), print('|'),  
    print(A2), print('|'),  
    print(A3), print(' '),
    print(A4), print(' '),
    print(A5), print(' '),
    print(A6), print(' '),
    print(A7), print(' '),
    print(A8), print(' '),
    print(A9), print(' '),  
    nl.  




