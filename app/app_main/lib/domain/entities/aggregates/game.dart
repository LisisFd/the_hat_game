import 'package:core_api/core_api.dart';

import '../entities.dart';

part 'game.g.dart';

///TODO: set generated directory
@CopyWith()
@JsonSerializable(explicitToJson: true)
class TheHatAppGame implements IJsonWrite<TheHatAppGame> {
  final List<Team> teams;
  final int playersCount;
  final List<Word> words;

  final int countWordsOnPlayer;
  final Duration roundTime;

  Lap currentLap;
  CurrentScreen currentScreen;
  GameState gameState;

  TheHatAppGame(
      {required this.teams,
      required this.playersCount,
      required this.countWordsOnPlayer,
      required this.roundTime,
      this.words = const [],
      this.currentLap = Lap.first,
      this.currentScreen = CurrentScreen.setUp,
      this.gameState = GameState.init});

  @override
  Map<String, dynamic> toJson() => _$TheHatAppGameToJson(this);

  factory TheHatAppGame.fromJson(Map<String, dynamic> json) =>
      _$TheHatAppGameFromJson(json);
}
