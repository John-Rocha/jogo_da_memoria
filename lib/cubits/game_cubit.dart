import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jogo_da_memoria/core/constants/constants.dart';
import 'package:jogo_da_memoria/cubits/game_state.dart';
import 'package:jogo_da_memoria/game_settings.dart';
import 'package:jogo_da_memoria/models/game_opcao.dart';
import 'package:jogo_da_memoria/models/game_play.dart';
import 'package:jogo_da_memoria/repositories/recordes_repository.dart';

class GameCubit extends Cubit<GameState> {
  final RecordesRepository recordesRepository;

  late GamePlay _gamePlay;
  List<GameOpcao> _escolha = [];
  List<Function> _escolhaCallback = [];
  int _acertos = 0;
  int _numPares = 0;

  GameCubit({required this.recordesRepository}) : super(GameInitial());

  bool get jogadaCompleta => (_escolha.length == 2);

  void startGame({required GamePlay gamePlay}) {
    _gamePlay = gamePlay;
    _acertos = 0;
    _numPares = (_gamePlay.nivel / 2).round();
    final initialScore = _resetScore();
    final gameCards = _generateCards();

    emit(
      GameInProgress(
        gameCards: gameCards,
        score: initialScore,
        gamePlay: _gamePlay,
      ),
    );
  }

  int _resetScore() {
    return _gamePlay.modo == Modo.normal ? 0 : _gamePlay.nivel;
  }

  List<GameOpcao> _generateCards() {
    List<int> cardOpcoes = GameSettings.cardOpcoes.sublist(0)..shuffle();
    cardOpcoes = cardOpcoes.sublist(0, _numPares);
    final gameCards = [...cardOpcoes, ...cardOpcoes]
        .asMap()
        .entries
        .map(
          (entry) => GameOpcao(
            id: 'card_${entry.key}', // ID único baseado no índice
            opcao: entry.value,
            matched: false,
            selected: false,
          ),
        )
        .toList();
    gameCards.shuffle();
    return gameCards;
  }

  Future<void> escolher(GameOpcao opcao, Function resetCard) async {
    if (state is! GameInProgress) return;

    final currentState = state as GameInProgress;

    // Encontra a carta correspondente na lista de estado usando o ID único
    final cardIndex = currentState.gameCards.indexWhere(
      (card) => card.id == opcao.id,
    );

    if (cardIndex == -1) return;

    final selectedCard = currentState.gameCards[cardIndex];

    // Atualiza a carta selecionada
    final updatedCards = currentState.gameCards.map((card) {
      if (card == selectedCard) {
        return GameOpcao(
          id: card.id,
          opcao: card.opcao,
          matched: card.matched,
          selected: true,
        );
      }
      return card;
    }).toList();

    // Adiciona à escolha usando a carta atualizada
    final updatedSelectedCard = updatedCards[cardIndex];
    _escolha.add(updatedSelectedCard);
    _escolhaCallback.add(resetCard);

    emit(currentState.copyWith(gameCards: updatedCards));

    await _compararEscolhas();
  }

  Future<void> _compararEscolhas() async {
    if (!jogadaCompleta || state is! GameInProgress) return;

    final currentState = state as GameInProgress;

    if (_escolha[0].opcao == _escolha[1].opcao) {
      // Acertou
      _acertos++;

      final updatedCards = currentState.gameCards.map((card) {
        if (card == _escolha[0] || card == _escolha[1]) {
          return GameOpcao(
            id: card.id,
            opcao: card.opcao,
            matched: true,
            selected: card.selected,
          );
        }
        return card;
      }).toList();

      _resetJogada();
      final newScore = _updateScore(currentState.score);

      emit(
        currentState.copyWith(
          gameCards: updatedCards,
          score: newScore,
        ),
      );

      await _checkGameResult(newScore);
    } else {
      // Errou
      await Future.delayed(const Duration(seconds: 1), () {
        if (state is GameInProgress) {
          final currentState = state as GameInProgress;

          final updatedCards = currentState.gameCards.map((card) {
            if (card == _escolha[0] || card == _escolha[1]) {
              return GameOpcao(
                id: card.id,
                opcao: card.opcao,
                matched: card.matched,
                selected: false,
              );
            }
            return card;
          }).toList();

          for (var i in [0, 1]) {
            _escolhaCallback[i]();
          }

          _resetJogada();
          final newScore = _updateScore(currentState.score);

          emit(
            currentState.copyWith(
              gameCards: updatedCards,
              score: newScore,
            ),
          );

          _checkGameResult(newScore);
        }
      });
    }
  }

  Future<void> _checkGameResult(int score) async {
    bool allMatched = _acertos == _numPares;
    if (_gamePlay.modo == Modo.normal) {
      await _checkResultModoNormal(allMatched, score);
    } else {
      await _checkResultModoRound6(allMatched, score);
    }
  }

  Future<void> _checkResultModoNormal(bool allMatched, int score) async {
    if (allMatched) {
      await Future.delayed(const Duration(seconds: 1), () {
        recordesRepository.updateRecordes(gamePlay: _gamePlay, score: score);
        emit(GameWon(finalScore: score, gamePlay: _gamePlay));
      });
    }
  }

  Future<void> _checkResultModoRound6(bool allMatched, int score) async {
    if (_chancesAcabaram(score)) {
      await Future.delayed(
        const Duration(milliseconds: 400),
        () => emit(GameLost(finalScore: score, gamePlay: _gamePlay)),
      );
    } else if (allMatched && score >= 0) {
      await Future.delayed(
        const Duration(seconds: 1),
        () {
          recordesRepository.updateRecordes(gamePlay: _gamePlay, score: score);
          emit(GameWon(finalScore: score, gamePlay: _gamePlay));
        },
      );
    }
  }

  bool _chancesAcabaram(int score) {
    return score < _numPares - _acertos;
  }

  void _resetJogada() {
    _escolha = [];
    _escolhaCallback = [];
  }

  int _updateScore(int currentScore) {
    return _gamePlay.modo == Modo.normal ? currentScore + 1 : currentScore - 1;
  }

  void restartGame() {
    startGame(gamePlay: _gamePlay);
  }

  void nextLevel() {
    int nivelIndex = 0;

    if (_gamePlay.nivel != GameSettings.niveis.last) {
      nivelIndex = GameSettings.niveis.indexOf(_gamePlay.nivel) + 1;
    }

    _gamePlay.nivel = GameSettings.niveis[nivelIndex];
    startGame(gamePlay: _gamePlay);
  }
}
