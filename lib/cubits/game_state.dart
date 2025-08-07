import 'package:equatable/equatable.dart';
import 'package:jogo_da_memoria/models/game_opcao.dart';
import 'package:jogo_da_memoria/models/game_play.dart';

abstract class GameState extends Equatable {
  const GameState();

  @override
  List<Object?> get props => [];
}

class GameInitial extends GameState {}

class GameInProgress extends GameState {
  final List<GameOpcao> gameCards;
  final int score;
  final GamePlay gamePlay;

  const GameInProgress({
    required this.gameCards,
    required this.score,
    required this.gamePlay,
  });

  @override
  List<Object?> get props => [gameCards, score, gamePlay];

  GameInProgress copyWith({
    List<GameOpcao>? gameCards,
    int? score,
    GamePlay? gamePlay,
  }) {
    return GameInProgress(
      gameCards: gameCards ?? this.gameCards,
      score: score ?? this.score,
      gamePlay: gamePlay ?? this.gamePlay,
    );
  }
}

class GameWon extends GameState {
  final int finalScore;
  final GamePlay gamePlay;

  const GameWon({
    required this.finalScore,
    required this.gamePlay,
  });

  @override
  List<Object?> get props => [finalScore, gamePlay];
}

class GameLost extends GameState {
  final int finalScore;
  final GamePlay gamePlay;

  const GameLost({
    required this.finalScore,
    required this.gamePlay,
  });

  @override
  List<Object?> get props => [finalScore, gamePlay];
}
