/* ------------------- REGRAS PARA DESENHAR O TABULEIRO ------------------------------ */

% Cria um tabuleiro.  
%

:- use_module(library(lists)).

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

% Fatos para alternar os jogadores.
%
troca_jogador("X","O").
troca_jogador("O","X").

% Fatos para alternar os valores das pecas.
troca_valor_posicao("X","O").
troca_valor_posicao("O","X").
troca_valor_posicao("~","X").
troca_valor_posicao("~","O").

% Fatos para transformar a peca em sua respectiva rainha...
%
transforma_peca_em_rainha("O", "M").
transforma_peca_em_rainha("X", "Z").

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
    Coluna >= 1, Coluna =< 8, Resultado = "True".

% Efetuada a jogada, muda o valor de uma casa.
%   Tabuleiro       - tabuleiro.    
%   Valor           - novo valor.  
%   NovoTabuleiro   - novo tabuleiro com os novos valores definidos.
%
muda_valor_casa(Linha, Coluna, NovoValor, Tabuleiro, NovoTabuleiro) :- 
    print("ENTROU EM MUDA_V"),nl,
    retorna_valor_na_casa(Linha, Coluna, Elemento, Tabuleiro),
    print("PASSOU DE RETORNA"),nl,
    print(Elemento),nl,
    troca_valor_posicao(Elemento, NovoValor),
    print("TROCOU VALOR"),nl,
    
    nth0(Linha,Tabuleiro,LinhaTabuleiro),
    PosAux is Coluna+1, LinhaSubstituida is Linha+1,
    substituir(NovoValor,PosAux, LinhaTabuleiro, ResultadoLinha),
    substituir(ResultadoLinha,LinhaSubstituida,Tabuleiro,NovoTabuleiro).

% Regra que troca os valores do tabuleiro.
%
substituir(X,1,[_|L],[X|L]).
substituir(X,N,[C|L],[C|R]) :- N1 is N-1, substituir(X,N1,L,R).

/*--------------------- FIM DAS OPERACOES LOGICAS DO JOGO --------------------------------------*/
/* ------------------- INICIO DAS OPERACOES LOGICAS DAS JOGADAS ------------------------------- */

% Verifica se a peca na posicao eh uma peca valida, ou seja, do tipo "X", "O", "Z" (dama do X), "M" (dama do O).
%   Elemento - peca que estah na posicao passada.
%
verifica_pecas_na_posicao("X", Linha, Coluna, Tabuleiro, Resultado) :-
    retorna_valor_na_casa(Linha, Coluna, Elemento, Tabuleiro),     
    (Elemento =:= "X"; Elemento =:= "Z"), 
    print(Elemento),nl,
    Resultado = "True".

verifica_pecas_na_posicao("O", Linha, Coluna, Tabuleiro, Resultado) :-
    retorna_valor_na_casa(Linha, Coluna, Elemento, Tabuleiro),     
    (Elemento =:= "O"; Elemento =:= "M"), 
    Resultado = "True".

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

% Verifica se as pecas de um tipo nao existem mais no tabuleiro.
%
verifica_tabuleiro(Peca, DamaPeca, [], Resultado) :- Resultado = "False".

verifica_tabuleiro(Peca, DamaPeca, [Cabeca|Cauda], Resultado) :-
    (member(Peca, Cabeca); member(DamaPeca, Cabeca)), Resultado = "True";
    verifica_tabuleiro(Peca, DamaPeca, Cauda, Resultado),  

% Verifica e retorna o vencedor jogo.

retorna_vencedor(Tabuleiro, Jogador, ResultadoJogo) :-
    (verifica_tabuleiro("O", "M",  Tabuleiro, Resultado), Resultado = "True"),
    Jogador = "O", ResultadoJogo = "True".
retorna_vencedor(Tabuleiro, Jogador, ResultadoJogo) :-
    (verifica_tabuleiro("X", "Z",  Tabuleiro, Resultado), Resultado = "True"),
    Jogador = "X", ResultadoJogo = "True".

% Recebe a posicao na qual a peca atual estah.    
%
pega_posicao(Linha, Coluna) :-
    print("Digite a linha na qual a peca se encontra: "),
    read(Linha),
    print("Digite a coluna na qual a peca se encontra: "),
    read(Coluna),
    verifica_indices_tabuleiro(Linha, Coluna, Verificacao),
    Verificacao = "True".
    

