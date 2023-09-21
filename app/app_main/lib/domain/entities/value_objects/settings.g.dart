// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TheHatAppSettingsCWProxy {
  TheHatAppSettings countWordsOnPlayer(int countWordsOnPlayer);

  TheHatAppSettings animation(bool animation);

  TheHatAppSettings timePlayerTurn(Duration timePlayerTurn);

  TheHatAppSettings lastWord(bool lastWord);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TheHatAppSettings(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TheHatAppSettings(...).copyWith(id: 12, name: "My name")
  /// ````
  TheHatAppSettings call({
    int? countWordsOnPlayer,
    bool? animation,
    Duration? timePlayerTurn,
    bool? lastWord,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTheHatAppSettings.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTheHatAppSettings.copyWith.fieldName(...)`
class _$TheHatAppSettingsCWProxyImpl implements _$TheHatAppSettingsCWProxy {
  const _$TheHatAppSettingsCWProxyImpl(this._value);

  final TheHatAppSettings _value;

  @override
  TheHatAppSettings countWordsOnPlayer(int countWordsOnPlayer) =>
      this(countWordsOnPlayer: countWordsOnPlayer);

  @override
  TheHatAppSettings animation(bool animation) => this(animation: animation);

  @override
  TheHatAppSettings timePlayerTurn(Duration timePlayerTurn) =>
      this(timePlayerTurn: timePlayerTurn);

  @override
  TheHatAppSettings lastWord(bool lastWord) => this(lastWord: lastWord);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TheHatAppSettings(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TheHatAppSettings(...).copyWith(id: 12, name: "My name")
  /// ````
  TheHatAppSettings call({
    Object? countWordsOnPlayer = const $CopyWithPlaceholder(),
    Object? animation = const $CopyWithPlaceholder(),
    Object? timePlayerTurn = const $CopyWithPlaceholder(),
    Object? lastWord = const $CopyWithPlaceholder(),
  }) {
    return TheHatAppSettings(
      countWordsOnPlayer: countWordsOnPlayer == const $CopyWithPlaceholder() ||
              countWordsOnPlayer == null
          ? _value.countWordsOnPlayer
          // ignore: cast_nullable_to_non_nullable
          : countWordsOnPlayer as int,
      animation: animation == const $CopyWithPlaceholder() || animation == null
          ? _value.animation
          // ignore: cast_nullable_to_non_nullable
          : animation as bool,
      timePlayerTurn: timePlayerTurn == const $CopyWithPlaceholder() ||
              timePlayerTurn == null
          ? _value.timePlayerTurn
          // ignore: cast_nullable_to_non_nullable
          : timePlayerTurn as Duration,
      lastWord: lastWord == const $CopyWithPlaceholder() || lastWord == null
          ? _value.lastWord
          // ignore: cast_nullable_to_non_nullable
          : lastWord as bool,
    );
  }
}

extension $TheHatAppSettingsCopyWith on TheHatAppSettings {
  /// Returns a callable class that can be used as follows: `instanceOfTheHatAppSettings.copyWith(...)` or like so:`instanceOfTheHatAppSettings.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TheHatAppSettingsCWProxy get copyWith =>
      _$TheHatAppSettingsCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TheHatAppSettings _$TheHatAppSettingsFromJson(Map<String, dynamic> json) =>
    TheHatAppSettings(
      countWordsOnPlayer: json['countWordsOnPlayer'] as int? ?? 3,
      animation: json['animation'] as bool? ?? true,
      timePlayerTurn: json['timePlayerTurn'] == null
          ? const Duration(seconds: 60)
          : Duration(microseconds: json['timePlayerTurn'] as int),
      lastWord: json['lastWord'] as bool? ?? true,
    );

Map<String, dynamic> _$TheHatAppSettingsToJson(TheHatAppSettings instance) =>
    <String, dynamic>{
      'countWordsOnPlayer': instance.countWordsOnPlayer,
      'animation': instance.animation,
      'timePlayerTurn': instance.timePlayerTurn.inMicroseconds,
      'lastWord': instance.lastWord,
    };
