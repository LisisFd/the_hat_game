import '../entities/entities.dart';

abstract class ITeamsRepository {
  Future<Teams> getTeams();

  Future<List<String>> getTeamsByLocale(String locale);
}
