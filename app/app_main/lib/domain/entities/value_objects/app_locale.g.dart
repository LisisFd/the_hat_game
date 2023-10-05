// GENERATED CODE - DO NOT MODIFY BY HAND
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_locale.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AppLocaleCWProxy {
  AppLocale locale(String? locale);

  AppLocale sR(bool sR);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AppLocale(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AppLocale(...).copyWith(id: 12, name: "My name")
  /// ````
  AppLocale call({
    String? locale,
    bool? sR,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAppLocale.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAppLocale.copyWith.fieldName(...)`
class _$AppLocaleCWProxyImpl implements _$AppLocaleCWProxy {
  const _$AppLocaleCWProxyImpl(this._value);

  final AppLocale _value;

  @override
  AppLocale locale(String? locale) => this(locale: locale);

  @override
  AppLocale sR(bool sR) => this(sR: sR);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AppLocale(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AppLocale(...).copyWith(id: 12, name: "My name")
  /// ````
  AppLocale call({
    Object? locale = const $CopyWithPlaceholder(),
    Object? sR = const $CopyWithPlaceholder(),
  }) {
    return AppLocale(
      locale: locale == const $CopyWithPlaceholder()
          ? _value.locale
          // ignore: cast_nullable_to_non_nullable
          : locale as String?,
      sR: sR == const $CopyWithPlaceholder() || sR == null
          ? _value.sR
          // ignore: cast_nullable_to_non_nullable
          : sR as bool,
    );
  }
}

extension $AppLocaleCopyWith on AppLocale {
  /// Returns a callable class that can be used as follows: `instanceOfAppLocale.copyWith(...)` or like so:`instanceOfAppLocale.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AppLocaleCWProxy get copyWith => _$AppLocaleCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppLocale _$AppLocaleFromJson(Map<String, dynamic> json) => AppLocale(
      locale: json['locale'] as String?,
      sR: json['sR'] as bool? ?? false,
    );

Map<String, dynamic> _$AppLocaleToJson(AppLocale instance) => <String, dynamic>{
      'locale': instance.locale,
      'sR': instance.sR,
    };
