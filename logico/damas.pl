/* ------------------- REGRAS PARA DESENHAR O TABULEIRO ------------------------------ */

% Cria um tabuleiro.  
%  
novo_tabuleiro( [["-","1","2","3","4","5","6","7","8"],
                ["1","~","O","~","O","~","O","~","O"],
                ["2","O","~","O","~","O","~","O","~"],
                ["3","~","O","~","O","~","O","~","O"],
                ["4","~","~","~","~","~","~","~","~"],
                ["5","~","~","~","~","~","~","~","~"],
                ["6","X","~","X","~","X","~","X","~"],
                ["7","~","X","~","X","~","X","~","X"],
                ["8","X","~","X","~","X","~","X","~"]] ).

% Desenha o tabuleiro.  
% [Lista1, Lista2, Lista3, Lista4, Lista5, Lista6, Lista7, Lista8, Lista9] - array de 9 linhas. 
% 
desenha_tabuleiro([L1, L2, L3, L4, L5, L6, L7, L8, L9]) :-  
    nl,  
    desenha_linha(L1), nl,
    desenha_linha(L2), 
        print('      -------------------------------------------------------'), nl,  
    desenha_linha(L3),
        print('      -------------------------------------------------------'), nl,
    desenha_linha(L4),
        print('      -------------------------------------------------------'), nl,
    desenha_linha(L5), 
        print('      -------------------------------------------------------'), nl,
    desenha_linha(L6), 
        print('      -------------------------------------------------------'), nl,
    desenha_linha(L7), 
        print('      -------------------------------------------------------'), nl,
    desenha_linha(L8), 
        print('      -------------------------------------------------------'), nl,
    desenha_linha(L9), nl.  
  
% Desenha uma linha.
% [A1, A2, A3, A4, A5, A6, A7, A8, A9] - array de 9 caracteres.
%      
desenha_linha([A1, A2, A3, A4, A5, A6, A7, A8, A9]) :-  
    print('      '),  
    print(A1), print('|'),  
    print(A2), print('|'),  
    print(A3), print('|'),
    print(A4), print('|'),
    print(A5), print('|'),
    print(A6), print('|'),
    print(A7), print('|'),
    print(A8), print('|'),
    print(A9), print('|'),  
    nl.  

/* ------------------- FIM DE REGRAS PARA DESENHAR O TABULEIRO ------------------------------ */
/* ------------------- INICIO DAS OPERACOES LOGICAS DO JOGO --------------------------------- */


% Retorna o valor de uma casa.  
% nth0(Indice, Lista, Elemento) - itera na lista, contador de 0 a Index, e retorna elemento na Lista[Indice].
%
retorna_valor_na_casa(Linha, Coluna, Elemento) :-    
   novo_tabuleiro(Matriz),
   nth0(Linha, Matriz, LinhaLista),     % aqui retorna a linha da matriz
   nth0(Coluna, LinhaLista, Elemento). % acessa o elemento da linha retornada anteriormente  

% Verifica se a posicao (par linha-coluna) eh valida nos limites do tabuleiro
%   Resultado - verificao
%
verifica_posicao(Linha, Coluna, Resultado) :- (Linha >= 1, Linha <= 8),
    (Coluna >= 1, Coluna <= 8)), Resultado = "True";   
    Resultado =  "False".

% Efetuada a jogada, muda o valor de uma casa.
%   Tabuleiro       - tabuleiro.    
%   Valor           - novo valor.  
%   NovoTabuleiro   - novo tabuleiro com os novos valores definidos.
%
muda_valor_casa(Tabuleiro, Linha, Coluna, NovoValor, NovoTabuleiro) :- 
    verifica_posicao(Linha, Coluna, Resultado), Resultado = "True",
    retorna_valor_na_casa(Linha, Coluna, Elemento), Elemento = NovoValor.

% Quase acabando...

/*----------------------------------------------------------------------------*/

% fim da implementacao do tabuleiro.  
  
% implementacao da logica do jogo  
  
% definicoes:  
%   define o loop principal do jogo  
        % desenha  
        % processa  
        % veficia se o jogo acabou 
