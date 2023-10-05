import 'package:core_utils/core_utils.dart';

import '../../domain/domain.dart';

abstract class ISettingService {
  IBehaviorSubjectReadonlyNotNull<TheHatAppSettings> get appSettings;

  DurationSeconds get defaultDuration;

  void updateSettings(TheHatAppSettings newSettings);
}
