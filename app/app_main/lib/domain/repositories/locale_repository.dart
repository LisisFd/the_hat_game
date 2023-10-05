import 'package:core_flutter/core_flutter.dart';
import 'package:core_storage/core_storage.dart';
import 'package:core_utils/subjects/i_subjects.dart';

import '../domain.dart';

class LocaleRepository extends ILocaleRepository {
  static const String _storageKeyAppLocale = "current.locale";
  late final IKeyValueStorage _storage;
  final BehaviorSubject<AppLocale> _appLocale =
      BehaviorSubject.updateNotEqual();

  @override
  IBehaviorSubjectReadonly<AppLocale> get localeUpdater => _appLocale;

  LocaleRepository({
    required IKeyValueStorage storage,
  }) {
    _storage = storage;
  }

  @override
  Future<AppLocale?> getLocale() async {
    var locale = await _storage.read(_storageKeyAppLocale, AppLocale.fromJson);
    _appLocale.setValue(locale);
    return locale;
  }

  @override
  void setLocale(AppLocale locale) {
    _appLocale.setValue(locale);
    _storage.write<AppLocale>(_storageKeyAppLocale, locale);
  }
}
