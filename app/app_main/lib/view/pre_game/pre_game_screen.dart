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
    gameService.setNewScreen(CurrentScreen.preGame);

    Rules rules = _getCurrentRule(gameService);
    return MyAppWrap(
      body: Column(
        children: [
          rules.widget,
          TextButton(
              onPressed: () {
                RootAppNavigation.of(context).pushReplacement(
                  appRoutes.teamsRateScreen(),
                );
              },
              child: const Text('OK')),
        ],
      ),
    );
  }
}