% Recebe as coordenadas para a nova posicao da peca.
%
pega_nova_posicao(NovaLinha, NovaColuna) :-
    print("Digite a linha que desejas para nova posicao da peca: "),
    read(NovaLinha),
    print("Digite a coluna que desejas para nova posicao da peca: "),
    read(NovaColuna),
    verifica_indices_tabuleiro(NovaLinha, NovaColuna, Verificacao),
    Verificacao = "True".

% Inicia a partida.
%
inicia_jogo :-
    quem_comeca("X").

% Define quem começa a partida.  
%   Jogador - jogador que começa a partida, X ou O.
%
quem_comeca(Jogador) :-
    novo_tabuleiro(Tabuleiro), /* cria um tabuleiro. */
    desenha_tabuleiro(Tabuleiro), /* desenha o tabuleiro. */
    processa_jogo(Tabuleiro, Jogador, NovoTabuleiro).
 
% Responsavel pelo loop principal do jogo.  
% Checa se eh gameover; se nao, faz a proxima jogada acontecer.  
% Eh chamada recursivamente.  
% Recebe um tabuleiro e retorna um novo tabuleiro.  
%   AntigoTabuleiro - tabuleiro antes.  
%   NovoTabuleiro   - tabuleiro novo.  
%
processa_jogo(Tabuleiro, Jogador, NovoTabuleiro) :-
    retorna_vencedor(Tabuleiro, Vencedor, Resultado), ResultadoJogo = "True",
    NovoTabuleiro = Tabuleiro,
    desenha_tabuleiro(NovoTabuleiro).

processa_jogo(Tabuleiro, Jogador, NovoTabuleiro) :-
    print("Jogador da rodada: "),
    print(Jogador),nl,

    pega_posicao(Linha, Coluna),
    pega_nova_posicao(NovaLinha, NovaColuna),
    realiza_jogada(Linha, Coluna, NovaLinha, NovaColuna, Jogador, Tabuleiro, TempTabuleiro),
    print("REALIZOU FERA."),nl,

    desenha_tabuleiro(TempTabuleiro),
    troca_jogador(Jogador, OutroJogador),
    processa_jogo(TempTabuleiro, OutroJogador, NovoTabuleiro). 
   
% Regras para as realizacoes das jogadas feitas pelos oponentes.
%

realiza_jogada(Linha, Coluna, NovaLinha, NovaColuna, Jogador, Tabuleiro, NovoTabuleiro) :-
    print("1"),nl,
    verifica_pecas_na_posicao(Jogador, Linha, Coluna, Tabuleiro, Resultado), Resultado = "False", NovoTabuleiro = Tabuleiro.

realiza_jogada(Linha, Coluna, NovaLinha, NovaColuna, Jogador, Tabuleiro, NovoTabuleiro) :-
    print("ENTRAAAAAAAAAA EM MOVER O"),nl,
    mover_O_para_esquerda_ou_direita(Linha, Coluna, NovaLinha, NovaColuna, Tabuleiro, Permissao), Permissao = "True",
    print("ENTROU EM MOVER_O"),nl,
    muda_valor_casa(Linha, Coluna, "~", Tabuleiro, TempTabuleiro), muda_valor_casa(NovaLinha, NovaColuna, "O", TempTabuleiro, NovoTabuleiro),
    print("SAIU EM MOVER_O"),nl. 
    
realiza_jogada(Linha, Coluna, NovaLinha, NovaColuna, Jogador, Tabuleiro, NovoTabuleiro) :-
    print("ENTRAAAAAAA"),nl,
    mover_X_para_esquerda_ou_direita(Linha, Coluna, NovaLinha, NovaColuna, Tabuleiro, Permissao), Permissao = "True",
    print("ENTROU EM MOVER_X"),nl,
    muda_valor_casa(Linha, Coluna, "~", Tabuleiro, TempTabuleiro), muda_valor_casa(NovaLinha, NovaColuna, "X", TempTabuleiro, NovoTabuleiro),
    print("SAIU EM MOVER_X"),nl. 
    
realiza_jogada(Linha, Coluna, NovaLinha, NovaColuna, Jogador, Tabuleiro, NovoTabuleiro) :-
    print("PRIMEIRA DE COMER"),nl,
    peca_O_come_para_direita(LinhaAtual, ColunaAtual, NovaLinha, NovaColuna, Tabuleiro, Permissao), Permissao = "True",

    TempLinha is Linha + 1, TempColuna is Coluna + 1,

    muda_valor_casa(Linha, Coluna, "~", Tabuleiro, TempTabuleiro_1), muda_valor_casa(TempLinha, TempColuna, "~", TempTabuleiro_1, TempTabuleiro_2),
    muda_valor_casa(NovaLinha, NovaColuna, "O", TempTabuleiro_2, NovoTabuleiro).

