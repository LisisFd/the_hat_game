import 'package:app_core/app_core.dart';
import 'package:app_main/controllers/controllers.dart';
import 'package:app_main/domain/domain.dart';
import 'package:app_main/navigation/navigation.dart';
import 'package:app_main/view/view.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:core_get_it/core_get_it.dart';

class PreGameScreen extends StatelessWidget {
  const PreGameScreen({super.key});

  static Widget pageBuilder(
      BuildContext context, PageArgumentsGeneric arguments) {
    return const PreGameScreen();
  }

  Rules _getCurrentRule(IGameService gameService) {
    Rules result = Rules.alias;
    Lap? lap = gameService.currentLap;
    if (lap != null) {
      switch (lap) {
        case Lap.first:
          result = Rules.alias;
          break;
        case Lap.second:
          result = Rules.oneWord;
          break;
        case Lap.third:
          result = Rules.crocodile;
          break;
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final AppRoutes appRoutes = getWidgetService<AppRoutes>();
    final IGameService gameService = getWidgetService<IGameService>();
    if (gameService.appGame.value?.currentScreen != CurrentScreen.preGame) {
      gameService.updateGame(newScreen: CurrentScreen.preGame);
      gameService.saveGame();
    }

    Rules rules = _getCurrentRule(gameService);
    return MyAppWrap(
      body: Column(
        children: [
          rules.widget,
          TextButton(
              onPressed: () {
                RootAppNavigation.of(context).pushReplacement(
                  appRoutes.gameProcess(),
                );
              },
              child: const Text('OK')),
        ],
      ),
    );
  }
}
