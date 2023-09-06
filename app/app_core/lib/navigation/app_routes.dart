import 'package:core_flutter/core_flutter.dart';
import 'package:core_get_it/core_get_it.dart';

// class _RouteUrl {
//   static const String home = "/home";
// }

class AppRoutes extends IRouteNavigationBuilder {
  final RootAppNavigation router;

  AppRoutes(
    this.router,
  );

  // FullRouteInfo homePage() {
  //   return [
  //     RouteArgument<HomePageArguments>(_RouteUrl.home, HomePageArguments())
  //   ];
  // }

  // FullRouteInfo _getInitialRoute() {
  //
  //   return homePage();
  // }

  @override
  void registerRoutes(AppNavigationContainer rootContainer) {
    // rootContainer.registerRoute(RouteEndpoint.redirect("/", _getInitialRoute));
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
