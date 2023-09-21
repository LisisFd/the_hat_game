import 'package:app_core/app_core.dart';
import 'package:app_main/controllers/controllers.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:core_get_it/core_get_it.dart';

import '../../domain/domain.dart';

class TeamsRateScreen extends StatelessWidget {
  static Widget pageBuilder(
      BuildContext context, PageArgumentsGeneric arguments) {
    return TeamsRateScreen();
  }

  final IGameService _gameService = getWidgetService<IGameService>();

  List<Team> get _teams => _gameService.teams;

  TeamsRateScreen({super.key});

  ///TODO: add localization
  @override
  Widget build(BuildContext context) {
    List<Widget> teamsWidgets = _teams
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

    return MyAppWrap(
      body: Column(
        children: [
          const Text('Comand Rate'),
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
                  Text(_gameService.currentTeam.name),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ElevatedButton(
                      onPressed: () {},
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
