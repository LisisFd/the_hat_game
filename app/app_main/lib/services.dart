import 'package:app_core/app_core.dart';
import 'package:app_main/controllers/controllers.dart';
import 'package:app_main/domain/domain.dart';
import 'package:app_main/navigation/navigation.dart';
import 'package:core_app_test/core_app_testing.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:core_get_it/core_get_it.dart';
import 'package:core_storage/core_storage.dart';

import 'debug/debug_widget.dart';

class AppServices {
  static void registerServices(
    GetIt container,
  ) {
    //---------------SETUP----------------------
    container.addSecuredStorage(AppConfig.storageKey);
    container.addRootSubjectContext();
    container.addCoreAppNavigation();
    container.addFlowFactory();
    container.addErrorReporterService();
    container.addLoadingServiceWrapper();
    container.addAppRoutes();
    container.addAppSubject();
    //----------addAppSubject--------------------
    container.addTeamsRepository();
    container.addGameRepository();
    container.addSettingsRepository();
    container.addAppLifeStyleRepository();
    container.addAppLocaleRepository();
    //---------CONTROLLERS----------------
    container.addTeamsServiceFeature();
    container.addSettingsServiceFeature();
    container.addTheHatGameServiceFeature();
    container.addGameRestoreFlowFeature();
    container.addAppLocaleServiceFeature();
    //---------TEST---------------------
    if (kDebugMode) {
      container.addAppTestWidget(() => DebugNavigationWidget());
    }
  }
}
