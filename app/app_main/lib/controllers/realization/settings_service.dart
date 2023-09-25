import 'package:app_main/domain/domain.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:core_get_it/core_get_it.dart';
import 'package:core_utils/core_utils.dart';

import '../interfaces/interfaces.dart';

class SettingsService extends ISettingService {
  late final ISettingsRepository _settingsRepository;

  final BehaviorSubjectNotNull<TheHatAppSettings> _appSettings =
      BehaviorSubjectNotNull<TheHatAppSettings>.alwaysUpdate(
          const TheHatAppSettings());

  @override
  IBehaviorSubjectReadonlyNotNull<TheHatAppSettings> get appSettings =>
      _appSettings;

  SettingsService({
    required ISettingsRepository settingsRepository,
  }) {
    _settingsRepository = settingsRepository;
  }

  Future<void> init() async {
    await _initSettings();
  }

  @override
  void updateSettings(TheHatAppSettings newSettings) {
    _appSettings.setValue(newSettings);
    _settingsRepository.setSettings(newSettings);
  }

  Future<void> _initSettings() async {
    var settings = await _settingsRepository.getSettings();
    settings ??= const TheHatAppSettings();
    _appSettings.setValue(settings);
  }
}

extension SettingsServiceFeatureExtension on ServiceScope {
  Future<ISettingService> _serviceFactory() async {
    SettingsService service = SettingsService(
      settingsRepository: get<ISettingsRepository>(),
    );
    await service.init();
    return service;
  }

  void addSettingsServiceFeature() {
    registerSingletonAsync<ISettingService>(
      () async => await _serviceFactory(),
      dependsOn: [
        ISettingsRepository,
      ],
    );
  }
}
