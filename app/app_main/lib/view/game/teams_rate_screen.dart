import 'package:app_core/app_core.dart';
import 'package:app_main/controllers/controllers.dart';
import 'package:app_main/navigation/app_routes.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:core_get_it/core_get_it.dart';

import '../../domain/domain.dart';

class TeamsRateScreen extends StatelessWidget {
  static Widget pageBuilder(
      BuildContext context, PageArgumentsGeneric arguments) {
    return const TeamsRateScreen();
  }

  const TeamsRateScreen({super.key});

  void _initScreen() {
    final IGameService gameService = getWidgetService<IGameService>();
    gameService.setNewScreen(CurrentScreen.rate);
  }

  List<Widget> _getTeamsWidget() {
    final IGameService gameService = getWidgetService<IGameService>();
    List<Team> teams = gameService.teams;
    return teams
        .map(
          (t) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(t.name),
              Text(t.points.toString()),
            ],
          ),
        )
        .toList();
  }

  String get currentTeamName {
    final IGameService gameService = getWidgetService<IGameService>();
    return gameService.currentTeam.name;
  }

  void _navigate(BuildContext context) {
    final AppRoutes appRoutes = getWidgetService<AppRoutes>();
    RootAppNavigation.of(context)
        .pushReplacementWithoutAnimation(appRoutes.gameProcess());
  }

  ///TODO: add localization
  @override
  Widget build(BuildContext context) {
    _initScreen();
    List<Widget> teamsWidgets = _getTeamsWidget();

    return MyAppWrap(
      body: Column(
        children: [
          const Text('Command Rate'),
          Expanded(
            flex: 1,
            child: SingleChildScrollView(
              child: Column(
                children: teamsWidgets,
              ),
            ),
          ),
          Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(currentTeamName),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () => _navigate(context),
                      child: const Text('Go'),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
