import 'package:app_main/models/models.dart';

abstract class IGameService {
  List<String> get teams;

  int get countOfPlayers;

  int get countWordsOnPlayer;

  List<String> get words;

  bool get gameIsReady;

  Lap? get currentLap;

  void setUpGameTeams(List<String> teams, int countOfPlayers);

  void addWord(String word);
}
