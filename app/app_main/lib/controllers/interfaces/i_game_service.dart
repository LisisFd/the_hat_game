import 'package:app_main/domain/domain.dart';
import 'package:core_utils/core_utils.dart';

abstract class IGameService {
  IBehaviorSubjectReadonly<TheHatAppGame> get appGame;

  int get countOfPlayers;

  int get countWordsOnPlayer;

  List<Team> get teams;

  List<Word> get words;

  List<Word> get wordsWithStatus;

  Duration get roundTime;

  bool get gameIsReady;

  Lap? get currentLap;

  Team get currentTeam;

  Word get word;

  bool get gameIsNotEmpty;

  GameState get gameState;

  void setNewScreen(CurrentScreen newScreen);

  void setUpGameTeams(List<Team> teams, int countOfPlayers);

  void addWord(String word);

  void updateGame({
    CurrentScreen? newScreen,
    GameState? gameState,
    Duration? time,
    int? pointPlus,
    List<Word>? words,
  });

  void setNewLap();

  void changeCurrentTeam();

  void updateWord(bool isRight);

  void saveGame();

  void deleteGame();
}
