#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct {
       char game1[20], game2[20], ganhador[20];
       int cont1, cont2, pont_max;
} dama;

  void jogar(char matriz[8][8],char jogador, int oposto) {
  int i, j, l, c, li, co, opcao = 0;

  do {

    system("cls");

    if (jogador == 1)
       printf("\n\n----------------    A VEZ EH A DO JOGADOR PECA PRETA  ----------\n\n\n\n");
    if (jogador == 2)
       printf("\n\n----------------    A VEZ EH A DO JOGADOR PECA BRANCA  ------------\n\n\n\n");
       printf("\t \t\t   0 1 2 3 4 5 6 7 \n");

    for(i = 0; i < 8; i++) {
       printf("\n\t\t\t%d  ", i);

       for(j = 0; j < 8; j++)
       printf("%c ", matriz[i][j]);
    }

    printf("\n\n\n\n\t***************  COORDENADA DA PECA:  **********************");
    printf("\n\tLINHA: ");
    scanf("%d",&l);
    printf("\n\tCOLUNA: ");
    scanf("%d",&c);


    printf("\n\n\t****** COORDENADA DA POSICAO QUE A PECA VAI OCULPAR: ******");
    printf("\n\tLINHA: ");
    scanf("%d",&li);
    printf("\n\tCOLUNA: ");
    scanf("%d",&co);


  if ((li+co) % 2 == 0) {

     if((jogador == 1 && l < li) || (jogador == 2 && l > li)) {

        if (c-1 == co|| c+1 == co) {
            if(co == c-1) {
                matriz[li][co] = jogador;
                matriz[l][c] = 0;
                opcao++;
            }
            if(co == c+1) {
                matriz[li][co] = jogador;
                matriz[l][c] = 0;
                opcao++;
            }
        }

        if (matriz[l+1][c+1] == oposto) {
            if(c+2 == co) {
                matriz[li][co] = jogador;
                matriz[l][c] = 0;
                opcao++;
                matriz[l+1][c+1] = 0;
            }
        }

        if (matriz[l+1][c-1] == oposto) {
            if(c-2 == co) {
                matriz[li][co] = jogador;
                matriz[l][c] = 0;
                matriz[l+1][c-1] = 0;
                opcao++;
            }
        }

        if (matriz[l-1][c+1] == oposto) {
            if(c+2 == co) {
                matriz[li][co] = jogador;
                matriz[l][c] = 0;
                opcao++;
                matriz[l-1][c+1] = 0;
            }
        }

        if (matriz[l-1][c-1]==oposto) {
            if(c-2 == co) {
                matriz[li][co] = jogador;
                matriz[l][c] = 0;
                matriz[l-1][c-1] = 0;
                opcao++;
            }
        }
  }

  else printf("\n\n\t\t___________MOVIMENTO INVALIDO!!_________\n\n\t\t_________JOGUE NOVAMENTE...________\n");
  }
    system("pause");
  } while(opcao != 1);
}

