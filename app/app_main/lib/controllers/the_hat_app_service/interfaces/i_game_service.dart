abstract class IGameService {
  List<String> get teams;

  int get countOfPlayers;

  int get countWordsOnPlayer;

  List<String> get words;

  bool get gameIsReady;

  void setUpGameTeams(List<String> teams, int countOfPlayers);

  void addWord(String word);
}
