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

jogador("X").
jogador("O").

dama("Z").
dama("M").

espacoVazio("~").

alterna_jogador("X", "O").
alterna_jogador("O", "X").

damaDoJogador("X", "Z").
damaDoJogador("O", "M").

pecaDoOponente("X", "O").
pecaDoOponente("X", "M").
pecaDoOponente("Z", "O").
pecaDoOponente("Z", "M").
pecaDoOponente("O", "X").
pecaDoOponente("O", "Z").
pecaDoOponente("M", "X").
pecaDoOponente("M", "Z").


% Desenha o tabuleiro.  
% [Lista1, Lista2, Lista3, Lista4, Lista5, Lista6, Lista7, Lista8, Lista9] - array de 9 linhas. 
% 
desenha_tabuleiro([L1, L2, L3, L4, L5, L6, L7, L8, L9]) :-  
    desenha_linha(L1),
    desenha_linha(L2),  
    desenha_linha(L3),
    desenha_linha(L4),
    desenha_linha(L5), 
    desenha_linha(L6), 
    desenha_linha(L7), 
    desenha_linha(L8), 
    desenha_linha(L9), nl.  
  
% Desenha uma linha.
% [A1, A2, A3, A4, A5, A6, A7, A8, A9] - array de 9 caracteres.
%      
desenha_linha([A1, A2, A3, A4, A5, A6, A7, A8, A9]) :-  
    write("      "),  
    write(A1), write("|"),  
    write(A2), write("|"),  
    write(A3), write("|"),
    write(A4), write("|"),
    write(A5), write("|"),
    write(A6), write("|"),
    write(A7), write("|"),
    write(A8), write("|"),
    write(A9), write("|"),  
    nl.  

/* ------------------- FIM DE REGRAS PARA DESENHAR O TABULEIRO ------------------------------ */
/* ------------------- INICIO DAS OPERACOES LOGICAS DO JOGO --------------------------------- */


% Retorna o valor de uma casa.  
% nth0(Indice, Lista, Elemento) - itera na lista, contador de 0 a Index, e retorna elemento na Lista[Indice].
%
retorna_valor_na_casa(Linha, Coluna, Elemento, Tabuleiro) :-        
   nth0(Linha, Tabuleiro, LinhaLista),     % aqui retorna a linha da matriz
   nth0(Coluna, LinhaLista, Elemento). % acessa o elemento da linha retornada anteriormente  

% Verifica se a posicao (par linha-coluna) eh valida nos limites do tabuleiro.
%   Resultado - verificao.
%
verifica_indices_tabuleiro(Linha, Coluna, Resultado) :- 
    Linha >= 1, Linha =< 8, Coluna >= 1, Coluna =< 8, Resultado = "True".   
verifica_indices_tabuleiro(_, _, Resultado) :-
    Resultado =  "False".

% Efetuada a jogada, muda o valor de uma casa.
%   Tabuleiro       - tabuleiro.    
%   Valor           - novo valor.  
%   NovoTabuleiro   - novo tabuleiro com os novos valores definidos.
%

mudaColuna(Coluna, Index, Elemento, [T|[]], [N|Ns]) :-
    N = T.
mudaColuna(Coluna, Index, Elemento, [T|Ts], [N|Ns]) :-
    Coluna =\= Index,
    mudaColuna(Coluna, Index+1, Elemento, Ts, Ns), 
    N = T.
mudaColuna(Coluna, Index, Elemento, [T|Ts], [N|Ns]) :-
    mudaColuna(Coluna, Index+1, Elemento, Ts, Ns),
    N = Elemento. 

mudaLinha(_, _, _, _, [T|[]], [N|Ns]) :-
    N = T.
mudaLinha(Linha, Coluna, Index, Elemento, [T|Ts], [N|Ns]) :-
    Linha =\= Index,
    mudaLinha(Linha, Coluna, (Index+1), Elemento, Ts, Ns), 
    N = T. 
mudaLinha(Linha, Coluna, Index, Elemento, [T|Ts], [N|Ns]) :-
    mudaColuna(Coluna, 0, Elemento, T, N2), 
    mudaLinha(Linha, Coluna, (Index+1), Elemento, Ts, Ns),
    N = N2.

mudaPeca(Linha, Coluna, Elemento, Tabuleiro, NovoTabuleiro) :-
    jogador(Elemento),
    (Linha =:= 1 ; Linha =:= 8),
    damaDoJogador(Elemento, Dama),
    mudaLinha(Linha, Coluna, 0, Dama, Tabuleiro, NovoTabuleiro).
