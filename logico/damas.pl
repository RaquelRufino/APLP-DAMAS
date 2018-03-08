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

% Verifica se a peca na posicao eh uma peca valida, ou seja, do tipo "X", "O", "Z" (dama do X), "M" (dama do O).
%   Elemento - peca que estah na posicao passada.
%
verifica_pecas_na_posicao("X", Linha, Coluna, Tabuleiro, Resultado) :-
    retorna_valor_na_casa(Linha, Coluna, Elemento, Tabuleiro),     
    (Elemento =:= "X"; Elemento =:= "Z";), 
    Resultado = "True";
    Resultado = "False".

verifica_pecas_na_posicao("O", Linha, Coluna, Tabuleiro, Resultado) :-
    retorna_valor_na_casa(Linha, Coluna, Elemento, Tabuleiro),     
    (Elemento =:= "O"; Elemento =:= "M"), 
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

/* ---------------- CAPTURAS -------------------- */

peca_O_come_para_direita(LinhaAtual, ColunaAtual, NovaLinha, NovaColuna, Tabuleiro, Permissao) :-
    verifica_indices_tabuleiro(LinhaAtual, ColunaAtual, Verificacao), Verificacao = "True",
    verifica_indices_tabuleiro(NovaLinha, NovaColuna, OutraVerificacao), OutraVerificacao = "True",
    retorna_valor_na_casa(NovaLinha, NovaColuna, Elemento, Tabuleiro), Elemento = "~",

    NovaLinha - LinhaAtual =:= 2, NovaColuna - ColunaAtual =:= 2,
    retorna_valor_na_casa(LinhaAtual, ColunaAtual, PecaAtual, Tabuleiro),

    LinhaPecaCapturada is NovaLinha - 1, ColunaPecaCapturada is NovaColuna - 1,

    retorna_valor_na_casa(LinhaPecaCapturada, ColunaPecaCapturada, Peca, Tabuleiro),
    Peca =\= PecaAtual,
    Permissao = "True".

peca_O_come_para_esquerda(LinhaAtual, ColunaAtual, NovaLinha, NovaColuna, Tabuleiro, Permissao) :-
    verifica_indices_tabuleiro(LinhaAtual, ColunaAtual, Verificacao), Verificacao = "True",
    verifica_indices_tabuleiro(NovaLinha, NovaColuna, OutraVerificacao), OutraVerificacao = "True",
    retorna_valor_na_casa(NovaLinha, NovaColuna, Elemento, Tabuleiro), Elemento = "~",

    NovaLinha - LinhaAtual =:= 2, NovaColuna - ColunaAtual =:= -2,
    retorna_valor_na_casa(LinhaAtual, ColunaAtual, PecaAtual, Tabuleiro),

    LinhaPecaCapturada is NovaLinha - 1, ColunaPecaCapturada is NovaColuna + 1,

    retorna_valor_na_casa(LinhaPecaCapturada, ColunaPecaCapturada, Peca, Tabuleiro),
    Peca =\= PecaAtual,
    Permissao = "True".

peca_X_come_para_direita(LinhaAtual, ColunaAtual, NovaLinha, NovaColuna, Tabuleiro, Permissao) :-
    verifica_indices_tabuleiro(LinhaAtual, ColunaAtual, Verificacao), Verificacao = "True",
    verifica_indices_tabuleiro(NovaLinha, NovaColuna, OutraVerificacao), OutraVerificacao = "True",
    retorna_valor_na_casa(NovaLinha, NovaColuna, Elemento, Tabuleiro), Elemento = "~",

    NovaLinha - LinhaAtual =:= -2, NovaColuna - ColunaAtual =:= 2,
    retorna_valor_na_casa(LinhaAtual, ColunaAtual, PecaAtual, Tabuleiro),

    LinhaPecaCapturada is NovaLinha - 1, ColunaPecaCapturada is NovaColuna - 1,

    retorna_valor_na_casa(LinhaPecaCapturada, ColunaPecaCapturada, Peca, Tabuleiro),
    Peca =\= PecaAtual,
    Permissao = "True".

