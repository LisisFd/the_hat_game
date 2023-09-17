import 'package:app_main/models/entities/value_objects/lap.dart';
import 'package:core_api/core_api.dart';

part 'game.g.dart';

@CopyWith()
@JsonSerializable(explicitToJson: true)
class TheHatAppGame implements IJsonWrite<TheHatAppGame> {
  final List<String> teams;
  final int playersCount;
  final List<String> words;
  final int countWordsOnOnePlayer;

  final List<String> skipWords;
  String? currentTeam;
  Lap currentLap;

  TheHatAppGame({
    required this.teams,
    required this.playersCount,
    required this.countWordsOnOnePlayer,
    this.words = const [],
    this.skipWords = const [],
    this.currentTeam,
    this.currentLap = Lap.first,
  });

  @override
  Map<String, dynamic> toJson() => _$TheHatAppGameToJson(this);

  factory TheHatAppGame.fromJson(Map<String, dynamic> json) =>
      _$TheHatAppGameFromJson(json);
}
