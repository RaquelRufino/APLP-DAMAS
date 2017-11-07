#include <bits/stdc++.h>

using namespace std;

struct estrutura{//ESTRUTURA PARA ARMAZENAR OS DADOS QUE SERAM COLOCADOS NO ARQUIVO
       char game1[20], game2[20], ganhador[20];//NOMES DOS JOGADORES E GANHADOR
       int cont1, cont2, pont_max;//CONTADORES DAS PECAS E MAIOR NUMERO DE PECAS
       } dama;


char tabuleiro[10][10] = {
                    {' ', '1', '2', '3', '4', '5', '6', '7', '8', ' '},
                    {'1', 'P', ' ', 'P', ' ', 'P', ' ', 'P', ' ', ' '},
                    {'2', ' ', 'P', ' ', 'P', ' ', 'P', ' ', 'P', ' '},
                    {'3', 'P', ' ', 'P', ' ', 'P', ' ', 'P', ' ', ' '},
                    {'4', ' ', 'X', ' ', 'X', ' ', 'X', ' ', 'X', ' '},
                    {'5', 'X', ' ', 'X', ' ', 'X', ' ', 'X', ' ', ' '},
                    {'6', ' ', 'B', ' ', 'B', ' ', 'B', ' ', 'B', ' '},
                    {'7', 'B', ' ', 'B', ' ', 'B', ' ', 'B', ' ', ' '},
                    {'8', ' ', 'B', ' ', 'B', ' ', 'B', ' ', 'B', ' '},
                    {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}
                    };


int x, y;

int linhaOrigem, colunaOrigem, linhaDestino, colunaDestino;


void exibeTabuleiro()
{
    for (x = 0; x <= 9; x++)
    {
        for (y = 0; y <= 9; y++)
        {
            printf("%c ", tabuleiro[x][y]);
        }
        printf("\n");
    }

}

void jogador1(char tabuleiro[10][10], int jogador, int oposto)//FUNCAO TABULEIRO  E  JOGADORES 
  {

  int i,j,l,c,li,co,opcao=0;
  
  do // Laço do jogo da dama
  {
    
    if(jogador == 1)

       printf("\n\n----------------    A VEZ É A DO JOGADOR PEÇA BRANCA  ----------\n\n\n\n");

    if(jogador == 2)

       printf("\n\n----------------    A VEZ É A DO JOGADOR PEÇA PRETA  ------------\n\n\n\n");
       printf("\t \t\t   1 2 3 4 5 6 7 8 \n");//DCOORDENADAS DO TABULEIRO
   
    exibeTabuleiro();

  printf("\n\n\t***************  CORDENADA DA PEÇA  **********************");//ESCOLHE A PECA QUE VAI JOGAR 
  printf("\n\tLINHA: ");
  scanf("%d", &l);
  printf("\n\tCOLUNA: ");
  scanf("%d", &c);
  
  printf("\n\n\t****COORDENADA DA POSIÇÃO QUE A PEÇA VAI OCUPAR****");//PRA ONDE  A PECA VAI ..A POCISAO
  printf("\n\tLINHA: ");
  scanf("%d",&li);
  printf("\n\tCOLUNA: ");
  scanf("%d",&co);

  if((li+co) % 2 ==0)// condição só anda quando os indíces forem pares
  {
     // Faz com que a peça ande só uma casa... e jogue um de cada vez(preta ou branca) 
     if((jogador == 1 && l < li) || (jogador == 2 && l > li))
     {
        printf("linha\n");
        // condições para comer uma peça
        if(c - 1 == co || c + 1 == co)
        {
                        if(co == c-1)
                        {
                        tabuleiro[li][co] = jogador;
                        tabuleiro[l][c] = 0;
                        opcao++;
                        }
                        if(co==c+1)
                        {
                        tabuleiro[li][co] = jogador;
                        tabuleiro[l][c] = 0;
                        opcao++;
                        }
        }

        if(tabuleiro[l+1][c+1]==oposto)
        {
                        if(c+2==co)
                        {
                                 tabuleiro[li][co] = jogador;
                                 tabuleiro[l][c] = 0;
                                 opcao++;
                                 tabuleiro[l+1][c+1]=0;
                        }
        }
        
        if(tabuleiro[l+1][c-1]==oposto)
        {
                        if(c-2==co)
                        {
                                 tabuleiro[li][co] = jogador;
                                 tabuleiro[l][c] = 0;
                                 tabuleiro[l+1][c-1]=0;
                                 opcao++;
                        }
        }
  
        if(tabuleiro[l-1][c+1]==oposto)
        {
                        if(c+2==co)
                        {
                                 tabuleiro[li][co] = jogador;
                                 tabuleiro[l][c] = 0;
                                 opcao++;
                                 tabuleiro[l-1][c+1]=0;
                        }
        }
        
        if(tabuleiro[l-1][c-1]==oposto)
        {
                        if(c-2==co)
                        {
                                tabuleiro[li][co] = jogador;
                                tabuleiro[l][c] = 0;
                                tabuleiro[l-1][c-1]=0;
                                opcao++;
                        }
        }
  }
  // caso essa um movimento inválido
  else printf("\n\n\t\t__________MOVIMENTO INVÁLIDO!!_________\n\t\t_________JOGUE NOVAMENTE________\n");
  }
 
  }while(opcao!=1);
}

 
int main(){

    int i,j, jogador = 2,oposto = 1,opcao = 0, opcao2;
    dama.cont1 = dama.cont2 = 0;

    do{
   
    // início do jogo
    
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
    printf("\tEscolha uma das opções abaixo:\n\n");
    printf("\t 1 Jogar.\n\t 2 Ajuda.\n\t 3 Sair.\n\n");
    printf("\tOpção: ");
    scanf("%d",&opcao2); // escolher a opção do menu
    system("cls");
    switch(opcao2){

                case 1:

                     
                     // informar o nome dos jogadores
                     printf("\n\n\t\tINFORME O NOME DO JOGADOR PECA PRETA:\n\n\t\t\t\t"); 
                     scanf("%s",dama.game1);
                     printf("\n\n\t\tINFORME O NOME DO JOGADOR PECA BRANCA:\n\n\t\t\t\t "); 
                     scanf("%s",dama.game2);
                     
                     
                     //contar o tempo em segundo
                     int tempo = clock();
                      while(clock()-tempo<5000)
                      {
                                               
                      jogador = 1; oposto = 2;
                      jogador1(tabuleiro,jogador,oposto);
                      jogador = 2; oposto = 1;
                      jogador1(tabuleiro,jogador,oposto);
                      }
                     system("cls");

                     
                     printf("\n\t\t..........PASSARAM 3 MINUTOS FIM DO JOGO...........\n\n\n"); // aparece na tela quando expira o tempo

                 
                     printf("\n\n\n\n\t\t\t FIM DO JOGO\n\n\n\n\n");
                     break;
    }
  }while(opcao2!=4); //LACO PARA TERMINAR O SWITCH...

 
    return 0;
}