mudaPeca(Linha, Coluna, Elemento, Tabuleiro, NovoTabuleiro) :-
    mudaLinha(Linha, Coluna, 0, Elemento, Tabuleiro, NovoTabuleiro).





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

verifica_igualdade_tabuleiros([], _, Result) :-
    Result = "True".
verifica_igualdade_tabuleiros([T|Ts], [N|Ns], Result) :-
    T = N,
    verifica_igualdade_tabuleiros(Ts, Ns, Result).
verifica_igualdade_tabuleiros([T|Ts], [N|Ns], Result) :-
    Result = "False".





% Verifica se a jogada foi realizada com sucesso.
%
verifica_tabuleiro(Peca, DamaPeca, [], "False") :- !.
verifica_tabuleiro(Peca, DamaPeca, [Cabeca|Cauda], Resultado) :-
    (member(Peca, Cabeca); member(DamaPeca, Cabeca)), Resultado = "True";
    verifica_tabuleiro(Peca, DamaPeca, Cauda, Resultado).


jogadorXSeMove(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro) :-
    Coluna - NovaColuna =:= 1,
    LinhaParaVerificar is Linha-1,
    ColunaParaVerificar is Coluna-1,
    retorna_valor_na_casa(LinhaParaVerificar, ColunaParaVerificar, ValorParaVerificar, Tabuleiro),
    espacoVazio(ValorParaVerificar),
    mudaPeca(Linha, Coluna, "~", Tabuleiro, TabuleiroProv),
    mudaPeca(NovaLinha, NovaColuna, Elemento, TabuleiroProv, NovoTabuleiro),
    write("JOGADOR 'X' SE MOVE PARA A ESQUERDA"),nl.
jogadorXSeMove(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro) :-
    Coluna - NovaColuna =:= -1,
    LinhaParaVerificar is Linha-1,
    ColunaParaVerificar is Coluna+1,
    retorna_valor_na_casa(LinhaParaVerificar, ColunaParaVerificar, ValorParaVerificar, Tabuleiro),
    print(LinhaParaVerificar),nl,
    print(ColunaParaVerificar),nl,
    espacoVazio(ValorParaVerificar),
    mudaPeca(Linha, Coluna, "~", Tabuleiro, TabuleiroProv),
    mudaPeca(NovaLinha, NovaColuna, Elemento, TabuleiroProv, NovoTabuleiro),
    write("JOGADOR 'X' SE MOVE PARA A DIREITA"),nl.
jogadorXSeMove(_, _, _, _, _, Tabuleiro, NovoTabuleiro) :-
    NovoTabuleiro = Tabuleiro.


jogadorXCome(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro) :-
    Coluna - NovaColuna =:= 2,
    LinhaParaVerificar is Linha-1,
    ColunaParaVerificar is Coluna-1,
    retorna_valor_na_casa(LinhaParaVerificar, ColunaParaVerificar, ValorParaVerificar, Tabuleiro),
    pecaDoOponente(Elemento, ValorParaVerificar),
    mudaPeca(Linha, Coluna, "~", Tabuleiro, TabuleiroProv),
    mudaPeca(LinhaParaVerificar, ColunaParaVerificar, "~", TabuleiroProv, TabuleiroProv2),
    mudaPeca(NovaLinha, NovaColuna, Elemento, TabuleiroProv2, NovoTabuleiro),
    write("JOGADOR 'X' COMEU PARA A ESQUERDA"),nl.
jogadorXCome(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro) :-
    Coluna - NovaColuna =:= -2,
    LinhaParaVerificar is Linha-1,
    ColunaParaVerificar is Coluna+1,
    retorna_valor_na_casa(LinhaParaVerificar, ColunaParaVerificar, ValorParaVerificar, Tabuleiro),
    pecaDoOponente(Elemento, ValorParaVerificar),
    mudaPeca(Linha, Coluna, "~", Tabuleiro, TabuleiroProv),
    mudaPeca(LinhaParaVerificar, ColunaParaVerificar, "~", TabuleiroProv, TabuleiroProv2),
    mudaPeca(NovaLinha, NovaColuna, Elemento, TabuleiroProv2, NovoTabuleiro),
    write("JOGADOR 'X' COMEU PARA A DIREITA"),nl.
jogadorXCome(_, _, _, _, _, Tabuleiro, NovoTabuleiro) :-
    NovoTabuleiro = Tabuleiro.


