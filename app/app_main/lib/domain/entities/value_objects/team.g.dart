// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$TeamCWProxy {
  Team name(String name);

  Team points(int points);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Team(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Team(...).copyWith(id: 12, name: "My name")
  /// ````
  Team call({
    String? name,
    int? points,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfTeam.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfTeam.copyWith.fieldName(...)`
class _$TeamCWProxyImpl implements _$TeamCWProxy {
  const _$TeamCWProxyImpl(this._value);

  final Team _value;

  @override
  Team name(String name) => this(name: name);

  @override
  Team points(int points) => this(points: points);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Team(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Team(...).copyWith(id: 12, name: "My name")
  /// ````
  Team call({
    Object? name = const $CopyWithPlaceholder(),
    Object? points = const $CopyWithPlaceholder(),
  }) {
    return Team(
      name: name == const $CopyWithPlaceholder() || name == null
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      points: points == const $CopyWithPlaceholder() || points == null
          ? _value.points
          // ignore: cast_nullable_to_non_nullable
          : points as int,
    );
  }
}

extension $TeamCopyWith on Team {
  /// Returns a callable class that can be used as follows: `instanceOfTeam.copyWith(...)` or like so:`instanceOfTeam.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$TeamCWProxy get copyWith => _$TeamCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Team _$TeamFromJson(Map<String, dynamic> json) => Team(
      name: json['name'] as String,
      points: json['points'] as int? ?? 0,
    );

Map<String, dynamic> _$TeamToJson(Team instance) => <String, dynamic>{
      'name': instance.name,
      'points': instance.points,
    };
