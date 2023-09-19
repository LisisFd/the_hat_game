import 'package:app_main/domain/domain.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:core_get_it/core_get_it.dart';
import 'package:core_storage/core_storage.dart';
import 'package:core_utils/core_utils.dart';

import '../interfaces/interfaces.dart';

class SettingsService extends ISettingService {
  static const String storageKeySettings = "current.settings";
  final IKeyValueStorage storage;

  final BehaviorSubjectNotNull<TheHatAppSettings> _appSettings =
      BehaviorSubjectNotNull<TheHatAppSettings>.alwaysUpdate(
          const TheHatAppSettings());

  @override
  IBehaviorSubjectReadonlyNotNull<TheHatAppSettings> get appSettings =>
      _appSettings;

  SettingsService({
    required this.storage,
  });

  Future<void> init() async {
    await _initSettings();
  }

  @override
  void updateSettings(TheHatAppSettings newSettings) {
    _appSettings.setValue(newSettings);
    storage.write<TheHatAppSettings>(storageKeySettings, _appSettings.value);
  }

  Future<void> _initSettings() async {
    var settings =
        await storage.read(storageKeySettings, TheHatAppSettings.fromJson);
    settings ??= const TheHatAppSettings();
    _appSettings.setValue(settings);
  }
}

extension SettingsServiceFeatureExtension on ServiceScope {
  Future<ISettingService> _serviceFactory() async {
    SettingsService service = SettingsService(
      storage: get<IKeyValueStorage>(),
    );
    await service.init();
    return service;
  }

  void addSettingsServiceFeature() {
    registerSingletonAsync<ISettingService>(
      () async => await _serviceFactory(),
      dependsOn: [
        IKeyValueStorage,
      ],
    );
  }
}
