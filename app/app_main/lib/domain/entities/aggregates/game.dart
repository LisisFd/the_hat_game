import 'package:core_api/core_api.dart';

import '../entities.dart';

part 'game.g.dart';

@CopyWith()
@JsonSerializable(explicitToJson: true)
class TheHatAppGame implements IJsonWrite<TheHatAppGame> {
  final List<Team> teams;
  final int playersCount;
  final List<String> words;
  final int countWordsOnPlayer;
  final Duration roundTime;

  final List<String> skipWords;
  String? currentTeam;
  Lap currentLap;

  TheHatAppGame({
    required this.teams,
    required this.playersCount,
    required this.countWordsOnPlayer,
    required this.roundTime,
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
