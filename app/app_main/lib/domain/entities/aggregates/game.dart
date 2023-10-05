import 'package:core_api/core_api.dart';

import '../entities.dart';

part 'gen/game.g.dart';

///TODO: set generated directory
@CopyWith()
@JsonSerializable(explicitToJson: true)
class TheHatAppGame implements IJsonWrite<TheHatAppGame> {
  final List<Team> teams;
  final int playersCount;
  final List<Word> words;

  final int countWordsOnPlayer;
  final Duration roundTime;

  final Lap currentLap;
  final CurrentScreen currentScreen;
  final GameState gameState;

  final bool generalLastWordGame;
  final Team? lastWordTeam;

  TheHatAppGame({
    required this.teams,
    required this.playersCount,
    required this.countWordsOnPlayer,
    required this.roundTime,
    this.lastWordTeam,
    this.words = const [],
    this.currentLap = Lap.first,
    this.currentScreen = CurrentScreen.setUp,
    this.gameState = GameState.init,
    this.generalLastWordGame = false,
  });

  @override
  Map<String, dynamic> toJson() => _$TheHatAppGameToJson(this);

  factory TheHatAppGame.fromJson(Map<String, dynamic> json) =>
      _$TheHatAppGameFromJson(json);
}
