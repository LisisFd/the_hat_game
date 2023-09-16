import 'dart:convert';
import 'dart:io';

import 'package:app_main/domain/interfaces/i_teams_repository.dart';
import 'package:app_main/models/entities/teams.dart';

class TeamsLocalRepository extends ITeamsRepository {
  static const String _jsonPath = "data/json/teams.json";
  bool _isInit = false;
  late final Teams _teams;

  @override
  Future<Teams> getTeams() async {
    if (!_isInit) {
      final Map<String, dynamic> json = await _readJson(_jsonPath);
      _teams = Teams.fromJson(json);
      _isInit = true;
    }
    return _teams;
  }

  Future<Map<String, dynamic>> _readJson(String path) async {
    final File file = File(path);
    final String jsonString = await file.readAsString();
    return jsonDecode(jsonString);
  }
}
