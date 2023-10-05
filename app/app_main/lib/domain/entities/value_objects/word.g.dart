// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'word.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$WordCWProxy {
  Word id(int id);

  Word word(String word);

  Word status(WordStatus status);

  Word isLastWord(bool isLastWord);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Word(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Word(...).copyWith(id: 12, name: "My name")
  /// ````
  Word call({
    int? id,
    String? word,
    WordStatus? status,
    bool? isLastWord,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfWord.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfWord.copyWith.fieldName(...)`
class _$WordCWProxyImpl implements _$WordCWProxy {
  const _$WordCWProxyImpl(this._value);

  final Word _value;

  @override
  Word id(int id) => this(id: id);

  @override
  Word word(String word) => this(word: word);

  @override
  Word status(WordStatus status) => this(status: status);

  @override
  Word isLastWord(bool isLastWord) => this(isLastWord: isLastWord);

  @override

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `Word(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// Word(...).copyWith(id: 12, name: "My name")
  /// ````
  Word call({
    Object? id = const $CopyWithPlaceholder(),
    Object? word = const $CopyWithPlaceholder(),
    Object? status = const $CopyWithPlaceholder(),
    Object? isLastWord = const $CopyWithPlaceholder(),
  }) {
    return Word(
      id: id == const $CopyWithPlaceholder() || id == null
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as int,
      word: word == const $CopyWithPlaceholder() || word == null
          ? _value.word
          // ignore: cast_nullable_to_non_nullable
          : word as String,
      status: status == const $CopyWithPlaceholder() || status == null
          ? _value.status
          // ignore: cast_nullable_to_non_nullable
          : status as WordStatus,
      isLastWord:
          isLastWord == const $CopyWithPlaceholder() || isLastWord == null
              ? _value.isLastWord
              // ignore: cast_nullable_to_non_nullable
              : isLastWord as bool,
    );
  }
}

extension $WordCopyWith on Word {
  /// Returns a callable class that can be used as follows: `instanceOfWord.copyWith(...)` or like so:`instanceOfWord.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$WordCWProxy get copyWith => _$WordCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Word _$WordFromJson(Map<String, dynamic> json) => Word(
      id: json['id'] as int,
      word: json['word'] as String,
      status: $enumDecodeNullable(_$WordStatusEnumMap, json['status']) ??
          WordStatus.active,
      isLastWord: json['isLastWord'] as bool? ?? false,
    );

Map<String, dynamic> _$WordToJson(Word instance) => <String, dynamic>{
      'id': instance.id,
      'word': instance.word,
      'status': _$WordStatusEnumMap[instance.status]!,
      'isLastWord': instance.isLastWord,
    };

const _$WordStatusEnumMap = {
  WordStatus.disable: 'disable',
  WordStatus.active: 'active',
  WordStatus.right: 'right',
  WordStatus.skip: 'skip',
};
