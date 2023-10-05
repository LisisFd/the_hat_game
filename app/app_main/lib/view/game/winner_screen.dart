import 'package:app_core/app_core.dart';
import 'package:app_main/controllers/controllers.dart';
import 'package:app_main/localization.dart';
import 'package:app_main/navigation/app_routes.dart';
import 'package:app_main/view/view.dart';
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

  @override
  Widget build(BuildContext context) {
    final localization = context.localization();
    final theme = MyAppTheme.of(context);
    final IGameService gameService = getWidgetService<IGameService>();
    final ISettingService settingService = getWidgetService<ISettingService>();
    bool skipAnimation = !settingService.appSettings.value.animation;
    List<Team> teams = gameService.teams.toList();

    teams.sort((t, t2) => t2.points.compareTo(t.points));
    final Team winnerTeam = teams.removeAt(0);
    _removeGame();

    return MyAppWrap(
      appBar: AppBar(
        title: Text(localization.title_winner),
        centerTitle: true,
      ),
      body: Column(
        children: [
          DefaultContainer(
            padding: theme.custom.defaultAppPadding,
            child: Column(
              children: [
                WinnerAnimationWidget(
                  size: 300,
                  skipAnimation: skipAnimation,
                ),
                Text(
                  winnerTeam.name,
                  style: theme.material.textTheme.headlineLarge,
                ),
                Text(
                  winnerTeam.points.toString(),
                  style: theme.material.textTheme.headlineLarge,
                ),
              ],
            ),
          ),
          theme.custom.padding3,
          Expanded(
            child: ListView.builder(
              itemCount: teams.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Material(
                        elevation: 3,
                        child: Padding(
                          padding: theme.custom.defaultAppPadding / 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                teams[index].name,
                                style: theme.material.textTheme.titleMedium,
                              ),
                              Text(
                                teams[index].points.toString(),
                                style: theme.material.textTheme.titleMedium,
                              ),
                            ],
                          ),
                        )),
                    if (index != teams.length - 1)
                      ColoredBox(
                        color: theme.custom.primaryColor.withOpacity(0),
                        child: const SizedBox(
                          width: double.infinity,
                          height: 7,
                        ),
                      )
                    else
                      const SizedBox(
                        height: 20,
                      ),
                  ],
                );
              },
            ),
          ),
          ElevatedMenuButton(
              onPressed: () => _navigateToMenu(context),
              child: Text(localization.btn_menu))
        ],
      ),
    );
  }
}
