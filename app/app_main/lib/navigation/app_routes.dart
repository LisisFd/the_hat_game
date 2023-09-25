import 'package:core_flutter/core_flutter.dart';
import 'package:core_get_it/core_get_it.dart';

import '../view/view.dart';

class _RouteUrl {
  static const String main = "/main";
  static const String settings = "/settings";
  static const String rules = "/rules";
  static const String teams = "/set-up/teams";
  static const String words = "/set-up/words";
  static const String preGame = "/pre-game";
  static const String teamsRate = "/teams-rate";
  static const String gameProcess = "/game-process";
  static const String teamResult = "/team-result";
  static const String winner = "/winner";
}

class AppRoutes extends IRouteNavigationBuilder {
  final RootAppNavigation router;

  AppRoutes(
    this.router,
  );

  FullRouteInfo mainScreen() {
    return [
      const RouteArgument(
        _RouteUrl.main,
      )
    ];
  }

  FullRouteInfo settingsScreen() {
    return [
      const RouteArgument(
        _RouteUrl.settings,
      )
    ];
  }

  FullRouteInfo rulesScreen() {
    return [
      const RouteArgument(
        _RouteUrl.rules,
      )
    ];
  }

  FullRouteInfo teamsScreen() {
    return [
      const RouteArgument(
        _RouteUrl.teams,
      )
    ];
  }

  FullRouteInfo wordsScreen() {
    return [
      const RouteArgument(
        _RouteUrl.words,
      )
    ];
  }

  FullRouteInfo preGameScreen() {
    FullRouteInfo replaceRoutes = mainScreen();
    replaceRoutes.add(const RouteArgument(
      _RouteUrl.preGame,
    ));
    return replaceRoutes;
  }

  FullRouteInfo teamsRateScreen() {
    FullRouteInfo replaceRoutes = mainScreen();
    replaceRoutes.add(const RouteArgument(
      _RouteUrl.teamsRate,
    ));
    return replaceRoutes;
  }

  FullRouteInfo gameProcess() {
    FullRouteInfo replaceRoutes = mainScreen();
    replaceRoutes.add(const RouteArgument(
      _RouteUrl.gameProcess,
    ));
    return replaceRoutes;
  }

  FullRouteInfo teamResult() {
    FullRouteInfo replaceRoutes = mainScreen();
    replaceRoutes.add(const RouteArgument(
      _RouteUrl.teamResult,
    ));
    return replaceRoutes;
  }

  FullRouteInfo winner() {
    return [
      const RouteArgument(
        _RouteUrl.winner,
      )
    ];
  }

  FullRouteInfo _getInitialRoute() {
    return mainScreen();
  }

  @override
  void registerRoutes(AppNavigationContainer rootContainer) {
    rootContainer.registerRoute(RouteEndpoint.redirect("/", _getInitialRoute));
    rootContainer.registerRoute(
        RouteEndpoint.page(_RouteUrl.main, MainScreen.pageBuilder));
    rootContainer.registerRoute(
        RouteEndpoint.page(_RouteUrl.settings, SettingsScreen.pageBuilder));
    rootContainer.registerRoute(
        RouteEndpoint.page(_RouteUrl.rules, RulesScreen.pageBuilder));
    rootContainer.registerRoute(
      RouteEndpoint.page(_RouteUrl.teams, TeamsScreen.pageBuilder),
    );
    rootContainer.registerRoute(
      RouteEndpoint.page(_RouteUrl.words, WordsScreen.pageBuilder),
    );
    rootContainer.registerRoute(
      RouteEndpoint.page(_RouteUrl.preGame, PreGameScreen.pageBuilder),
    );
    rootContainer.registerRoute(
      RouteEndpoint.page(_RouteUrl.teamsRate, TeamsRateScreen.pageBuilder),
    );
    rootContainer.registerRoute(
      RouteEndpoint.page(_RouteUrl.gameProcess, GameProcessScreen.pageBuilder),
    );
    rootContainer.registerRoute(
      RouteEndpoint.page(_RouteUrl.teamResult, TeamResultScreen.pageBuilder),
    );
    rootContainer.registerRoute(
      RouteEndpoint.page(_RouteUrl.winner, WinnerScreen.pageBuilder),
    );
    // rootContainer.registerRoute(
    //     RouteEndpoint.pageWithArgument<FamilyMembersArguments>(_RouteUrl.family,
    //         FamilyMembersArguments.keyBuilder, FamilyMembers.pageBuilder));
  }
}

extension AppRoutesExtension on ServiceScope {
  void addAppRoutes() {
    registerLazySingleton(() => AppRoutes(
          get<RootAppNavigation>(),
        ));

    addRoutes<AppRoutes>();
  }
}
