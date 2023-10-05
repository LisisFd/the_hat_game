import 'package:app_core/app_core.dart';
import 'package:app_main/controllers/controllers.dart';
import 'package:app_main/localization.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:core_get_it/core_get_it.dart';

import '../../domain/domain.dart';

class TeamsDialog {
  TeamsDialog._();

  static Future<Team> show(BuildContext context) async {
    bool canPop = false;
    final localization = context.localization();
    final theme = MyAppTheme.of(context);
    final IGameService gameService = getWidgetService<IGameService>();
    final double height = MediaQuery.of(context).size.height;
    List<Team> teams = gameService.teams;
    Team team = const Team(name: 'null');
    List<Widget> teamWidgets = teams
        .map((t) => InkWell(
              onTap: () {
                canPop = true;
                team = t;
                Navigator.of(context).pop();
              },
              child: Text(
                t.name,
                style: theme.material.textTheme.titleSmall,
              ),
            ))
        .toList();
    await showDialog<Team?>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => canPop,
          child: AlertDialog(
            title: Text(localization.title_team_word),
            content: Container(
              constraints: BoxConstraints(maxHeight: height / 9),
              width: double.maxFinite,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    return teamWidgets[i];
                  },
                  separatorBuilder: (context, i) {
                    if (teamWidgets.length - 1 == i) {
                      return const SizedBox.shrink();
                    } else {
                      return const SizedBox(
                        height: 2,
                        width: double.infinity,
                        child: ColoredBox(
                          color: Colors.black38,
                        ),
                      );
                    }
                  },
                  itemCount: teamWidgets.length),
            ),
          ),
        );
      },
    );
    return team;
  }
}
