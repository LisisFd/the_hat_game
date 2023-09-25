import 'package:app_main/domain/domain.dart';

abstract class IGameService {
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

  void setUpGameTeams(List<Team> teams, int countOfPlayers);

  void addWord(String word);

  void updateGame(
      {CurrentScreen? newScreen,
      Duration? time,
      int? pointPlus,
      List<Word>? words});

  void updateWord(bool isRight);

  void saveGame();

  void deleteGame();
}