peca_X_come_para_esquerda(LinhaAtual, ColunaAtual, NovaLinha, NovaColuna, Tabuleiro, Permissao) :-
    verifica_indices_tabuleiro(LinhaAtual, ColunaAtual, Verificacao), Verificacao = "True",
    verifica_indices_tabuleiro(NovaLinha, NovaColuna, OutraVerificacao), OutraVerificacao = "True",
    retorna_valor_na_casa(NovaLinha, NovaColuna, Elemento, Tabuleiro), Elemento = "~",

    NovaLinha - LinhaAtual =:= -2, NovaColuna - ColunaAtual =:= -2,
    retorna_valor_na_casa(LinhaAtual, ColunaAtual, PecaAtual, Tabuleiro),

    LinhaPecaCapturada is NovaLinha - 1, ColunaPecaCapturada is NovaColuna + 1,

    retorna_valor_na_casa(LinhaPecaCapturada, ColunaPecaCapturada, Peca, Tabuleiro),
    Peca =\= PecaAtual,
    Permissao = "True".

% Verifica se a peca da posicao passada eh uma dama.
%
eh_dama(LinhaAtual, ColunaAtual, Tabuleiro, Permissao) :-
    verifica_indices_tabuleiro(LinhaAtual, ColunaAtual, Verificacao),
    Verificacao = "True",
    retorna_valor_na_casa(LinhaAtual, ColunaAtual, Elemento, Tabuleiro),
    (Elemento =:= "M"; Elemento =:= "Z"), Permissao = "True".

/* ------------------- FIM DA LOGICA DAS MOVIMENTACOES E CAPTURAS --------------------- */

% Fatos para alternar os jogadores.
%
alterna_jogador("X", "O").
alterna_jogador("O", "X").

% Fatos para transformar a peca em sua respectiva rainha...
%
transforma_peca_em_rainha("O", "M").
transforma_peca_em_rainha("X", "Z").

% Fatos para trocar o valor do jogo, ou seja, se eh um jogo entre humanos ou contra a maquina.
%
troca_valor("Humano", "Maquina").
troca_valor("Maquina", "Humano").

% Verifica se a jogada foi realizada com sucesso.
%
verifica_jogada(Tabuleiro, NovoTabuleiro, Mensagem) :-
    Tabuleiro = NovoTabuleiro, Mensagem = "Jogada inválida!\n".
verifica_jogada(Tabuleiro, NovoTabuleiro, Mensagem) :-
    Tabuleiro \= NovoTabuleiro, Mensagem = "Jogada realizada!\n".

% Chegando ao fim da implementacao do jogo. O que falta...  
  
% Definicoes:  
%   Definir o loop principal do jogo  
        % Desenhar o tabuleiro
        % Processar a jogada (e verificar se eh a IA ou Humano)  
        % Verifica se o jogo acabou 
(verifyLady oldL oldC ladyValue matrix)
% Verifica se as pecas de um tipo nao existem mais no tabuleiro.
%
verifica_tabuleiro(Peca, DamaPeca, [], "False") :- !.
verifica_tabuleiro(Peca, DamaPeca, [Cabeca|Cauda], Resultado) :-
    (member(Peca, Cabeca); member(DamaPeca, Cabeca)), Resultado = "True";
    verifica_tabuleiro(Peca, DamaPeca, Cauda, Resultado).

% Verifica e retorna o vencedor do jogo.
%
retorna_vencedor(Tabuleiro, Elemento) :-
    verifica_tabuleiro("O", "M",  Tabuleiro, Resultado), Resultado = "True",
    Elemento = "O".
retorna_vencedor(Tabuleiro, Elemento) :-
    verifica_tabuleiro("X", "Z",  Tabuleiro, Resultado), Resultado = "True",
    Elemento = "X".

