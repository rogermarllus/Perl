# Desativando strict e warnings
no strict;
no warnings;

# Definindo a classe JogoDaVelha

package JogoDaVelha;

# Construtor
sub new {
    my $class = shift;
    my $self  = {
        tabuleiro     => [ " ", " ", " ", " ", " ", " ", " ", " ", " " ],
        jogador_X     => { simbolo => "X", nome => "" },
        jogador_O     => { simbolo => "O", nome => "" },
        jogador_atual => "X",    # Inicia com o jogador X
        placar_X      => 0,      # Placar do jogador X
        placar_O      => 0,      # Placar do jogador O
    };
    bless $self, $class;
    return $self;
}

# Método para exibir o tabuleiro
sub mostrar_tabuleiro {
    my $self      = shift;
    my $tabuleiro = $self->{tabuleiro};

    print "+---+---+---+\n";
    for my $i ( 0 .. 2 ) {
        for my $j ( 0 .. 2 ) {
            my $index = $i * 3 + $j;
            print "| $tabuleiro->[$index] ";
        }
        print "|\n+---+---+---+\n";
    }
}

# Função para fazer uma jogada
sub fazer_jogada {
    my ( $self, $linha, $coluna ) = @_;

    my $tabuleiro     = $self->{tabuleiro};
    my $jogador_atual = $self->{jogador_atual};
    my $index         = $linha * 3 + $coluna;

    # Verifica se a posição está vazia
    if ( $tabuleiro->[$index] eq " " ) {
        $tabuleiro->[$index] = $jogador_atual;
        $self->{jogador_atual} =
          ( $jogador_atual eq "X" ) ? "O" : "X";    # Alterna o jogador
        $self->mostrar_tabuleiro();
        if ( $self->verificar_vencedor() ) {
            my $vencedor_nome =
                $jogador_atual eq "X"
              ? $self->{jogador_X}->{nome}
              : $self->{jogador_O}->{nome};
            print "$vencedor_nome ($jogador_atual) venceu!\n";
            $self->atualizar_placar($jogador_atual);
            $self->mostrar_placar();
            return 1;    # Indica que o jogo terminou
        }
        elsif ( $self->verificar_velha() ) {
            print "O jogo empatou!\n";
            $self->mostrar_placar();
            return 1;    # Indica que o jogo terminou em empate
        }
    }
    else {
        print "Posição ocupada. Escolha outra posição.\n";
    }
    return 0;    # Indica que o jogo ainda está em andamento
}

# Método para verificar se há um vencedor
sub verificar_vencedor {
    my $self      = shift;
    my $tabuleiro = $self->{tabuleiro};

    # Verifica linhas, colunas e diagonais
    for my $i ( 0 .. 2 ) {
        if (   $tabuleiro->[ $i * 3 ] ne " "
            && $tabuleiro->[ $i * 3 ] eq $tabuleiro->[ $i * 3 + 1 ]
            && $tabuleiro->[ $i * 3 ] eq $tabuleiro->[ $i * 3 + 2 ] )
        {
            return 1;    # Venceu na linha $i
        }

        if (   $tabuleiro->[$i] ne " "
            && $tabuleiro->[$i] eq $tabuleiro->[ $i + 3 ]
            && $tabuleiro->[$i] eq $tabuleiro->[ $i + 6 ] )
        {
            return 1;    # Venceu na coluna $i
        }
    }

    # Verifica diagonais
    if (   $tabuleiro->[0] ne " "
        && $tabuleiro->[0] eq $tabuleiro->[4]
        && $tabuleiro->[0] eq $tabuleiro->[8] )
    {
        return 1;    # Venceu na diagonal principal
    }

    if (   $tabuleiro->[2] ne " "
        && $tabuleiro->[2] eq $tabuleiro->[4]
        && $tabuleiro->[2] eq $tabuleiro->[6] )
    {
        return 1;    # Venceu na diagonal secundária
    }

    return 0;        # Sem vencedor
}

# Método para verificar se houve "velha" (empate)
sub verificar_velha {
    my $self      = shift;
    my $tabuleiro = $self->{tabuleiro};

    # Verifica se todas as posições foram preenchidas e não há vencedor
    for my $posicao (@$tabuleiro) {
        return 0 if $posicao eq " ";    # Ainda há espaço vazio
    }

  # Se todas as posições estão preenchidas e não há vencedor, é "velha" (empate)
    return 1;
}

