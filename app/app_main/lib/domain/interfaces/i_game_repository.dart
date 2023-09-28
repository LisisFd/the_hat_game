import '../entities/entities.dart';

abstract class IGameRepository {
  TheHatAppGame? getGame();

  void setGame(TheHatAppGame? game);
}
