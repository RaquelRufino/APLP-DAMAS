#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include <string>
#include <string.h>
#define N 8

using namespace std;

int XDamaL;
int XDamaC;
int ODamaL;
int ODamaC;
char DamaX;
char DamaO;
//Inicia Tabuleiro definindo espaços vazios e peças.
char **intitialize();

//imprime Matriz
void printM(char **M);

//Como o nome da função diz, MOVE A PEÇA e define o momento de comer a peça adversária.
void movePeca(char **M, int i, int j, int lin, int col, char jogador);

//define regras do jogo, como: evitar usar casas fora do tabuleiro, como a peça pode andar e comer.
int step(char **M, int i, int j, int lin, int col, char jogador);

/*
Verifica se o jogo pode ou não continuar
caso as peças acabem ou não possam mais se mover.
*/
int status(char **M);

//Complemento status.
int statusJogador(char **M, char jogador);

/*Função que aplica a lógica do jogo, que alterna a rodada de cada jogador e
que imprime o tabuleiro atualizado a cada rodada.
*/
void game();

char **intitialize() {
  char **M;
  int i, j, k, l;

  // Definindo tamanho do tabuleiro

  M = (char**)calloc(N, sizeof(char*));
  for(i = 0; i < N; i++)
    M[i] = (char*)calloc(N, sizeof(char));

    /*
    posicionando as peças
    X = pretas,
    O = brancas,
    */

  // Lista de coordenadas

  // Peças pretas (X)
  for(i = 0; i < 3; i += 2)
    for(j = 1; j < N ; j += 2)
        M[i][j] = 'X';
  for(j = 0; j < N; j += 2)
      M[1][j] = 'X';

  //Peças brancas (O)
  for(i = 5; i < N; i+=2)
    for(j = 0; j < N; j+=2)
      M[i][j] = 'O';
  for(j = 1; j < N; j+=2)
      M[6][j] = 'O';

  // Espaços vazios entre as peças pretas
  for(i = 0; i < 3; i += 2)
    for(j = 0; j < N; j += 2)
      //M[i][j] = ' ';
      M[i][j] = 178;
  for(j = 1; j < N; j+=2)
    //M[1][j] = ' ';
      M[1][j] = 178;

  // Espaços vazios entre as peças brancas
  for(i = 5; i < N; i+=2)
    for(j = 1; j < N; j+=2)
      //M[i][j] = ' ';
        M[i][j] = 178;
  for(j = 0; j < N; j+=2)
    //M[6][j] = ' ';
      M[6][j] = 178;

  // Demais espaços vazios
  for (i = 1; i < N; i += 2)
    M[3][i] = 178;

  for (j = 0; j < N; j+=2)
    M[4][j] = 178;

  return M;
}

void printM(char **M) {

  int i, j;

  /*printf("  1  2  3  4  5  6  7  8\n");
  for(i=0;i<N;i++){
    printf("%d",i+1);
    for(j=0; j<N; j++){
            printf("[%c]",M[i][j]);
        }

      printf("\n");

  } */

    printf("\t \t\t   1 2 3 4 5 6 7 8 \n");// COORDENADAS DO TABULEIRO

    // DESENHO DO TABULEIRO, MATRIZ E OS INDICES...
    for(i = 0; i < N; i++) {
        printf("\n\t\t\t%d  ", i+1);

        for(j = 0; j < N; j++)
            printf("%c ", M[i][j]);
    }

    printf("\n");
}

int DamaVerifica(int i, int j,int lin,int col,char jogador) {

    if ((jogador == 'X' && i == 7) || (XDamaL == i && XDamaC == j)){
        return 1;
    }
    if ((jogador =='O' && i == 0) || (ODamaL == i && ODamaC == j)){
        return 1;
    }

    if (jogador == 'X' && lin == 7) {
        return 2;
    }
    if (jogador =='O' && lin == 0) {
        return 2;
    }

    return 0;


}

