import 'package:app_core/app_core.dart';
import 'package:app_main/controllers/controllers.dart';
import 'package:app_main/localization.dart';
import 'package:app_main/navigation/app_routes.dart';
import 'package:app_main/view/view.dart';
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

  List<Widget> _getTeamsWidget(BuildContext context) {
    final theme = MyAppTheme.of(context).material;
    final IGameService gameService = getWidgetService<IGameService>();
    List<Team> teams = gameService.teams;

    return teams
        .map(
          (t) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  t.name,
                  style: theme.textTheme.titleLarge
                      ?.copyWith(color: ThemeConstants.lightBackground),
                ),
              ),
              Text(
                t.points.toString(),
                style: theme.textTheme.titleLarge
                    ?.copyWith(color: ThemeConstants.lightBackground),
              ),
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

  @override
  Widget build(BuildContext context) {
    _initScreen();

    final localization = context.localization();
    final theme = MyAppTheme.of(context);
    final screen = MediaQuery.of(context).size;
    List<Widget> teamsWidgets = _getTeamsWidget(context);

    return MyAppWrap(
      appBar: AppBar(
        title: Text(
          localization.title_command_rate,
          style: const TextStyle(color: ThemeConstants.lightBackground),
        ),
        iconTheme: const IconThemeData(color: ThemeConstants.lightBackground),
        backgroundColor: ColorPallet.colorBlue,
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: const BoxDecoration(
                color: ColorPallet.colorBlue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
            constraints: BoxConstraints(maxHeight: screen.height / 8),
            padding: EdgeInsets.symmetric(
                horizontal: theme.custom.defaultAppPadding.horizontal),
            child: Scrollbar(
              child: SingleChildScrollView(
                child: Column(
                  children: teamsWidgets,
                ),
              ),
            ),
          ),
          DefaultContainer(
            padding: theme.custom.defaultAppPadding,
            margin: theme.custom.defaultAppMargin,
            child: Column(
              children: [
                Text(
                  localization.title_ready,
                  style: theme.material.textTheme.titleSmall
                      ?.copyWith(color: Colors.grey),
                ),
                Text(currentTeamName,
                    textAlign: TextAlign.center,
                    style: theme.material.textTheme.titleMedium
                        ?.copyWith(color: ColorPallet.colorBlue)),
              ],
            ),
          ),
          ElevatedMenuButton(
            lightStyle: false,
            onPressed: () => _navigate(context),
            child: Text(localization.btn_next),
          ),
        ],
      ),
    );
  }
}