realiza_jogada(Linha, Coluna, NovaLinha, NovaColuna, Jogador, Tabuleiro, NovoTabuleiro) :-
    print("SEGUNDA DE COMER"),nl,

    peca_O_come_para_esquerda(LinhaAtual, ColunaAtual, NovaLinha, NovaColuna, Tabuleiro, Permissao), Permissao = "True",

    TempLinha is Linha + 1, TempColuna is Coluna - 1,

    muda_valor_casa(Linha, Coluna, "~", Tabuleiro, TempTabuleiro_1), muda_valor_casa(TempLinha, TempColuna, "~", TempTabuleiro_1, TempTabuleiro_2),
    muda_valor_casa(NovaLinha, NovaColuna, "O", TempTabuleiro_2, NovoTabuleiro).
    
realiza_jogada(Linha, Coluna, NovaLinha, NovaColuna, Jogador, Tabuleiro, NovoTabuleiro) :-
    print("TERCA DE COMER"),nl,

    peca_X_come_para_direita(LinhaAtual, ColunaAtual, NovaLinha, NovaColuna, Tabuleiro, Permissao), Permissao = "True",

    TempLinha is Linha - 1, TempColuna is Coluna + 1,

    muda_valor_casa(Linha, Coluna, "~", Tabuleiro, TempTabuleiro_1), muda_valor_casa(TempLinha, TempColuna, "~", TempTabuleiro_1, TempTabuleiro_2),
    muda_valor_casa(NovaLinha, NovaColuna, "X", TempTabuleiro_2, NovoTabuleiro).
    
realiza_jogada(Linha, Coluna, NovaLinha, NovaColuna, Jogador, Tabuleiro, NovoTabuleiro) :-
    print("4 DE COMER"),nl,

    peca_X_come_para_esquerda(LinhaAtual, ColunaAtual, NovaLinha, NovaColuna, Tabuleiro, Permissao), Permissao = "True",

    TempLinha is Linha - 1, TempColuna is Coluna - 1,

    muda_valor_casa(Linha, Coluna, "~", Tabuleiro, TempTabuleiro_1), muda_valor_casa(TempLinha, TempColuna, "~", TempTabuleiro_1, TempTabuleiro_2),
    muda_valor_casa(NovaLinha, NovaColuna, "X", TempTabuleiro_2, NovoTabuleiro). 

/* ----------------------------- INICIO DO LOOP DO JOGO ----------------------------- */

% Menu do jogo, recebe a opcao.
%
menu_opcao(Opcao) :-
    Opcao = 1, inicia_jogo.
menu_opcao(Opcao) :-
    Opcao = 2, 
    nl, print("_____________________________O QUE EH O JOGO?_______________________________"),
    nl, print("O jogo de damas eh constituido por um tabuleiro quadratico, dividido em 64 quadrados com 24 pecas, sendo 12 de cor branca e 12 de cor preta."),
    nl, print("Existem 8 linhas que estao na posicao vertical e 8 colunas na posicao horizantal. Dois jogadores 'O' e 'X', onde a dama de O é 'M' e a de X é 'Z'."),
    nl, print("______________________________  O OBJETIVO  ________________________________"),
    nl, print("Comer todas as pecas do adversario. Quem comer todas as pecas do adversario eh o vencedor!"),
    nl, print("______________________________REGRAS O JOGO_________________________________"),
    nl, print("1- Nao eh permitido peca normal comer ou andar para tras."),
    nl, print("2- Pode comer apenas uma peca."),
    nl, print("3- Pecas normais so andam uma casa por vez."),
    nl, print("4- O Jogo dura 10 ou mais minutos."),
    nl, print("5- Nao eh permitido jogar com uma peca do adversario."),
    nl, print("6- A dama pode comer ou andar para tras, porem, apenas uma casa por vez."),nl.

menu_opcao(Opcao) :-
    Opcao > 2,
    print("Opcao invalida, tenta de novo, parca!"),nl,
    nl, main.

:- initialization main.
main:-
    nl, print("Escolha uma opcao (digite o numero): 1. Jogar | 2. Ajuda"), nl,
    read(Opcao), nl,
    menu_opcao(Opcao),
    main,
    halt(0).