int step(char **M, int i, int j, int lin, int col, char jogador) {


  int VDama;
  VDama = DamaVerifica(i, j, lin, col, jogador);

  // Limitando tabuleiro. - Funcionando.
  if(lin < 0 || lin >= N || col < 0 || col >= N)
        return 0;
  // Checando se a peça que está na casa escolhida é a o jogador. -Funcionando.
    if(M[i][j] != jogador)
      return 0;

  //Peças Brancas.
  // Proibindo peças de andarem para trás e para os lados. -Funcionando.
    if(jogador == 'O'){
      if(lin >= i && (VDama==0 || VDama==2))
        return 0;

    // Proibindo peças de andar para frente.
      if(col == j)
        return 0;

      // Permitindo avançar apenas 1 casa ou avançar 2 no caso da ação "COMER".
      if (VDama == 0 || VDama == 2 ) {

        if (lin <= i - 2 || col <= j-2 || col >= j+2){
          if (M[lin][col] == 'X')
            return 0;

          if (M[lin+1][col-1] == 'X')
            return 1;
          else if (M[lin+1][col+1] == 'X')
            return 1;
          else
            return 0;
          if (M[lin][col] == 'X')
          return 0;
        }
      }
      //Não permitindo peça sobrepor peça adversária.
      if (M[lin][col] == 'O' || M[lin][col] == 'X')
          return 0;

      if (VDama==1) {
        ODamaL = lin;
        ODamaC = col;
      }
    }

  // Peças Pretas.
  // Proibindo peças de andarem para trás e para os lados. -Funcionando.
    if (jogador == 'X') {
      if(lin <= i && (VDama==0 || VDama==2))
        return 0;

    //Proibindo peças de andar para frete.
      if(col == j)
        return 0;

      if (VDama == 0 || VDama == 2) {
        //Permitindo avançar apenas 1 casa ou avançar 2 no caso da ação "COMER"
        if(lin <= i - 2 || col <= j-2 || col >= j+2){
          if(M[lin][col] == 'O')
            return 0;

          if(M[lin-1][col-1] == 'O')
            return 1;
          else if (M[lin-1][col+1] == 'O')
            return 1;
          else
            return 0;
        }
      }
      //Não permitindo peça sobrepor peça adversária.
      if(M[lin][col] == 'O' || M[lin][col] == 'X')
          return 0;

      if (VDama==1) {
        XDamaL= lin;
        XDamaC= col;
      }

    }

  M[i][j] = jogador;

  return 1;
}

int statusJogador(char **M, char jogador){
  int i;
  for(i = 0; i < N; i++)
    if (M[i][0] == jogador || M[i][1] == jogador || M[i][2] == jogador || M[i][3] == jogador ||
      M[i][4] == jogador || M[i][5] == jogador || M[i][6] == jogador || M[i][7] == jogador)
        return 1;
  return 0;
}

int status(char **M) {

  /* -1 = Jogo continua
      0 = Brancas ganham.
      1 = Pretas ganham.
  */

  if(statusJogador(M, 'O'))
    return -1;
  else
    return 0;

  if(statusJogador(M, 'P'))
    return -1;
  else
    return 1;

}

void movePeca(char **M, int i, int j, int lin, int col, char jogador){

  int VDama;

  VDama = DamaVerifica(i,j,lin,col,jogador);

  if (VDama==2) {
    if (jogador=='X') {
      M[lin][col] = 'Z';
    } else {
      M[lin][col] = 'P';
    }
  } else {
    M[lin][col] = M[i][j];
  }

  M[i][j] = ' ';

  //Come peça.
  if (jogador == 'O') {

    if (VDama==0) {

      if (lin == i - 2 && col == j-2) {
        if (M[lin+1][col+1] == 'X')
          M[lin+1][col+1] = ' ';
      } else if (col == j+2 && lin == i - 2) {
        if (M[lin+1][col-1] == 'X')
          M[lin+1][col-1] = ' ';
      }
    } else {

      if (lin < i && col < j) {
        if(M[lin+1][col+1] == 'X')
          M[lin+1][col+1] = ' ';
      }

      if (lin < i && col > j) {
        if(M[lin+1][col-1] == 'X')
          M[lin+1][col-1] = ' ';
      }

      if (lin>i && col >j) {
        if(M[lin-1][col-1] == 'X')
          M[lin-1][col-1] = ' ';
      }

      if (lin > i && col < j) {
        if(M[lin-1][col+1] == 'X')
          M[lin-1][col+1] = ' ';
      }

    }

  }

  if(jogador == 'X'){

    if (VDama==0){
      if(lin == i + 2 && col == j-2){
        if(M[lin-1][col+1] == 'O')
          M[lin-1][col+1] = ' ';
      }else if (col == j+2 && lin == i + 2){
        if(M[lin-1][col-1] == 'O')
          M[lin-1][col-1] = ' ';
      }

    }else {

      if (lin < i && col < j){
        if(M[lin+1][col+1] == 'O')
          M[lin+1][col+1] = ' ';
      }

      if (lin < i && col > j){
        if(M[lin+1][col-1] == 'O')
          M[lin+1][col-1] = ' ';
      }

      if (lin>i && col >j){
        if(M[lin-1][col-1] == 'O')
          M[lin-1][col-1] = ' ';
      }

      if (lin > i && col < j){
        if(M[lin-1][col+1] == 'O')
          M[lin-1][col+1] = ' ';
      }
    }
  }
}

