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
retorna_valor_na_casa(Linha, Coluna, Elemento, Tabuleiro) :-    
   novo_tabuleiro(Tabuleiro),
   nth0(Linha, Tabuleiro, LinhaLista),     % aqui retorna a linha da matriz
   nth0(Coluna, LinhaLista, Elemento). % acessa o elemento da linha retornada anteriormente  

% Verifica se a posicao (par linha-coluna) eh valida nos limites do tabuleiro.
%   Resultado - verificao.
%
verifica_indices_tabuleiro(Linha, Coluna, Resultado) :- Linha >= 1, Linha =< 8,
    Coluna >= 1, Coluna =< 8, Resultado = "True";   
    Resultado =  "False".

% Efetuada a jogada, muda o valor de uma casa.
%   Tabuleiro       - tabuleiro.    
%   Valor           - novo valor.  
%   NovoTabuleiro   - novo tabuleiro com os novos valores definidos.
%
muda_valor_casa(Linha, Coluna, NovoValor, Tabuleiro) :- 
    verifica_indices_tabuleiro(Linha, Coluna, Resultado), Resultado = "True",
    retorna_valor_na_casa(Linha, Coluna, Elemento, Tabuleiro),
    Elemento = NovoValor.

/*--------------------- FIM DAS OPERACOES LOGICAS DO JOGO --------------------------------------*/
/* ------------------- INICIO DAS OPERACOES LOGICAS DAS JOGADAS ------------------------------- */

% Verifica se a peca na posicao eh uma peca valida, ou seja, do tipo "X", "O", "M", "Z".
%   Elemento - peca que estah na posicao passada.
%
verifica_pecas_na_posicao(Linha, Coluna, Resultado) :-
    retorna_valor_na_casa(Linha, Coluna, Elemento),     
    (Elemento =:= "X"; Elemento =:= "O"; Elemento =:= "M"; Elemento =:= "Z"), 
    Resultado = "True";
    Resultado = "False".

/* ---------------- INICIO DA LOGICA DAS MOVIMENTACOES E CAPTURAS -------------------- */

% Verifica se eh possivel mover a peca "O" para a direita ou esquerda.
%
mover_O_para_esquerda_ou_direita(LinhaAtual, ColunaAtual, NovaLinha, NovaColuna, Tabuleiro, Permissao) :-
	verifica_indices_tabuleiro(LinhaAtual, ColunaAtual, Verificacao), Verificacao = "True",
	verifica_indices_tabuleiro(NovaLinha, NovaColuna, OutraVerificacao), OutraVerificacao = "True",
    retorna_valor_na_casa(NovaLinha, NovaColuna, Elemento, Tabuleiro), Elemento = "~",
    
    NovaLinha - LinhaAtual =:= 1,
    (NovaColuna - ColunaAtual =:= 1; /* mover para a direita */
    NovaColuna - ColunaAtual =:= -1), /* mover para a esquerda */
    Permissao = "True".

% Verifica se eh possivel mover a peca "X" para a direita ou esquerda.
%
mover_X_para_esquerda_ou_direita(LinhaAtual, ColunaAtual, NovaLinha, NovaColuna, Tabuleiro, Permissao) :-
	verifica_indices_tabuleiro(LinhaAtual, ColunaAtual, Verificacao), Verificacao = "True",
	verifica_indices_tabuleiro(NovaLinha, NovaColuna, OutraVerificacao), OutraVerificacao = "True",
    retorna_valor_na_casa(NovaLinha, NovaColuna, Elemento, Tabuleiro), Elemento = "~",
    
    NovaLinha - LinhaAtual =:= -1,
    (NovaColuna - ColunaAtual =:= 1; /* mover para a direita */
    NovaColuna - ColunaAtual =:= -1), /* mover para a esquerda */
    Permissao = "True".



/* ------------------- FIM DA LOGICA DAS MOVIMENTACOES E CAPTURAS --------------------- */

% Chegando ao fim da implementacao do tabuleiro...  
  
% Definicoes:  
%   Definir o loop principal do jogo  
        % Desenhar o tabuleiro
        % Processar a jogada (e verificar se eh a IA ou Humano)  
        % Verifica se o jogo acabou 
