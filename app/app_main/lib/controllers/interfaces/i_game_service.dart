import 'package:app_main/domain/domain.dart';

abstract class IGameService {
  List<Team> get teams;

  int get countOfPlayers;

  int get countWordsOnPlayer;

  List<String> get words;

  bool get gameIsReady;

  Lap? get currentLap;

  void setUpGameTeams(List<Team> teams, int countOfPlayers);

  void addWord(String word);
}