void game() {
  char **M;
  char **tabuleiro;
  char jogador = 'O';
  // Escolhe a peça
  int i, j;
  //escolhe a casa
  int lin, col;
  char msg[][20]={"Ocorreu um empate!","Jogador O venceu!","Jogador 'X' venceu!"};

  intitialize();

  tabuleiro = intitialize();

  int jogoAtivo = -1;

  // Loop jogo
  while(jogoAtivo == -1) {

    system("cls");

    if (jogador == 'O')// JOGADOR PECA BRANCA
       printf("\n\n----------------    A VEZ EH A DO JOGADOR PECA BRANCA  ----------\n\n\n\n");
    if (jogador == 'X')// JOGADOR PECA PRETA
       printf("\n\n----------------    A VEZ EH A DO JOGADOR PECA PRETA  ------------\n\n\n\n");

    // Imprime o tabuleiro
    printM(tabuleiro);

    printf("\n\n\n\n\tJogador %c, digite as coordenadas da peca que deseja selecionar...\n", jogador);

    printf("\n\tLINHA: ");
    scanf("%d", &i);
    printf("\n\tCOLUNA: ");
    scanf("%d", &j);

    printf("\n\tEscolha a casa para qual a peca deverah se mover: \n");

    printf("\n\tLINHA: ");
    scanf("%d", &lin);
    printf("\n\tCOLUNA: ");
    scanf("%d", &col);

    // Se nao posso prosseguir
    if (!step(tabuleiro, i-1, j-1, lin-1, col-1, jogador) ){
        printf("\nMovimento invalido! Tente novamente...\n");
        continue;
    }

    movePeca(tabuleiro,i-1, j-1, lin-1, col-1, jogador);
    jogoAtivo = status(tabuleiro);

    // Alternando jogadores.
    if (jogador == 'O')
        jogador = 'X';
    else
        jogador = 'O';
  }
  printf("\n%s\n", msg[jogoAtivo]);
}

int main(void) {

    int opcao_selecionada;
    int opcao_jogabilidade;
    int pontuacao_maxima;
    string jogador_peca_preta;
    string jogador_peca_branca;

    do {

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
        printf("\t%c 1- Jogar.\n\t%c 2- Ajuda.\n\t%c 3- Sair.\n\n",16,16,16,162,16);
        printf("\tOp%c%co: ", 135, 198);// OS NUMEROS  E PARA COLOCAR  ACENTOS...

        // RECEBENDO A OPCAO DO USUÁRIO...
        cin >> opcao_selecionada;
        system("cls");

        switch(opcao_selecionada) {

        case 1:

            printf("\n\n\t\t\tSelecione o modo de jogo:\n");
            printf("\n\t\t\t1- Dois Jogadores.\n\t\t\t2- Jogar contra a maquina.\n\n");
            printf("\n\t\t\tOp%c%co: ", 135, 198);

            // RECEBENDO O TIPO DE JOGABILIDADE...
            cin >> opcao_jogabilidade;

            printf("\n\n\n");
            //system("pause");
            system("cls");

            if (opcao_jogabilidade == 1) {
                // NOME DOS JOGADORES...
                printf("\n\n\t\tINFORME O NOME DO JOGADOR DE PECAS BRANCAS:\n\n\t\t\t\t");
                cin >> jogador_peca_branca;
                printf("\n\n\t\tINFORME O NOME DO JOGADOR DE PECAS PRETAS:\n\n\t\t\t\t ");
                cin >> jogador_peca_preta;

                // LACO AQUI
                game();

                system("pause");
                system("cls");
                break;

            } else if (opcao_jogabilidade == 2) {
                // NOME DOS JOGADORES...
                printf("\n\n\t\tINFORME O NOME DO JOGADOR DE PECAS BRANCAS:\n\n\t\t\t\t");
                cin >> jogador_peca_preta;

                printf("\n\n\t\tNOME DO JOGADOR DE PECAS PRETAS:\n\n\t\t\t\t ");
                jogador_peca_branca = "PC-GAMER";
                printf("\n\n\t\tPC-GAMER\n\n\t\t\t\t");

                // game_with_pc();

                system("pause");
                system("cls");
                break;
            } else {
                printf("\n\n\t\t********** OPCAO DE JOGABILIDADE INVALIDA! **********\n\n\t\t\t\t");
                system("pause");
                system("cls");

                // CORRIGIR AQUI!!!

                break;
            }

        // MOSTRA NA TELA AS INFORMACOES DO JOGO...
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

        // PARA SAIR DO JOGO...
        case 3:
            printf("\n\n\n\n\t\t\t\tFIM DO JOGO\n\n\n\n\n");
            break;
        }
    } while (opcao_selecionada != 3);
    //system("PAUSE");
    return 0;
}
