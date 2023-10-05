import 'package:app_main/domain/entities/entities.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:core_utils/core_utils.dart';

abstract class IAppLocaleService {
  IBehaviorSubjectReadonly<AppLocale?> get appLocale;

  Locale get locale;

  void updateLocale(Locale newLocale);
}
