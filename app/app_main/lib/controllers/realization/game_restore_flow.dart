import 'package:app_main/controllers/controllers.dart';
import 'package:app_main/domain/domain.dart';
import 'package:app_main/navigation/app_routes.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:core_get_it/core_get_it.dart';

class GameRestoreFlow extends IGameRestoreFlow {
  late final IGameRepository _gameRepository;
  late final AppRoutes _appRoutes;

  GameRestoreFlow(
      {required IGameRepository gameRepository,
      required super.context,
      required AppRoutes appRoutes}) {
    _appRoutes = appRoutes;
    _gameRepository = gameRepository;
  }

  TheHatAppGame get _appGame => _gameRepository.getGame()!;

  @override
  void restoreGame() {
    FullRouteInfo result = [];
    result = _restoreGame(result);
    RootAppNavigation.of(context).push(result);
  }

  FullRouteInfo _restoreGame(FullRouteInfo result) {
    CurrentScreen currentScreen = _appGame.currentScreen;
    switch (currentScreen) {
      case CurrentScreen.setUp:
        result = _appRoutes.wordsScreen();
      case CurrentScreen.preGame:
        result = _appRoutes.preGameScreen();
      case CurrentScreen.rate:
        result = _appRoutes.teamsRateScreen();
      case CurrentScreen.process:
        result = _appRoutes.gameProcess();
      case CurrentScreen.result:
        result = _appRoutes.teamResult();
    }
    return result;
  }
}

extension GameRestoreFlowFeatureExtension on ServiceScope {
  void addGameRestoreFlowFeature() {
    addFlow<IGameRestoreFlow>(
      (context) => GameRestoreFlow(
        context: context,
        gameRepository: get<IGameRepository>(),
        appRoutes: get<AppRoutes>(),
      ),
    );
  }
}