void jogarComp(char matriz[8][8], char jogador, int oposto) {
  int i, g, j, l, c, li, co, opcao = 0, cAux, lAux, cFim, lFim, escolhaRealizada = 0;

  do {
    system("cls");
    if (jogador == 1)
       printf("\n\n----------------    A VEZ EH A DO JOGADOR PECA PRETA  ----------\n\n\n\n");
    if (jogador == 2)
       printf("\n\n----------------    A VEZ EH A DO JOGADOR PECA BRANCA  ------------\n\n\n\n");
       printf("\t \t\t   0 1 2 3 4 5 6 7 \n");

    int linhasPossiveis[12] = {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
    int colunasPossiveis[12] = {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
    int index = 0;

    for(i = 0; i < 8; i++) {
       printf("\n\t\t\t%d  ", i);

       for(j = 0; j < 8; j++) {
           printf("%c ", matriz[i][j]);
           if(matriz[i][j] == jogador && i != 0){
                linhasPossiveis[index] = i;
                colunasPossiveis[index] = j;
                index = index + 1;
           }
       }
    }

    for(g = 0; g < 12; g++) {
        cAux = linhasPossiveis[g];
        lAux = colunasPossiveis[g];
        lFim = lAux-1;
        if (lAux != -1 && cAux != -1 && lFim > 0) {

            if (cAux+1 < 7 && matriz[lFim][cAux+1] == oposto) {
                if(lFim-1 >= 0 && cAux+2 < 8 && matriz[lFim-1][cAux+2] == 0) {
                    l = lAux;
                    c = cAux;
                    li = lFim - 1;
                    co = cAux + 2;
                    escolhaRealizada = 1;
                    break;
                }
            }
            else if (cAux-1 > 0 && matriz[lFim][cAux-1] == oposto) {
                if (lFim-1 >= 0 && cAux-2 >= 0 && matriz[lFim-1][cAux-2] == 0) {
                    l = lAux;
                    c = cAux;
                    li = lFim - 1;
                    co = cAux - 2;
                    escolhaRealizada = 1;
                    break;
                }
            }
        }
    }

    if (escolhaRealizada == 0) {
        for(g = 0; g < 12; g++) {
            cAux = linhasPossiveis[g];
            lAux = colunasPossiveis[g];
            lFim = lAux-1;
            if(lAux != -1 && cAux != -1 && lFim >= 0) {
                if(cAux+1 < 8 && matriz[lFim][cAux + 1] == 0) {
                    l = lAux;
                    c = cAux;
                    li = lFim;
                    co = cAux + 1;
                    escolhaRealizada = 1;
                    break;
                }
                else if(cAux-1 >= 0 && matriz[lFim][cAux - 1] == 0) {
                    l = lAux;
                    c = cAux;
                    li = lFim;
                    co = cAux - 1;
                    escolhaRealizada = 1;
                    break;
                }
            }
        }
    }
    printf("\n\n\n\n\t******************  MOVIMENTO DA MAQUINA  **********************\n");
    printf("\n\tDE: LINHA - %d COLUNA - %d\n", l, c);
    printf("\n\tPARA: LINHA - %d COLUNA - %d\n\n", li, co);

  if ((li+co) % 2 == 0) {

     if((jogador == 1 && l < li) || (jogador == 2 && l > li)) {

        if (c-1 == co|| c+1 == co) {
            if(co == c-1) {
                matriz[li][co] = jogador;
                matriz[l][c] = 0;
                opcao++;
            }
            if(co == c+1) {
                matriz[li][co] = jogador;
                matriz[l][c] = 0;
                opcao++;
            }
        }

        if (matriz[l+1][c+1] == oposto) {
            if(c+2 == co) {
                matriz[li][co] = jogador;
                matriz[l][c] = 0;
                opcao++;
                matriz[l+1][c+1] = 0;
            }
        }

        if (matriz[l+1][c-1] == oposto) {
            if(c-2 == co) {
                matriz[li][co] = jogador;
                matriz[l][c] = 0;
                matriz[l+1][c-1] = 0;
                opcao++;
            }
        }

        if (matriz[l-1][c+1] == oposto) {
            if(c+2 == co) {
                matriz[li][co] = jogador;
                matriz[l][c] = 0;
                opcao++;
                matriz[l-1][c+1] = 0;
            }
        }

        if (matriz[l-1][c-1]==oposto) {
            if(c-2 == co) {
                matriz[li][co] = jogador;
                matriz[l][c] = 0;
                matriz[l-1][c-1] = 0;
                opcao++;
            }
        }
  }

  else printf("\n\n\t\t__________MOVIMENTO INVALIDO!!_________\n\t\t_________JOGUE NOVAMENTE...________\n");
  }
    system("pause");
  } while(opcao != 1);
}

void ganhador(char matriz[8][8]) {
    int i, j;

    for (i = 0; i < 8; i++)
       for (j = 0; j < 8; j++) {
         if (matriz[i][j] == 2)
         dama.cont2++;
         if(matriz[i][j] == 1)
         dama.cont2++;
       }

       // VERIFICA QUEM TEM MAIS PECAS, MOSTRANDO QUEM EH O VENCEDOR...
    if(dama.cont1 > dama.cont2) {
       printf("\n\tVENCEDOR........-> %s TOTAL DE PECAS: %d\n\n", dama.game1, dama.cont1); // GAME 1. JOGADOR DE PECAS PRETAS.
       strcpy(dama.ganhador, dama.game1);// PONTUACAO DO JOGADOR DE PECAS PRETAS
       dama.pont_max = dama.cont1; // PONTUCAO MAXIMA DO CONTADOR DE PECAS PRETAS
    }
    else {
    // OLHA QUEM TEM MAIS PECAS...
       if (dama.cont1 < dama.cont2) {
        printf("\n\tVENCEDOR........-> %s TOTAL DE PECAS: %d\n\n",dama.game2,dama.cont2);//GAME 2. JOGADOR DE PECAS BRANCAS.
        strcpy(dama.ganhador, dama.game2); // PONTUACAO DO JOGADOR DE PECAS BRANCAS
        dama.pont_max = dama.cont2; // PONTUACAO MAXIMA DO JOGADOR DE PECAS BRANCAS
       }
       else {
        printf("\n\tEmpate!\n\t%s: %d\n\t%s: %d\n\n\n", dama.game1, dama.cont1, dama.game2, dama.cont2); // CASO DE EMPATE
        strcpy(dama.ganhador,"jogo empatado");
        dama.pont_max = dama.cont2; // PONTUACAO MAXIMA
       }
    }
}


int main(int argc, char *argv[]) {
    // DECLARACAO DOS CARACTERES NO TABULEIRO... QUEM ESTA VAZIO... QUEM E PRETA E BRANCA... E OS ESPACOS LIVRES
    char matriz[8][8];
    int i, j, jogador = 1, oposto = 2, opcao = 0, opcao_selecionada, opcaoDeJogabilidade;
    dama.cont1 = dama.cont2 = 0;

    matriz[0][0]= 1;     matriz[0][1]= 178;   matriz[0][2]= 1;   matriz[0][3] = 178; matriz[0][4] = 1;  matriz[0][5]= 178; matriz[0][6]= 1;   matriz[0][7]= 178;
    matriz[1][0]= 178;   matriz[1][1]= 1;     matriz[1][2]= 178; matriz[1][3] = 1;   matriz[1][4] = 178;matriz[1][5]= 1;   matriz[1][6]= 178; matriz[1][7]= 1;
    matriz[2][0]= 1;     matriz[2][1]= 178;   matriz[2][2]= 1;   matriz[2][3] = 178; matriz[2][4] = 1;  matriz[2][5]= 178; matriz[2][6]= 1;   matriz[2][7]= 178;
    matriz[3][0]= 178;   matriz[3][1]= 0;     matriz[3][2]= 178; matriz[3][3] = 0;   matriz[3][4] = 178;matriz[3][5]= 0;   matriz[3][6]= 178; matriz[3][7]= 0;
    matriz[4][0]= 0;     matriz[4][1]= 178;   matriz[4][2]= 0;   matriz[4][3] = 178; matriz[4][4] = 0;  matriz[4][5]= 178; matriz[4][6]= 0;   matriz[4][7]= 178;
    matriz[5][0]= 178;   matriz[5][1]= 2;     matriz[5][2]= 178; matriz[5][3] = 2;   matriz[5][4] = 178;matriz[5][5]= 2;   matriz[5][6]= 178; matriz[5][7]= 2;
    matriz[6][0]= 2;     matriz[6][1]= 178;   matriz[6][2]= 2;   matriz[6][3] = 178; matriz[6][4] = 2;  matriz[6][5]= 178; matriz[6][6]= 2;   matriz[6][7]= 178;
    matriz[7][0]= 178;   matriz[7][1]= 2;     matriz[7][2]= 178; matriz[7][3] = 2;   matriz[7][4] = 178;matriz[7][5]= 2;   matriz[7][6]= 178; matriz[7][7]= 2;

    do {

      printf("\n\t__________________________________________________________\n");
      printf("\t__________________________________________________________\n");
      printf("\t__________________                    ____________________\n");
      printf("\t__________________        UFCG        ____________________\n");
      printf("\t__________________                    ____________________\n");
      printf("\t__________________    PROJETO APLP    ____________________\n");
      printf("\t__________________       DAMAS        ____________________\n");
      printf("\t__________________                    ____________________\n");
      printf("\t__________________________________________________________\n");
      printf("\t__________________________________________________________\n\t\t\t\t\t\n");
      printf("\tEscolha uma das opcoes abaixo:\n\n");
      printf("\t 1- Jogar.\n\t 2- Ajuda.\n\t 3- Sair.\n\n");
      printf("\tOpcao: ");

      scanf("%d", &opcao_selecionada);
      system("cls");

      switch(opcao_selecionada) {
        case 1:

            printf("\n\n\t\t\tSelecione o modo de jogo:\n");
            printf("\n\t\t\t1- Dois Jogadores.\n\t\t\t2- Jogar contra a maquina.\n\n");
            printf("\n\t\t\tOpcao: ");
            scanf("%d", &opcaoDeJogabilidade);
            printf("\n\n\n");
            system("pause");
            system("cls");
            if(opcaoDeJogabilidade == 1) {

                printf("\n\n\t\tINFORME O NOME DO JOGADOR PECA PRETA:\n\n\t\t\t\t");
                scanf("%s",dama.game1);
                printf("\n\n\t\tINFORME O NOME DO JOGADOR PECA BRANCA:\n\n\t\t\t\t ");
                scanf("%s",dama.game2);
                system("cls");

                while(dama.pont_max < 12) {
                    jogador = 1; oposto = 2;
                    jogar(matriz, jogador, oposto);
                    jogador = 2; oposto = 1;
                    jogar(matriz, jogador, oposto);
                }
                system("cls");

                ganhador(matriz);

                system("pause");
                system("cls");
                break;
            }
            else if(opcaoDeJogabilidade == 2) {

                printf("\n\n\t\tINFORME O NOME DO JOGADOR:\n\n\t\t\t\t");
                scanf("%s",dama.game1);
                printf("\n\n\t\tINFORME O NOME DO JOGADOR PECA BRANCA:\n\n\t\t\t\t ");
                scanf("%s",dama.game2);

                while(dama.pont_max < 12) {
                    jogador = 1; oposto = 2;
                    jogar(matriz, jogador, oposto);
                    jogador = 2; oposto = 1;
                    jogarComp(matriz, jogador, oposto);
                }

                system("cls");
                ganhador(matriz);
                system("pause");
                system("cls");
                break;
            }
            else {
                printf("\n\n\t\t********** OPCAO DE JOGABILIDADE INVALIDA! **********\n\n\t\t\t\t");
                system("pause");
                system("cls");
                break;
            }

        case 2:
            printf("\n_____________________________O QUE EH O JOGO?_______________________________");
            printf("\n\n\t     O jogo de Damas eh constituido por um tabuleiro quadratico,\n\tdividido em 64 quadrados com 24 pecas, sendo 12 de cor branca\n\te 12 de cor preta. Exitem  8 linhas que estao na posicao vertical,\n\te com 8 colunas na posicao horizantal.\n");
            printf("\n_____________________________  O OBJETIVO  _______________________________");
            printf("\n\n\t      Comer o maior numero de pecas possiveis do adversario. Quem \n\tdurante os 3 minutos tiver mais pecas, eh o vencedor!\n\n");
            printf("\n______________________________REGRAS O JOGO_________________________________");
            printf("\n\n\t1- Nao eh permitido comer para tras.\n\t2- Pode comer uma peca, nao duas de uma vez.\n\t3- Soh anda uma casa por vez.\n\t4- O Jogo dura 3 Minutos.\n\t5- Nao eh permitido jogar com uma peca do adversario.\n");
            printf("____________________________________________________________________________\n\n");
            system("pause");
            system("cls");
            break;

        case 3:
            printf("\n\n\n\n\t\t\t\tFIM DO JOGO\n\n\n\n\n");
            break;
    }
  } while(opcao_selecionada != 3);

  return 0;
}
