import 'package:app_main/models/models.dart';

import 'i_settings_service.dart';

abstract class ITheHatAppService implements ISettingService {
  Teams get teams;
}
