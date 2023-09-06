import "dart:async";

import 'package:app_core/app_core.dart';
import 'package:app_core/config.dart';
import 'package:app_core/localization.dart';
import 'package:app_core/theme.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:core_flutter/diagnostics.dart';
import 'package:core_get_it/core_get_it.dart';
import 'package:core_localization/core_localization.dart';
import 'package:core_ui/core_ui.dart';
import 'package:core_ui/localizations.dart';
import 'package:core_utils/core_utils.dart';
import 'package:hotel_domain/hotel_domain.dart';
import 'package:hotel_domain/localization.dart';
import 'package:hotel_domain_ui/localization.dart';
import 'package:property_information/localization.dart';

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
    LocalizationService localizationService =
        getWidgetService<LocalizationService>();
    return MaterialApp.router(
        scrollBehavior: AppScrollBehavior(),
        onGenerateTitle: (context) => context.localization().common_appName,
        debugShowCheckedModeBanner: false,
        theme: MyAppTheme.createMaterial(),
        themeMode: ThemeMode.light,
        supportedLocales: localizationService.supportedLocales,
        localizationsDelegates: [
          AppLocalizations.delegate,
          ...localizationService.getLocalizationDelegates(),
          CoreUiLocalization.delegate,
        ]);
  }
}
