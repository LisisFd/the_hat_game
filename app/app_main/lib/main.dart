import "dart:async";

import 'package:app_core/app_core.dart';
import 'package:app_main/services.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:core_get_it/core_get_it.dart';
import 'package:core_localization/core_localization.dart';
import 'package:core_ui/core_ui.dart';
import 'package:core_utils/core_utils.dart';

Future runFullApp() async {
  var container = await initFullApp();

  ErrorHandling errorHandling = container.get<ErrorHandling>();
  errorHandling.startApp(() {
    _runWithDependencyInjection(const MyApp());
  });
}

Future<GetIt> initFullApp() {
  final Completer<GetIt> completer = Completer();

  RootServiceProvider.registerServices((container) {
    container.addLogging(level: Level.INFO);
    container.addErrorHandling();
    container.addLocalization(supportedLocales: [
      const Locale("en"),
    ]);

    completer.complete(container);
  });

  return completer.future;
}

Future initDependencyInjection() async {
  MyAppTheme.registerAsMainTheme();

  await RootServiceProvider.createRootProvider((container) {
    AppServices.registerServices(
      container,
    );
  });
  RootAppNavigation navigation = getWidgetService<RootAppNavigation>();
  navigation.registerRoutes();
}

Future _runWithDependencyInjection(
  Widget rootWidget,
) async {
  await initDependencyInjection();
  runApp(rootWidget);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    RootAppNavigation navigation = getWidgetService<RootAppNavigation>();
    LocalizationService localizationService =
        getWidgetService<LocalizationService>();
    return MaterialApp(
        onGenerateTitle: (context) => context.localization().common_appName,
        debugShowCheckedModeBanner: false,
        theme: MyAppTheme.createMaterial(),
        themeMode: ThemeMode.light,
        onGenerateInitialRoutes: navigation.onGenerateInitialRoutes,
        onGenerateRoute: navigation.onGenerateRoute,
        key: navigation.rootContainer.navigatorKey,
        supportedLocales: localizationService.supportedLocales,
        localizationsDelegates: [
          AppLocalizations.delegate,
          ...localizationService.getLocalizationDelegates(),
          CoreUiLocalization.delegate,
        ]);
  }
}