% Menu do jogo, recebe a opcao.
%  Oponente - Se eh Humano ou Maquina
%  Jogador X sempre comeca
%
menu_opcao(Opcao) :-
    Opcao = 1, inicia_jogo(retorna_vencedor(novo_tabuleiro, Elemento), "X", novo_tabuleiro),
    Opcao = 2, print("COLOCA AS REGRAS AQUI!"),
    Opcao = _, main.
    
pega_posicao(Linha, Coluna):-
	print("Digite a linha na qual a peca se encontra:"),
	read(Linha),
	print("Digite a coluna na qual a peca se encontra:"),
	read(Coluna).

pega_nova_posicao(NovaLinha, NovaColuna):-
	print("Digite a linha que desejas para nova posicao da peca:"),
	read(NovaLinha),
	print("Digite a coluna que desejas para nova posicao da peca:"),
	read(NovaColuna).

inicia_jogo(Tabuleiro, Jogador):-
	desenha_tabuleiro([L1, L2, L3, L4, L5, L6, L7, L8, L9]),
	append("Jogador da rodada: ", Jogador, X), 
	print(X),
	pega_posicao(Linha, Coluna),
	pega_nova_posicao(NovaLinha, NovaColuna),
	


makePlay(Linha, Coluna, novaLinha, novaColuna, Jogador, Tabuleiro, NovoTabuleiro) :-
	verifica_indices_tabuleiro(Linha, Coluna, Resultado), Resultado = False, Tabuleiro = NovoTabuleiro.

makePlay(Linha, Coluna, novaLinha, novaColuna, Jogador, Tabuleiro, NovoTabuleiro) :-
	verifica_indices_tabuleiro(NovaLinha, NovaColuna, Resultado), Resultado = False, Tabuleiro = NovoTabuleiro.	

makePlay(Linha, Coluna, novaLinha, novaColuna, Jogador, Tabuleiro, NovoTabuleiro) :-
	verifica_pecas_na_posicao(Jogador, Linha, Coluna, Tabuleiro, Resultado), Resultado = False, NovoTabuleira = Tabuleiro.

makePlay(Linha, Coluna, novaLinha, novaColuna, Jogador, Tabuleiro, NovoTabuleiro) :-
	mover_O_para_esquerda_ou_direita(Linha, Coluna, novaLinha, novaColuna, Tabuleiro, Permissao), Permissao = True, muda_valor_casa(Linha, Coluna, " ", Tabuleiro), muda_valor_casa(novaLinha, novaColuna, "O", Tabuleiro), NovoTabuleiro = Tabuleiro.
	


	

/*
print(string_concat("\n_____________________________O QUE EH O JOGO?_______________________________",
                    "\n\n\t      O jogo de damas eh constituido por um tabuleiro quadratico,\n\tdividido em 64 quadrados com 24 pecas, sendo 12 de cor branca e\n\t12 de cor preta. Existem 8 linhas que estao na posicao vertical,\n\te 8 colunas na posicao horizantal e dois jogadores 'O' e 'X',\n\tonde a dama de O é 'M' e a de X é 'Y'.\n",
                    "\n______________________________  O OBJETIVO  ________________________________",
                    "\n\n\t      Comer todas as pecas do adversario. Quem comer todas as pecas\n\tdo adversario eh o vencedor!\n\n",
                    "\n______________________________REGRAS O JOGO_________________________________",
                    "\n\n\t1- Nao eh permitido peca normal comer ou andar para tras.\n\t2- Pode comer apenas uma peca.\n\t3- Pecas normais so andam uma casa por vez.\n\t4- O Jogo dura 10 ou mais minutos.\n\t5- Nao eh permitido jogar com uma peca do adversario.\n\t6- A dama pode comer ou andar para tras porém ainda apenas uma casa\n\tpor vez.\n",
                    "____________________________________________________________________________\n\n"));

*/

:- initialization main.

main:-
    print("Escolha uma opcao (digite o numero): 1. Jogar | 2. Ajuda"),nl,
    read(Opcao),nl,
    menu_opcao(Opcao),
    main,
    halt(0).
