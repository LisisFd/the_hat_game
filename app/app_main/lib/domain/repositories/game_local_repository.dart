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
    return await _storage.read(_storageKeyGame, TheHatAppGame.fromJson);
  }

  @override
  void setGame(TheHatAppGame game) async {
    await _storage.write(_storageKeyGame, game);
  }
}
