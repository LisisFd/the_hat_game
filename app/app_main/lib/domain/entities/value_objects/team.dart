import 'package:core_api/core_api.dart';

part 'gen/team.g.dart';

@CopyWith()
@JsonSerializable()
class Team implements IJsonWrite<Team> {
  final String name;
  final int points;

  @override
  Map<String, dynamic> toJson() => _$TeamToJson(this);

  factory Team.fromJson(Map<String, dynamic> json) => _$TeamFromJson(json);

  const Team({
    required this.name,
    this.points = 0,
  });
}
