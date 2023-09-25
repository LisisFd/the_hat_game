import '../entities/entities.dart';

abstract class ISettingsRepository {
  Future<TheHatAppSettings?> getSettings();

  void setSettings(TheHatAppSettings settings);
}
