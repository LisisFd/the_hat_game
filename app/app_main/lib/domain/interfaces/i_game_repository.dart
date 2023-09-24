import '../entities/entities.dart';

abstract class IGameRepository {
  Future<TheHatAppGame?> getGame();

  void setGame(TheHatAppGame? game);
}
