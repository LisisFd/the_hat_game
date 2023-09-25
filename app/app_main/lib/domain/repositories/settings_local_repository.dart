import 'package:core_storage/storage/storage.dart';

import '../domain.dart';

class SettingsLocalRepository extends ISettingsRepository {
  static const String storageKeySettings = "current.settings";
  late final IKeyValueStorage _storage;

  SettingsLocalRepository({
    required IKeyValueStorage storage,
  }) {
    _storage = storage;
  }

  @override
  Future<TheHatAppSettings?> getSettings() async {
    var settings =
        await _storage.read(storageKeySettings, TheHatAppSettings.fromJson);
    return settings;
  }

  @override
  void setSettings(TheHatAppSettings settings) {
    _storage.write<TheHatAppSettings>(storageKeySettings, settings);
  }
}
