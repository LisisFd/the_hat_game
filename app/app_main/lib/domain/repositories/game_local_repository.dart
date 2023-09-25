import 'dart:developer';

import 'package:app_main/domain/interfaces/i_game_repository.dart';
import 'package:core_storage/storage/storage.dart';

import '../entities/entities.dart';

class GameLocalRepository extends IGameRepository {
  static const String _storageKeyGame = "current.game";
  late final IKeyValueStorage _storage;

  GameLocalRepository({
    required IKeyValueStorage storage,
  }) {
    _storage = storage;
  }

  @override
  Future<TheHatAppGame?> getGame() async {
    TheHatAppGame? game;
    try {
      game = await _storage.read(_storageKeyGame, TheHatAppGame.fromJson);
    } catch (e) {
      log('Invalid reading game operation');
    }
    return game;
  }

  @override
  void setGame(TheHatAppGame? game) async {
    if (game == null) {
      await _storage.removeFromKey(_storageKeyGame);
    } else {
      await _storage.write(_storageKeyGame, game);
    }
  }
}
