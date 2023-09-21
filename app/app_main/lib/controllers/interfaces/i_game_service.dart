import 'package:app_main/domain/domain.dart';

abstract class IGameService {
  int get countOfPlayers;

  int get countWordsOnPlayer;

  List<Team> get teams;

  List<String> get words;

  bool get gameIsReady;

  Lap? get currentLap;

  Team get currentTeam;

  void setUpGameTeams(List<Team> teams, int countOfPlayers);

  void addWord(String word);
}
