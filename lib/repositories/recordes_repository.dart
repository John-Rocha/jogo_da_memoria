import 'dart:async';

import 'package:hive/hive.dart';
import 'package:jogo_da_memoria/core/constants/constants.dart';
import 'package:jogo_da_memoria/models/game_play.dart';

class RecordesRepository {
  late final Box _recordes;
  late final GamePlay gamePlay;

  Map _recordesRound6 = {};
  Map _recordesNormal = {};

  final _recordesController = StreamController<void>.broadcast();

  Map get recordesRound6 => _recordesRound6;
  Map get recordesNormal => _recordesNormal;

  Stream<void> get recordesStream => _recordesController.stream;

  RecordesRepository() {
    _initRepository();
  }

  _initRepository() async {
    await _initDatabase();
    await loadRecordes();
  }

  _initDatabase() async {
    _recordes = await Hive.openBox('gameRecordes3');
  }

  loadRecordes() {
    _recordesNormal = _recordes.get(Modo.normal.toString()) ?? {};
    _recordesRound6 = _recordes.get(Modo.round6.toString()) ?? {};
    _recordesController.add(null);
  }

  updateRecordes({required GamePlay gamePlay, required int score}) {
    final key = gamePlay.modo.toString();

    if (gamePlay.modo == Modo.normal &&
        (_recordesNormal[gamePlay.nivel] == null ||
            score < _recordesNormal[gamePlay.nivel])) {
      _recordesNormal[gamePlay.nivel] = score;
      _recordes.put(key, _recordesNormal);
      _recordesController.add(null);
    } else if (gamePlay.modo == Modo.round6 &&
        (_recordesRound6[gamePlay.nivel] == null ||
            score > _recordesRound6[gamePlay.nivel])) {
      _recordesRound6[gamePlay.nivel] = score;
      _recordes.put(key, _recordesRound6);
      _recordesController.add(null);
    }

    loadRecordes();
  }

  void dispose() {
    _recordesController.close();
  }
}
