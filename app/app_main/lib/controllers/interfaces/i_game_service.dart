import 'package:app_main/domain/domain.dart';

abstract class IGameService {
  int get countOfPlayers;

  int get countWordsOnPlayer;

  List<Team> get teams;

  List<String> get words;

  List<Word> get wordsWithStatus;

  Duration get roundTime;

  bool get gameIsReady;

  Lap? get currentLap;

  Team get currentTeam;

  String get word;

  void setUpGameTeams(List<Team> teams, int countOfPlayers);

  void addWord(String word);

  void updateGame({Duration? time, int pointPlus});

  void updateWord(bool isRight);

  void saveGame();
}
