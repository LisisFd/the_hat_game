import 'package:core_api/core_api.dart';

part 'teams.g.dart';

@CopyWith()
@JsonSerializable()
class Teams implements IJsonWrite<Teams> {
  final List<String> en;
  final List<String> ua;
  final List<String> ru;

  @override
  Map<String, dynamic> toJson() => _$TeamsToJson(this);

  factory Teams.fromJson(Map<String, dynamic> json) => _$TeamsFromJson(json);

  const Teams({
    required this.en,
    required this.ua,
    required this.ru,
  });
}
