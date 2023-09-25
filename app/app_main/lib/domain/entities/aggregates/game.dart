import 'package:core_api/core_api.dart';

import '../entities.dart';

part 'game.g.dart';

@CopyWith()
@JsonSerializable(explicitToJson: true)
class TheHatAppGame implements IJsonWrite<TheHatAppGame> {
  final List<Team> teams;
  final int playersCount;
  final List<Word> words;

  final int countWordsOnPlayer;
  final Duration roundTime;

  Team? currentTeam;
  Lap currentLap;
  CurrentScreen currentScreen;

  TheHatAppGame({
    required this.teams,
    required this.playersCount,
    required this.countWordsOnPlayer,
    required this.roundTime,
    this.words = const [],
    this.currentTeam,
    this.currentLap = Lap.first,
    this.currentScreen = CurrentScreen.setUp,
  });

  @override
  Map<String, dynamic> toJson() => _$TheHatAppGameToJson(this);

  factory TheHatAppGame.fromJson(Map<String, dynamic> json) =>
      _$TheHatAppGameFromJson(json);
}
