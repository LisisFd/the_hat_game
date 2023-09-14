import 'i_settings_service.dart';

abstract class ITheHatAppService implements ISettingService {
  Future<void> init();
}
