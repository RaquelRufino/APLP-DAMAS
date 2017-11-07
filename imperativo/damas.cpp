#include <bits/stdc++.h>

using namespace std;


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

void realizaJogada(){
 
    //Recebendo Origem
    printf("\nQual deseja mover?\n\tLinha: ");
    scanf(" %d", &linhaOrigem);
    printf("\tColuna: ");
    scanf(" %d", &colunaOrigem);

    //Recebendo Destino
    printf("\nPara onde deseja mover?\n\tLinha: ");
    scanf(" %d", &linhaDestino);
    printf("\tColuna: ");
    scanf(" %d", &colunaDestino);

    //Inserindo a peça no destino e retirando a peça de origem
    //Somei com 1 pra evitar que pegue a linha e coluna erradas.
    //Se eu digitasse 1, ele pegaria a segunda linha da matriz, que não possui nada.
    tabuleiro[linhaDestino + 1][colunaDestino + 1] = tabuleiro[linhaOrigem + 1][colunaOrigem + 1];
    tabuleiro[linhaOrigem + 1][colunaOrigem + 1] = ' ';
}
 
int main(){
 
 
    while (1 == 1){
      
        exibeTabuleiro();
        realizaJogada();
    }
 
    return 0;
}


