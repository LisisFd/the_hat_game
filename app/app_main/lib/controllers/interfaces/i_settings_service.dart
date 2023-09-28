import 'package:app_main/domain/domain.dart';
import 'package:core_utils/core_utils.dart';

abstract class ISettingService {
  IBehaviorSubjectReadonlyNotNull<TheHatAppSettings> get appSettings;

  DurationSeconds get defaultDuration;

  void updateSettings(TheHatAppSettings newSettings);
}
