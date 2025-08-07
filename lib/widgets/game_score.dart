import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jogo_da_memoria/core/constants/constants.dart';
import 'package:jogo_da_memoria/cubits/game_cubit.dart';
import 'package:jogo_da_memoria/cubits/game_state.dart';

class GameScore extends StatelessWidget {
  final Modo modo;
  const GameScore({super.key, required this.modo});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              modo == Modo.round6 ? Icons.my_location : Icons.touch_app_rounded,
            ),
            const SizedBox(width: 10),
            BlocBuilder<GameCubit, GameState>(
              builder: (context, state) {
                int score = 0;
                if (state is GameInProgress) {
                  score = state.score;
                } else if (state is GameWon) {
                  score = state.finalScore;
                } else if (state is GameLost) {
                  score = state.finalScore;
                }
                return Text(
                  score.toString(),
                  style: const TextStyle(fontSize: 25),
                );
              },
            ),
          ],
        ),
        Image.asset('images/host.png', width: 38, height: 60),
        TextButton(
          child: const Text('Sair', style: TextStyle(fontSize: 18)),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
  }
}
