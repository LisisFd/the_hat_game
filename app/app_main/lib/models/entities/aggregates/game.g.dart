// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TheHatAppGameCWProxy {
  TheHatAppGame teams(List<String> teams);

  TheHatAppGame playersCount(int playersCount);

  TheHatAppGame countWordsOnOnePlayer(int countWordsOnOnePlayer);

  TheHatAppGame words(List<String> words);

  TheHatAppGame skipWords(List<String> skipWords);

  TheHatAppGame currentTeam(String? currentTeam);

  TheHatAppGame currentLap(Lap currentLap);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TheHatAppGame(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TheHatAppGame(...).copyWith(id: 12, name: "My name")
  /// ````
  TheHatAppGame call({
    List<String>? teams,
    int? playersCount,
    int? countWordsOnOnePlayer,
    List<String>? words,
    List<String>? skipWords,
    String? currentTeam,
    Lap? currentLap,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTheHatAppGame.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTheHatAppGame.copyWith.fieldName(...)`
class _$TheHatAppGameCWProxyImpl implements _$TheHatAppGameCWProxy {
  const _$TheHatAppGameCWProxyImpl(this._value);

  final TheHatAppGame _value;

  @override
  TheHatAppGame teams(List<String> teams) => this(teams: teams);

  @override
  TheHatAppGame playersCount(int playersCount) =>
      this(playersCount: playersCount);

  @override
  TheHatAppGame countWordsOnOnePlayer(int countWordsOnOnePlayer) =>
      this(countWordsOnOnePlayer: countWordsOnOnePlayer);

  @override
  TheHatAppGame words(List<String> words) => this(words: words);

  @override
  TheHatAppGame skipWords(List<String> skipWords) => this(skipWords: skipWords);

  @override
  TheHatAppGame currentTeam(String? currentTeam) =>
      this(currentTeam: currentTeam);

  @override
  TheHatAppGame currentLap(Lap currentLap) => this(currentLap: currentLap);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `TheHatAppGame(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// TheHatAppGame(...).copyWith(id: 12, name: "My name")
  /// ````
  TheHatAppGame call({
    Object? teams = const $CopyWithPlaceholder(),
    Object? playersCount = const $CopyWithPlaceholder(),
    Object? countWordsOnOnePlayer = const $CopyWithPlaceholder(),
    Object? words = const $CopyWithPlaceholder(),
    Object? skipWords = const $CopyWithPlaceholder(),
    Object? currentTeam = const $CopyWithPlaceholder(),
    Object? currentLap = const $CopyWithPlaceholder(),
  }) {
    return TheHatAppGame(
      teams: teams == const $CopyWithPlaceholder() || teams == null
          ? _value.teams
          // ignore: cast_nullable_to_non_nullable
          : teams as List<String>,
      playersCount:
          playersCount == const $CopyWithPlaceholder() || playersCount == null
              ? _value.playersCount
              // ignore: cast_nullable_to_non_nullable
              : playersCount as int,
      countWordsOnOnePlayer:
          countWordsOnOnePlayer == const $CopyWithPlaceholder() ||
                  countWordsOnOnePlayer == null
              ? _value.countWordsOnOnePlayer
              // ignore: cast_nullable_to_non_nullable
              : countWordsOnOnePlayer as int,
      words: words == const $CopyWithPlaceholder() || words == null
          ? _value.words
          // ignore: cast_nullable_to_non_nullable
          : words as List<String>,
      skipWords: skipWords == const $CopyWithPlaceholder() || skipWords == null
          ? _value.skipWords
          // ignore: cast_nullable_to_non_nullable
          : skipWords as List<String>,
      currentTeam: currentTeam == const $CopyWithPlaceholder()
          ? _value.currentTeam
          // ignore: cast_nullable_to_non_nullable
          : currentTeam as String?,
      currentLap:
          currentLap == const $CopyWithPlaceholder() || currentLap == null
              ? _value.currentLap
              // ignore: cast_nullable_to_non_nullable
              : currentLap as Lap,
    );
  }
}

extension $TheHatAppGameCopyWith on TheHatAppGame {
  /// Returns a callable class that can be used as follows: `instanceOfTheHatAppGame.copyWith(...)` or like so:`instanceOfTheHatAppGame.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TheHatAppGameCWProxy get copyWith => _$TheHatAppGameCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TheHatAppGame _$TheHatAppGameFromJson(Map<String, dynamic> json) =>
    TheHatAppGame(
      teams: (json['teams'] as List<dynamic>).map((e) => e as String).toList(),
      playersCount: json['playersCount'] as int,
      countWordsOnOnePlayer: json['countWordsOnOnePlayer'] as int,
      words:
          (json['words'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      skipWords: (json['skipWords'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      currentTeam: json['currentTeam'] as String?,
      currentLap:
          $enumDecodeNullable(_$LapEnumMap, json['currentLap']) ?? Lap.first,
    );

Map<String, dynamic> _$TheHatAppGameToJson(TheHatAppGame instance) =>
    <String, dynamic>{
      'teams': instance.teams,
      'playersCount': instance.playersCount,
      'words': instance.words,
      'countWordsOnOnePlayer': instance.countWordsOnOnePlayer,
      'skipWords': instance.skipWords,
      'currentTeam': instance.currentTeam,
      'currentLap': _$LapEnumMap[instance.currentLap]!,
    };

const _$LapEnumMap = {
  Lap.first: 'first',
  Lap.second: 'second',
  Lap.third: 'third',
};