jogadorOSeMove(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro) :-
    Coluna - NovaColuna =:= 1,
    LinhaParaVerificar is Linha+1,
    ColunaParaVerificar is Coluna-1,
    retorna_valor_na_casa(LinhaParaVerificar, ColunaParaVerificar, ValorParaVerificar, Tabuleiro),
    espacoVazio(ValorParaVerificar),
    mudaPeca(Linha, Coluna, "~", Tabuleiro, TabuleiroProv),
    mudaPeca(NovaLinha, NovaColuna, Elemento, TabuleiroProv, NovoTabuleiro),
    write("JOGADOR 'O' SE MOVE PARA A ESQUERDA"),nl.
jogadorOSeMove(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro) :-
    Coluna - NovaColuna =:= -1,
    LinhaParaVerificar is Linha+1,
    ColunaParaVerificar is Coluna+1,
    retorna_valor_na_casa(LinhaParaVerificar, ColunaParaVerificar, ValorParaVerificar, Tabuleiro),
    print(LinhaParaVerificar),nl,
    print(ColunaParaVerificar),nl,
    espacoVazio(ValorParaVerificar),
    mudaPeca(Linha, Coluna, "~", Tabuleiro, TabuleiroProv),
    mudaPeca(NovaLinha, NovaColuna, Elemento, TabuleiroProv, NovoTabuleiro),
    write("JOGADOR 'O' SE MOVE PARA A DIREITA"),nl.
jogadorOSeMove(_, _, _, _, _, Tabuleiro, NovoTabuleiro) :-
    NovoTabuleiro = Tabuleiro.


jogadorOCome(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro) :-
    Coluna - NovaColuna =:= 2,
    LinhaParaVerificar is Linha+1,
    ColunaParaVerificar is Coluna-1,
    retorna_valor_na_casa(LinhaParaVerificar, ColunaParaVerificar, ValorParaVerificar, Tabuleiro),
    pecaDoOponente(Elemento, ValorParaVerificar),
    mudaPeca(Linha, Coluna, "~", Tabuleiro, TabuleiroProv),
    mudaPeca(LinhaParaVerificar, ColunaParaVerificar, "~", TabuleiroProv, TabuleiroProv2),
    mudaPeca(NovaLinha, NovaColuna, Elemento, TabuleiroProv2, NovoTabuleiro),
    write("JOGADOR 'O' COMEU PARA A ESQUERDA"),nl.
jogadorOCome(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro) :-
    Coluna - NovaColuna =:= -2,
    LinhaParaVerificar is Linha+1,
    ColunaParaVerificar is Coluna+1,
    retorna_valor_na_casa(LinhaParaVerificar, ColunaParaVerificar, ValorParaVerificar, Tabuleiro),
    pecaDoOponente(Elemento, ValorParaVerificar),
    mudaPeca(Linha, Coluna, "~", Tabuleiro, TabuleiroProv),
    mudaPeca(LinhaParaVerificar, ColunaParaVerificar, "~", TabuleiroProv, TabuleiroProv2),
    mudaPeca(NovaLinha, NovaColuna, Elemento, TabuleiroProv2, NovoTabuleiro),
    write("JOGADOR 'O' COMEU PARA A DIREITA"),nl.
jogadorOCome(_, _, _, _, _, Tabuleiro, NovoTabuleiro) :-
    NovoTabuleiro = Tabuleiro.





pulaJogador(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro) :-
    Linha - NovaLinha =:= 1,
    Elemento = "X",   
    jogadorXSeMove(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro).
pulaJogador(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro) :-
    Linha - NovaLinha =:= -1,
    Elemento = "O",   
    jogadorOSeMove(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro).
pulaJogador(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro) :-
    Linha - NovaLinha =:= 2,
    Elemento = "X",
    jogadorXCome(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro).
pulaJogador(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro) :-
    Linha - NovaLinha =:= -2,
    Elemento = "O",
    jogadorOCome(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro).
pulaJogador(_, _, _, _, _, Tabuleiro, NovoTabuleiro) :-
    NovoTabuleiro = Tabuleiro.



%%%%%%%%%%%%%%%%%%%%%% puladama()



pula(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro) :-
    (Linha - NovaLinha =:= 1 ; Linha - NovaLinha =:= 2 ; Linha - NovaLinha =:= -1 ; Linha - NovaLinha =:= -2),
    (Coluna - NovaColuna =:= 1 ; Coluna - NovaColuna =:= -1 ; Coluna - NovaColuna =:= 2 ; Coluna - NovaColuna =:= -2),
    jogador(Elemento),
    pulaJogador(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro).
