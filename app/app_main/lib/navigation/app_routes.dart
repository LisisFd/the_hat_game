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
    return [
      const RouteArgument(
        _RouteUrl.preGame,
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
