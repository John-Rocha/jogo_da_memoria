import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jogo_da_memoria/core/constants/constants.dart';
import 'package:jogo_da_memoria/cubits/game_cubit.dart';
import 'package:jogo_da_memoria/cubits/game_state.dart';
import 'package:jogo_da_memoria/game_settings.dart';
import 'package:jogo_da_memoria/models/game_opcao.dart';
import 'package:jogo_da_memoria/models/game_play.dart';
import 'package:jogo_da_memoria/widgets/card_game.dart';
import 'package:jogo_da_memoria/widgets/feedback_game.dart';
import 'package:jogo_da_memoria/widgets/game_score.dart';

class GamePage extends StatelessWidget {
  final GamePlay gamePlay;

  const GamePage({super.key, required this.gamePlay});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GameScore(modo: gamePlay.modo),
      ),
      body: BlocBuilder<GameCubit, GameState>(
        builder: (context, state) {
          if (state is GameWon) {
            return const FeedbackGame(resultado: Resultado.aprovado);
          } else if (state is GameLost) {
            return const FeedbackGame(resultado: Resultado.eliminado);
          } else if (state is GameInProgress) {
            return Center(
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: GameSettings.gameBoardAxisCount(gamePlay.nivel),
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                padding: const EdgeInsets.all(24),
                children: state.gameCards
                    .map(
                      (GameOpcao go) =>
                          CardGame(modo: gamePlay.modo, gameOpcao: go),
                    )
                    .toList(),
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
