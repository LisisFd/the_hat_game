import 'package:app_main/models/models.dart';
import 'package:core_utils/core_utils.dart';

abstract class ISettingService {
  IBehaviorSubjectReadonly<TheHatAppSettings> get appSettings;

  void updateSettings(TheHatAppSettings newSettings);
}