pula(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro) :-
    (Linha - NovaLinha =:= 1 ; Linha - NovaLinha =:= -1 ; Linha - NovaLinha =:= 2 ; Linha - NovaLinha =:= -2),
    (Coluna - NovaColuna =:= 1 ; Coluna - NovaColuna =:= -1 ; Coluna - NovaColuna =:= 2 ; Coluna - NovaColuna =:= -2),
    (Linha - NovaLinha =:= 2; Linha - NovaLinha =:= -2),
    (Coluna - NovaColuna =:= 2; Coluna - NovaColuna =:= -2),
    dama(Elemento),
    pulaDama(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro).
pula(_, _, _, _, Tabuleiro, NovoTabuleiro) :-
    NovoTabuleiro = Tabuleiro.





-----------------------------------------



verifica_jogada(Tabuleiro, NovoTabuleiro, Mensagem, Jogador, NovoJogador) :-
    write("veio"),nl,
    verifica_igualdade_tabuleiros(Tabuleiro, NovoTabuleiro, Result),
    Result = "True",
    Mensagem = "Jogada inválida!",
    NovoJogador = Jogador.
verifica_jogada(Tabuleiro, NovoTabuleiro, Mensagem, Jogador, NovoJogador) :- 
    Mensagem = "Jogada realizada!",
    alterna_jogador(Jogador, NovoJogador).

realiza_jogada(Linha, Coluna, NovaLinha, NovaColuna, Tabuleiro, Jogador, NovoTabuleiro, NovoJogador, Mensagem) :-
    verifica_indices_tabuleiro(Linha, Coluna, Resultado1),
    verifica_indices_tabuleiro(NovaLinha, NovaColuna, Resultado2),
    Resultado1 = "True",
    Resultado2 = "True",
    retorna_valor_na_casa(Linha, Coluna, Elemento, Tabuleiro),
    damaDoJogador(Jogador, DamaJogador),
    ((Elemento = Jogador); (Elemento = DamaJogador)),
    retorna_valor_na_casa(NovaLinha, NovaColuna, ElementoVazio, Tabuleiro),
    espacoVazio(ElementoVazio),
    pula(Linha, Coluna, NovaLinha, NovaColuna, Elemento, Tabuleiro, NovoTabuleiro),
    verifica_jogada(Tabuleiro, NovoTabuleiro, Mensagem, Jogador, NovoJogador).
realiza_jogada(_, _, _, _, Tabuleiro, Jogador, NovoTabuleiro, NovoJogador, Mensagem) :-
    NovoTabuleiro = Tabuleiro,
    NovoJogador = Jogador,
    Mensagem = "Jogada inválida!".


inicia_jogo(Tabuleiro, Jogador):-
    desenha_tabuleiro(Tabuleiro),
    write("JOGADOR DA RODADA: "),
    write(Jogador), nl,
    pega_posicao(Linha, Coluna),
    pega_nova_posicao(NovaLinha, NovaColuna),

    realiza_jogada(Linha, Coluna, NovaLinha, NovaColuna, Tabuleiro, Jogador, NovoTabuleiro, NovoJogador, Mensagem),

    write(Mensagem),nl,
    inicia_jogo(NovoTabuleiro, NovoJogador).

menu_opcao('1') :-
    %retorna_vencedor(novo_tabuleiro, Elemento),
    novo_tabuleiro(Tabuleiro),
    inicia_jogo(Tabuleiro,"X").
menu_opcao('2') :-
    print("COLOCA AS REGRAS AQUI!"), nl.
menu_opcao(_) :-
    main.
    
    
pega_posicao(Linha, Coluna):-
    print("Digite a linha na qual a peca se encontra:"),
    read_line_to_codes(user_input, A),
    string_to_atom(A,B),
    atom_number(B,Linha),
    print("Digite a coluna na qual a peca se encontra:"),
    read_line_to_codes(user_input, C),
    string_to_atom(C,D),
    atom_number(D,Coluna).

pega_nova_posicao(NovaLinha, NovaColuna):-
    print("Digite a linha que desejas para nova posicao da peca:"),
    read_line_to_codes(user_input, A),
    string_to_atom(A,B),
    atom_number(B,NovaLinha),
    print("Digite a coluna que desejas para nova posicao da peca:"),
    read_line_to_codes(user_input, C),
    string_to_atom(C,D),
    atom_number(D,NovaColuna).
    

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

main :-
    print("Novo Jogo!"), nl,
    print("Escolha uma opcao (digite o numero): 1. Jogar | 2. Ajuda"),nl,
    read_line_to_codes(user_input, T1),
    string_to_atom(T1, A),
    menu_opcao(A),
    main,
    halt(0).
