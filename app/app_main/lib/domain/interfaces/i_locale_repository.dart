import 'package:core_utils/core_utils.dart';

import '../entities/entities.dart';

abstract class ILocaleRepository {
  Future<AppLocale?> getLocale();

  IBehaviorSubjectReadonly<AppLocale> get localeUpdater;

  void setLocale(AppLocale locale);
}
