import 'package:app_main/models/models.dart';

abstract class ITeamsRepository {
  Future<Teams> getTeams();
}
