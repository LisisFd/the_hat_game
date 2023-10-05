import 'package:core_api/core_api.dart';
import 'package:core_crypto/core_crypto.dart';

import 'word_status.dart';

part 'gen/word.g.dart';

@CopyWith()
@JsonSerializable()
class Word implements IJsonWrite<Word> {
  final int id;
  final String word;
  final WordStatus status;
  final bool isLastWord;

  @override
  Map<String, dynamic> toJson() => _$WordToJson(this);

  factory Word.fromJson(Map<String, dynamic> json) => _$WordFromJson(json);

  factory Word.create({
    required String word,
    WordStatus status = WordStatus.active,
  }) {
    final int id = IdGenerator.idShort();
    return Word(id: id, word: word, status: status);
  }

  const Word({
    required this.id,
    required this.word,
    this.status = WordStatus.active,
    this.isLastWord = false,
  });
}
