import 'dart:convert';

import 'package:app_main/domain/interfaces/i_teams_repository.dart';
import 'package:core_flutter/core_flutter.dart';

import '../entities/entities.dart';

class TeamsLocalRepository extends ITeamsRepository {
  static const String _jsonPath = "data/json/teams.json";
  bool _isInit = false;
  late final Teams _teams;

  @override
  Future<List<String>> getTeamsByLocale(String locale) async {
    if (!_isInit) {
      await getTeams();
    }
    if (locale == 'en') {
      return _teams.en;
    } else if (locale == 'ua') {
      return _teams.ua;
    } else {
      return _teams.ru;
    }
  }

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
    final String jsonString = await rootBundle.loadString(path);
    return jsonDecode(jsonString);
  }
}
