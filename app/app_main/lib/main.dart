import "dart:async";

import 'package:app_core/app_core.dart';
import 'package:app_main/controllers/controllers.dart';
import 'package:app_main/localization.dart';
import 'package:app_main/services.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:core_get_it/core_get_it.dart';
import 'package:core_localization/core_localization.dart';
import 'package:core_ui/core_ui.dart';
import 'package:core_utils/core_utils.dart';
import 'package:responsive_framework/responsive_wrapper.dart';

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
      const Locale("uk"),
      const Locale("ru"),
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

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SubjectWidgetContext {
  static const double _appWidth = 390.0;
  final RootAppNavigation _navigation = getWidgetService<RootAppNavigation>();
  final LocalizationService _localizationService =
      getWidgetService<LocalizationService>();
  final IAppLocaleService _appLocaleService =
      getWidgetService<IAppLocaleService>();

  @override
  void initState() {
    listen(_appLocaleService.appLocale);
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        onGenerateTitle: (context) => context.localization().appName,
        debugShowCheckedModeBanner: false,
        theme: MyAppTheme.createMaterial(),
        themeMode: ThemeMode.light,
        onGenerateInitialRoutes: _navigation.onGenerateInitialRoutes,
        onGenerateRoute: _navigation.onGenerateRoute,
        builder: (context, widget) {
          var deviceWidth = MediaQuery.of(context).size.width;
          return ResponsiveWrapper.builder(
            widget,
            defaultScaleFactor: deviceWidth / _appWidth,
          );
        },
        navigatorKey: _navigation.rootContainer.navigatorKey,
        supportedLocales: _localizationService.supportedLocales,
        locale: _appLocaleService.locale,
        localizationsDelegates: [
          AppLocalizations.delegate,
          ..._localizationService.getLocalizationDelegates(),
          CoreUiLocalization.delegate,
        ]);
  }
}
