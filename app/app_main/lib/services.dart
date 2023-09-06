import 'package:app_core/app_core.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:core_get_it/core_get_it.dart';
import 'package:core_storage/core_storage.dart';

class AppServices {
  static void registerServices(
    GetIt container,
  ) {
    container.addSecuredStorage(AppConfig.storageKey);
    container.addRootSubjectContext();
    container.addCoreAppNavigation();
    container.addFlowFactory();
    container.addErrorReporterService();
    container.addLoadingServiceWrapper();
    container.addAppRoutes();
  }
}
