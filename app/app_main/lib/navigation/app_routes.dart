import 'package:core_flutter/core_flutter.dart';
import 'package:core_get_it/core_get_it.dart';

import '../view/view.dart';

class _RouteUrl {
  static const String main = "/main";
  static const String settings = "/settings";
  static const String teams = "/set-up/teams";
}

class AppRoutes extends IRouteNavigationBuilder {
  final RootAppNavigation router;

  AppRoutes(
    this.router,
  );

  FullRouteInfo mainScreen() {
    return [
      RouteArgument<MainScreenArguments>(_RouteUrl.main, MainScreenArguments())
    ];
  }

  FullRouteInfo settingsScreen() {
    return [
      RouteArgument<SettingsScreenArguments>(
          _RouteUrl.settings, SettingsScreenArguments())
    ];
  }

  FullRouteInfo teamsScreen() {
    return [
      RouteArgument<TeamsScreenArguments>(
          _RouteUrl.teams, TeamsScreenArguments())
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
      RouteEndpoint.page(_RouteUrl.teams, TeamsScreen.pageBuilder),
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
