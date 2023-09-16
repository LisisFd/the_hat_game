// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'teams.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TeamsCWProxy {
  Teams en(List<String> en);

  Teams ua(List<String> ua);

  Teams ru(List<String> ru);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Teams(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Teams(...).copyWith(id: 12, name: "My name")
  /// ````
  Teams call({
    List<String>? en,
    List<String>? ua,
    List<String>? ru,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTeams.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTeams.copyWith.fieldName(...)`
class _$TeamsCWProxyImpl implements _$TeamsCWProxy {
  const _$TeamsCWProxyImpl(this._value);

  final Teams _value;

  @override
  Teams en(List<String> en) => this(en: en);

  @override
  Teams ua(List<String> ua) => this(ua: ua);

  @override
  Teams ru(List<String> ru) => this(ru: ru);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Teams(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Teams(...).copyWith(id: 12, name: "My name")
  /// ````
  Teams call({
    Object? en = const $CopyWithPlaceholder(),
    Object? ua = const $CopyWithPlaceholder(),
    Object? ru = const $CopyWithPlaceholder(),
  }) {
    return Teams(
      en: en == const $CopyWithPlaceholder() || en == null
          ? _value.en
          // ignore: cast_nullable_to_non_nullable
          : en as List<String>,
      ua: ua == const $CopyWithPlaceholder() || ua == null
          ? _value.ua
          // ignore: cast_nullable_to_non_nullable
          : ua as List<String>,
      ru: ru == const $CopyWithPlaceholder() || ru == null
          ? _value.ru
          // ignore: cast_nullable_to_non_nullable
          : ru as List<String>,
    );
  }
}

extension $TeamsCopyWith on Teams {
  /// Returns a callable class that can be used as follows: `instanceOfTeams.copyWith(...)` or like so:`instanceOfTeams.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TeamsCWProxy get copyWith => _$TeamsCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Teams _$TeamsFromJson(Map<String, dynamic> json) => Teams(
      en: (json['en'] as List<dynamic>).map((e) => e as String).toList(),
      ua: (json['ua'] as List<dynamic>).map((e) => e as String).toList(),
      ru: (json['ru'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$TeamsToJson(Teams instance) => <String, dynamic>{
      'en': instance.en,
      'ua': instance.ua,
      'ru': instance.ru,
    };