# Método para atualizar o placar
sub atualizar_placar {
    my ( $self, $jogador ) = @_;
    if ( $jogador eq "X" ) {
        $self->{placar_X}++;
    }
    elsif ( $jogador eq "O" ) {
        $self->{placar_O}++;
    }
}

# Método para mostrar o placar
sub mostrar_placar {
    my $self           = shift;
    my $jogador_X_nome = $self->{jogador_X}->{nome};
    my $jogador_O_nome = $self->{jogador_O}->{nome};
    print
"Placar: $jogador_X_nome ($self->{jogador_X}->{simbolo}): $self->{placar_X} | ";
    print
      "$jogador_O_nome ($self->{jogador_O}->{simbolo}): $self->{placar_O}\n";
}

# Função para reiniciar o jogo
sub reiniciar_jogo {
    my $self = shift;
    $self->{tabuleiro}     = [ " ", " ", " ", " ", " ", " ", " ", " ", " " ];
    $self->{jogador_atual} = "X";
}

# ===================== MAIN =====================

my $jogo = JogoDaVelha->new();

# Apresentação
print "
     ___  _______  _______  _______    ______   _______    __   __  _______  ___      __   __  _______ 
    |   ||       ||       ||       |  |      | |   _   |  |  | |  ||       ||   |    |  | |  ||   _   |
    |   ||   _   ||    ___||   _   |  |  _    ||  |_|  |  |  |_|  ||    ___||   |    |  |_|  ||  |_|  |
    |   ||  | |  ||   | __ |  | |  |  | | |   ||       |  |       ||   |___ |   |    |       ||       |
 ___|   ||  |_|  ||   ||  ||  |_|  |  | |_|   ||       |  |       ||    ___||   |___ |       ||       |
|       ||       ||   |_| ||       |  |       ||   _   |   |     | |   |___ |       ||   _   ||   _   |
|_______||_______||_______||_______|  |______| |__| |__|    |___|  |_______||_______||__| |__||__| |__|
\n";

# Solicita o nome dos jogadores
print "Informe o nome do Jogador X: ";
$jogo->{jogador_X}->{nome} = <STDIN>;
chomp( $jogo->{jogador_X}->{nome} );

print "Informe o nome do Jogador O: ";
$jogo->{jogador_O}->{nome} = <STDIN>;
chomp( $jogo->{jogador_O}->{nome} );

while (1) {
    $jogo->mostrar_tabuleiro();

    # Loop para jogadas
    while (1) {
        my $jogador_atual_nome =
            $jogo->{jogador_atual} eq "X"
          ? $jogo->{jogador_X}->{nome}
          : $jogo->{jogador_O}->{nome};
        my $jogador_atual_simbolo = $jogo->{jogador_atual};
        print "Jogador atual: $jogador_atual_nome ($jogador_atual_simbolo)\n";
        print "Digite a linha (0-2): ";
        my $linha = <STDIN>;
        chomp($linha);

        print "Digite a coluna (0-2): ";
        my $coluna = <STDIN>;
        chomp($coluna);

        # Verifica se as entradas são válidas
        if ( $linha =~ /^[0-2]$/ && $coluna =~ /^[0-2]$/ ) {
            last
              if $jogo->fazer_jogada( $linha, $coluna )
              ;    # Sai do loop se o jogo terminou
        }
        else {
            print "Entradas inválidas. Digite números de 0 a 2.\n";
        }
    }

    # Pergunta se deseja jogar novamente
    print "Deseja jogar novamente? (s/n): ";
    my $resposta = lc(<STDIN>);
    chomp($resposta);
    last unless $resposta eq 's';

    # Reinicia o jogo para uma nova rodada
    $jogo->reiniciar_jogo();
}

#  Guia do Tabuleiro
#    +---+---+---+
#    |0:0|0:1|0:2|
#    +---+---+---+
#    |1:0|1:1|1:2|
#    +---+---+---+
#    |2:0|2:1|2:2|
#    +---+---+---+
