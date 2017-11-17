#include <stdio.h>
#include <stdlib.h>
#include <time.h>//BIBLIOTECA  QUE CALCULA O TEMPO...

// ESTRUTURA PARA ARMAZENAR OS DADOS QUE SERAO COLOCADOS NO ARQUIVO...
struct {
       char game1[20], game2[20], ganhador[20]; // NOMES DOS JOGADORES E DO GANHADOR.
       int cont1, cont2, pont_max; // CONTADORES DAS PECAS E MAIOR NUMERO DE PECAS.
} dama;

  FILE *historico;//INICIACAO DO ARQUIVO QUE ARMAZENA OS NOMES DOS JOGADORES,O VENCEDOR, E O NUMERO DE PECAS DO VENCEDOR.
  void desenho() {
     printf("\n\n\n\t\t\t0000000000000000000000000000\n\t\t\t000000000__________000000000\n\t\t\t000000________________000000\n\t\t\t0000____________________0000\n\t\t\t000_____00________00_____000\n\t\t\t00_____0000______0000_____00\n\t\t\t00_____0000______0000_____00\n\t\t\t00______00________00______00\n\t\t\t00________________________00\n\t\t\t00______0__________0______00\n\t\t\t000______00______00______000\n\t\t\t0000_______000000_______0000\n\t\t\t000000________________000000\n\t\t\t000000000___________00000000\n\t\t\t0000000000000000000000000000\n");
  }
  void desenho3() {
     printf("\t\t\t´´´´´´´´´´´´´´´´´´´´´´´$¶´´´´´¶´´´´´¶¢\n\t\t\t´´´´´´´´´´´¶¶¶¶¶¶¶´´´´´´´¶¢´´´¶´´´ø¶\n\t\t\t´´´´´´´´´´¶¶´´´´ø¶¶¶´´´´´´oø´´ø´´øo\n\t\t\t´´´´´´´´´´¶7´´´´´´´¶¶¶´´´´´´1´´´1´´´´1o\n\t\t\t´´´´´´´¶¶¶¶¶¶¶´´´´´´´¶¶¶7´´´´´´´´1o¶¶¶ø\n\t\t\t´´´´´´´¶¶¶¶¶¶¶´´´´´´´´´¶¶¶¶¶¶¶¶´´1\n\t\t\t´´´´´o¶¶¶¶¶¶¶¶¶ø´´´´´´´´´´´´´´´´´´o$¢\n\t\t\t´´´¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶´´´´´´´´´´¢´´1ø´´´1¶¶o\n\t\t\t´´¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶o´´´´´´´1$´´´¶\n\t\t\t´¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶´´´´´´´¶´´´´o¶´\n\t\t\t´¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶´´´´´¶¶\n\t\t\t´´¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶´\n\t\t\t´´´¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶´\n\t\t\t´´´´´¶¶¶¶¶¶¶¶¶¶¶¶´\n\t\t\t´´´´´´´¶¶¶¶¶¶¶¶\n");
  }
  void desenho2() {
     printf("\n\t\t\t´´´¶¶¶¶´´´´´´´´´´s¶¶¶¶¶´´´´´´´´´´´s¶¶¶\n\t\t\t´´´´¶¶¶¶¢´´´´´7¶¶¶¶¶¶¶¶¶¶¶¶¶´´´´´´´¶¶¶¶\n\t\t\t´´´7¶¶¶¶¢´´´¢¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶´´´´s¶¶¶¶s\n\t\t\t´´¶¶¶¶¶¶¶¶´ø¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶1´¶¶¶¶¶¶¶¶\n\t\t\t´´¢øs$¶¶¶¶1¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶´¶¶¶¶¢¢$$\n\t\t\t´´´´´´´´7¢ø¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶s´ø\n\t\t\t´´´´´´´´´´¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶¶\n\t\t\t´´´´´´´´´´1¶¶¶¶ø´´7¶¶¶¶¶1´ø¶¶¶¶¶s\n\t\t\t´´´´´´´´´´´¶¶´´´´´´´¶¶¶´´´´´´s¶¶\n\t\t\t´´´´´´´´´´1¶¶´´´´´´$¶¶¶1´´´´´´¶¶1\n\t\t\t´´´´´´´´´´´¶¶¶´´s¶¶¶´´ø¶¶s´´¶¶¶¶\n\t\t\t´´´´´´´´´´´7¶¶¶¶¶¶¶¶´´´¶¶¶¶¶¶¶¶1\n\t\t\t´´´´´´´´´´´´´¶¶¶¶¶¶¶s$s¶¶¶¶¶¶\n\t\t\t´´´´´´´´´´´ø¶´¶s¶¶¶¶¶¶¶¶¶¶¶´¶´¶s\n\t\t\t´´´´7´´´´$¶¶¶´¶´´´´´´´´´´´$´¶¶¶¶¶\n\t\t\t´1¶¶¶¶¶¶¶¶¶¶ø´¶´¶¶$¶¶$¶¶$¶7¶1´¶¶¶¶¶¶¶¶¶¶¶\n\t\t\t´´¶¶¶¶¶¶¶¶´´´´¶¶¶¶¶¶¶¶¶¶¶¶¶¶1´´´¶¶¶¶¶¶¶¶¶\n\t\t\t´´´ø¶¶¶¶¶´´´´´´1¶¶¶¶¶¶¶¶¶¶¢´´´´´´¶¶¶¶¶¶¶\n\t\t\t´´´´´s¶¶ø´´´´´´´´´$¶¶¶¶¶s´´´´´´´´1¶¶¶\n");
  }
  void desenho4() {
     printf("\t\t\t\t-----\\\\////--------\n\t\t\t\t------( @@)-------\n\t\t\t\t---ooO--(_)--Ooo--\n\t\t\t\t\n\n\n");
  }

  // FUNCAO DO TABULEIRO E DOS JOGADORES...
  void jogar(char matriz[8][8],char jogador, int oposto) {
  int i, j, l, c, li, co, opcao = 0;

  // LACO DO JOGO DA DAMA...
  do {
    system("cls");
    if (jogador == 1)// JOGADOR PECA PRETA
       printf("\n\n----------------    A VEZ EH A DO JOGADOR PECA PRETA  ----------\n\n\n\n");
    if (jogador == 2)// JOGADOR PECA BRANCA
       printf("\n\n----------------    A VEZ EH A DO JOGADOR PECA BRANCA  ------------\n\n\n\n");
       printf("\t \t\t   0 1 2 3 4 5 6 7 \n");// COORDENADAS DO TABULEIRO

    // DESENHO DO TABULEIRO, MATRIZ E OS INDICES...
    for(i = 0; i < 8; i++) {
       printf("\n\t\t\t%d  ", i);

       for(j = 0; j < 8; j++)
       printf("%c ", matriz[i][j]);
    }

    // ESCOLHE A PECA QUE VAI JOGAR...
    printf("\n\n\n\n\t***************  COORDENADA DA PECA  **********************");
    printf("\n\tLINHA: ");
    scanf("%d",&l);
    printf("\n\tCOLUNA: ");
    scanf("%d",&c);

    // POCISAO QUE A PECA VAI OCUPAR...
    printf("\n\n\t****** COORDENADA DA POSICAO QUE A PECA VAI OCULPAR ******");
    printf("\n\tLINHA: ");
    scanf("%d",&li);
    printf("\n\tCOLUNA: ");
    scanf("%d",&co);

  // CONDICAO: SOH ANDA QUANDO A SOMA DOS INDICES FOREM PAR
  if ((li+co) % 2 == 0) {
     // FAZ COM QUE A PECA ANDE SO UMA CASA, E JOGUE UMA PECA DE CADA VEZ (PRETA OU BRANCA)
     if((jogador == 1 && l < li) || (jogador == 2 && l > li)) {

      // ESSAS SAO AS CONDICOES PARA COMER UMA PECA...

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

  else printf("\n\n\t\t__________MOVIMENTO INVALIDO!!_________\n\t\t_________JOGUE NOVAMENTE...________\n");//CASO O JOGADOR ESCOLHA UMA POCISAO INVALIDA
  }
  system("pause");
  } while(opcao != 1); //TERMINA O LACO JOGO DA DAMA
}

void jogarComp(char matriz[8][8], char jogador, int oposto) {
  int i, g, j, l, c, li, co, opcao = 0, cAux, lAux, cFim, lFim, escolhaRealizada = 0;


  // LACO DO JOGO DA DAMA...
  do {
    system("cls");
    if (jogador == 1)// JOGADOR PECA PRETA
       printf("\n\n----------------    A VEZ EH A DO JOGADOR PECA PRETA  ----------\n\n\n\n");
    if (jogador == 2)// JOGADOR PECA BRANCA
       printf("\n\n----------------    A VEZ EH A DO JOGADOR PECA BRANCA  ------------\n\n\n\n");
       printf("\t \t\t   0 1 2 3 4 5 6 7 \n");// COORDENADAS DO TABULEIRO

    int linhasPossiveis[12] = {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
    int colunasPossiveis[12] = {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
    int index = 0;

    // DESENHO DO TABULEIRO, MATRIZ E OS INDICES...
    for(i = 0; i < 8; i++) {
       printf("\n\t\t\t%d  ", i);

       for(j = 0; j < 8; j++){
           printf("%c ", matriz[i][j]);
           if(matriz[i][j] == jogador && i != 0){
                linhasPossiveis[index] = i;
                colunasPossiveis[index] = j;
                index = index + 1;
           }
       }
    }

    //testes
    for(g = 0; g < 12; g++){
        cAux = linhasPossiveis[g];
        lAux = colunasPossiveis[g];
        lFim = lAux-1;
        if(lAux != -1 && cAux != -1 && lFim > 0){
            //DA PREFERENCIA A POSICOES ONDE PODE MATAR ALGUEM
            if(cAux+1 < 7 && matriz[lFim][cAux+1] == oposto){
                if(lFim-1 >= 0 && cAux+2 < 8 && matriz[lFim-1][cAux+2] == 0){
                    l = lAux;
                    c = cAux;
                    li = lFim - 1;
                    co = cAux + 2;
                    escolhaRealizada = 1;
                    break;
                }
            }
            else if(cAux-1 > 0 && matriz[lFim][cAux-1] == oposto){
                if(lFim-1 >= 0 && cAux-2 >= 0 && matriz[lFim-1][cAux-2] == 0){
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

    if(escolhaRealizada == 0){
        for(g = 0; g < 12; g++){
            cAux = linhasPossiveis[g];
            lAux = colunasPossiveis[g];
            lFim = lAux-1;
            if(lAux != -1 && cAux != -1 && lFim >= 0){
                if(cAux+1 < 8 && matriz[lFim][cAux + 1] == 0){
                    l = lAux;
                    c = cAux;
                    li = lFim;
                    co = cAux + 1;
                    escolhaRealizada = 1;
                    break;
                }
                else if(cAux-1 >= 0 && matriz[lFim][cAux - 1] == 0){
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


    // ESCOLHE A PECA QUE VAI JOGAR...
    printf("\n\n\n\n\t***************  MOVIMENTO DA MAQUINA  **********************");
    printf("\n\tDE: LINHA - %d COLUNA - %d\n", l, c);
    printf("\n\tPARA: LINHA - %d COLUNA - %d\n", li, co);


  // CONDICAO: SOH ANDA QUANDO A SOMA DOS INDICES FOREM PAR
  if ((li+co) % 2 == 0) {
     // FAZ COM QUE A PECA ANDE SO UMA CASA, E JOGUE UMA PECA DE CADA VEZ (PRETA OU BRANCA)
     if((jogador == 1 && l < li) || (jogador == 2 && l > li)) {

      // ESSAS SAO AS CONDICOES PARA COMER UMA PECA...

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

  else printf("\n\n\t\t__________MOVIMENTO INVALIDO!!_________\n\t\t_________JOGUE NOVAMENTE...________\n");//CASO O JOGADOR ESCOLHA UMA POCISAO INVALIDA
  }
  system("pause");
  } while(opcao != 1); //TERMINA O LACO JOGO DA DAMA
}

// char game1[20], game2[20]; //NOME DOS JOGADORES

// FUNCAO QUE DEFINE O GANHADOR...
void ganhador(char matriz[8][8]) {
    int i, j;

    for (i = 0; i < 8; i++)
       for (j = 0; j < 8; j++) {
         if (matriz[i][j] == 2)
         dama.cont1++; // QUANTIDADE DE PECAS PRETAS DO JOGADOR Nº 2
         if(matriz[i][j] == 1)
         dama.cont2++; // QUANTIDADE DE PECAS BRANCAS DO JOGADOR Nº 1
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

// FUNCAO DO JOGO QUE REGISTRA NO ARQUIVO...
void registro(void) {
    fwrite(&dama, sizeof(dama), 1, historico);
}

// FUNCAO DO JOGO QUE ESCREVE NO ARQUIVO...
void escreve(void) {
    rewind(historico);
    while(fread(&dama, sizeof(dama), 1, historico) == 1) // LER A INFORMACAO ATE A ULTIMA.
    printf("\nJogador peca preta: %s\nJogador peca branca: %s\nVencedor: %s        Total de pecas: %d\n\n",dama.game1, dama.game2, dama.ganhador, dama.pont_max);
}

int main(int argc, char *argv[]) {
    // DECLARACAO DOS CARACTERES NO TABULEIRO... QUEM ESTA VAZIO... QUEM E PRETA E BRANCA... E OS ESPACOS LIVRES
    char matriz[8][8];
    int i, j, jogador = 1, oposto = 2, opcao = 0, opcao_selecionada, opcaoDeJogabilidade;
    dama.cont1 = dama.cont2 = 0;
    historico = fopen("Historico_dama.bin", "ab+");

    matriz[0][0]= 1;     matriz[0][1]= 178;   matriz[0][2]= 1;   matriz[0][3] = 178; matriz[0][4] = 1;  matriz[0][5]= 178; matriz[0][6]= 1;   matriz[0][7]= 178;
    matriz[1][0]= 178;   matriz[1][1]= 1;     matriz[1][2]= 178; matriz[1][3] = 1;   matriz[1][4] = 178;matriz[1][5]= 1;   matriz[1][6]= 178; matriz[1][7]= 1;
    matriz[2][0]= 1;     matriz[2][1]= 178;   matriz[2][2]= 1;   matriz[2][3] = 178; matriz[2][4] = 1;  matriz[2][5]= 178; matriz[2][6]= 1;   matriz[2][7]= 178;
    matriz[3][0]= 178;   matriz[3][1]= 0;     matriz[3][2]= 178; matriz[3][3] = 0;   matriz[3][4] = 178;matriz[3][5]= 0;   matriz[3][6]= 178; matriz[3][7]= 0;
    matriz[4][0]= 0;     matriz[4][1]= 178;   matriz[4][2]= 0;   matriz[4][3] = 178; matriz[4][4] = 0;  matriz[4][5]= 178; matriz[4][6]= 0;   matriz[4][7]= 178;
    matriz[5][0]= 178;   matriz[5][1]= 2;     matriz[5][2]= 178; matriz[5][3] = 2;   matriz[5][4] = 178;matriz[5][5]= 2;   matriz[5][6]= 178; matriz[5][7]= 2;
    matriz[6][0]= 2;     matriz[6][1]= 178;   matriz[6][2]= 2;   matriz[6][3] = 178; matriz[6][4] = 2;  matriz[6][5]= 178; matriz[6][6]= 2;   matriz[6][7]= 178;
    matriz[7][0]= 178;   matriz[7][1]= 2;     matriz[7][2]= 178; matriz[7][3] = 2;   matriz[7][4] = 178;matriz[7][5]= 2;   matriz[7][6]= 178; matriz[7][7]= 2;

    do {
      //system("color 47");
      //PERGUNTA OS NOMES DOS JOGADORES DAS DETERMINADAS PECAS....

      printf("\n\t__________________________________________________________\n");
      printf("\t__________________________________________________________\n");
      printf("\t__________________________________________________________\n");
      printf("\t__________________                    ____________________\n");
      printf("\t__________________                    ____________________\n");
      printf("\t__________________   JOGO  DA  DAMA   ____________________\n");
      printf("\t__________________                    ____________________\n");
      printf("\t__________________________________________________________\n");
      printf("\t__________________________________________________________\n");
      printf("\t__________________________________________________________\n\t\t\t\t\t\n");
      printf("\tEscolha uma das op%c%ces abaixo:\n\n",135,228);
      printf("\t%c 1- Jogar.\n\t%c 2- Ajuda.\n\t%c 3- Hist%crico.\n\t%c 4- Sair.\n\n",16,16,16,162,16);
      printf("\tOp%c%co: ", 135, 198);// OS NUMEROS  E PARA COLOCAR  ACENTOS...

      scanf("%d", &opcao_selecionada);//ESCOLHA DA OPCAO DO MENU...
      system("cls");

      switch(opcao_selecionada) {
        case 1:
            //system("color 10");
            desenho();
            printf("\n\n\t\t\tSelecione o modo de jogo:\n");
            printf("\n\t\t\t1- Dois Jogadores.\n\t\t\t2- Jogar contra a maquina.\n\n");
            printf("\n\t\t\tOp%c%co: ", 135, 198);
            scanf("%d", &opcaoDeJogabilidade);
            printf("\n\n\n");
            system("pause");
            system("cls");
            if(opcaoDeJogabilidade == 1){
                //system("color 50");
                // NOME DOS JOGADORES...
                printf("\n\n\t\tINFORME O NOME DO JOGADOR PECA PRETA:\n\n\t\t\t\t");
                scanf("%s",dama.game1);
                printf("\n\n\t\tINFORME O NOME DO JOGADOR PECA BRANCA:\n\n\t\t\t\t ");
                scanf("%s",dama.game2);

                while(dama.pont_max < 12) {
                    jogador = 1; oposto = 2;
                    jogar(matriz, jogador, oposto);
                    jogador = 2; oposto = 1;
                    jogar(matriz, jogador, oposto);
                }
                system("cls");
                desenho4(); // CHAMADA DA FUNCAO DESENHO BONECO.
                // printf("\n\t\t.......... PASSARAM-SE 3 MINUTOS: FIM DO JOGO! ...........\n\n\n"); // APARECE NA TELA QUANDO TERMINA O TEMPO...
                ganhador(matriz); // CHAMADA DA FUNCAO GANHADOR...
                registro(); // CHAMADA DA FUNCAO REGITRO... RESPONSAVEL POR GRAVAR AS INFORMACOES.

                system("pause");
                system("cls");
                break;
            }
            else if(opcaoDeJogabilidade == 2){
                //system("color 50");
                // NOME DOS JOGADORES...
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
                desenho4(); // CHAMADA DA FUNCAO DESENHO BONECO.
                // printf("\n\t\t.......... PASSARAM-SE 3 MINUTOS: FIM DO JOGO! ...........\n\n\n"); // APARECE NA TELA QUANDO TERMINA O TEMPO...
                ganhador(matriz); // CHAMADA DA FUNCAO GANHADOR...
                registro(); // CHAMADA DA FUNCAO REGITRO... RESPONSAVEL POR GRAVAR AS INFORMACOES.

                system("pause");
                system("cls");
                break;
            }
            else{
                printf("\n\n\t\t**********OPCAO DE JOGABILIDADE INVALIDA**********\n\n\t\t\t\t");
                system("pause");
                system("cls");
                break;
            }

        // MOSTRA NA TELA AS INFORMACOES DO JOGO...
        case 2:
            //system("color 90");
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
            //system("color 80");
            desenho2(); // CHAMADA DA FUNCAO DESENHO CAVERA.
            system("pause");
            system("cls");
            escreve(); // CHAMADA DA FUNCAO ESCREVE....LA VAI APARECER NA O ARQUIVO DO JOGO....
            system("pause");
            system("cls");
            break;

        // PARA SAIR DO JOGO...
        case 4:
            //system("color 70");
            desenho3();
            printf("\n\n\n\n\t\t\t  FIM DO JOGO\n\n\n\n\n");
            break;
    }
  } while(opcao_selecionada != 4); // LACO PARA TERMINAR O SWITCH...
      fclose(historico); // FECHAMENTO DO ARQUIVO .....
      system("PAUSE");
  return 0;
}
