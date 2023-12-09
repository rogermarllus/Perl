# Project Development - DOO

Este projeto foi desenvolvido na disciplina de **Desenvolvimento Orientado a Objetos**.

### Autor, Linguagem e Jogo

[Roger Marllus Oliveira Leal](https://github.com/rogermarllus) | Perl | Jogo da Velha.

## Especificações

### Jogo
O Jogo da Velha é um jogo de estratégia simples e divertido, também conhecido como Tic-Tac-Toe. É jogado em um tabuleiro de 3x3, onde dois jogadores se alternam para marcar seus símbolos em células vazias. O objetivo é formar uma linha reta com três símbolos iguais (X ou O) na horizontal, vertical ou diagonal. O jogo é popularmente jogado em papel, mas também pode ser implementado digitalmente. O Jogo da Velha é considerado um dos jogos mais antigos e amplamente conhecidos, sendo uma ótima maneira de desafiar a mente e desfrutar de momentos de entretenimento com amigos e familiares.

### Projeto
Seguindo os conceitos do paradigma de Orientação a Objetos, o Jogo da Velha foi desenvolvido em linguagem Perl, contendo atributos para representar o tabuleiro, placar e jogadores, e métodos para realizar jogadas, verificar vencedores, mostrar e limpar tabuleiro e etc.

## Instruções
Para executar o programa basta abrir o arquivo `main.pl` na raiz do projeto e pressionar o botão **RUN**. Após isso ambos os jogadores devem informar seus nomes.

Para realizar uma jogada o jogador deverá informar primeiro a linha e depois a coluna referente à coordenada de onde deseja marcar, para isso deve-se lembrar que como o tabuleiro é uma matriz, ambos os índices começam com 0.

Usando o guia abaixo idêntico ao informado no arquivo `main.pl` na forma de comentário, os jogadores podem ver as coordenadas mais facilmente no momento do jogo:


``` Perl
#  Guia do Tabuleiro
#    +---+---+---+
#    |0:0|0:1|0:2|
#    +---+---+---+
#    |1:0|1:1|1:2|
#    +---+---+---+
#    |2:0|2:1|2:2|
#    +---+---+---+
```