import 'package:app_core/app_core.dart';
import 'package:app_main/controllers/controllers.dart';
import 'package:app_main/navigation/app_routes.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:core_get_it/core_get_it.dart';

import '../../domain/domain.dart';

class WinnerScreen extends StatelessWidget {
  const WinnerScreen({super.key});

  static Widget pageBuilder(
      BuildContext context, PageArgumentsGeneric arguments) {
    return const WinnerScreen();
  }

  void _removeGame() {
    final IGameService gameService = getWidgetService<IGameService>();
    gameService.deleteGame();
  }

  void _navigateToMenu(BuildContext context) {
    final AppRoutes appRoutes = getWidgetService<AppRoutes>();
    RootAppNavigation.of(context)
        .pushReplacementWithoutAnimation(appRoutes.mainScreen());
  }

  ///TODO addLocalization
  @override
  Widget build(BuildContext context) {
    final IGameService gameService = getWidgetService<IGameService>();
    List<Team> teams = gameService.teams.toList();
    teams.sort((t, t2) => t2.points.compareTo(t.points));
    final Team winnerTeam = teams.removeAt(0);
    List<Widget> teamsWidgets = teams.map((t) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(t.name),
          Text(t.points.toString()),
        ],
      );
    }).toList();
    _removeGame();

    return MyAppWrap(
      body: Column(
        children: [
          const Text('Winner'),
          Text(winnerTeam.name),
          Text(winnerTeam.points.toString()),
          SingleChildScrollView(
            child: Column(
              children: teamsWidgets,
            ),
          ),
          TextButton(
              onPressed: () => _navigateToMenu(context),
              child: const Text('Menu'))
        ],
      ),
    );
  }
}
