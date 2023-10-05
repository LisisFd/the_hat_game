import 'dart:convert';
import 'dart:developer';

import 'package:app_main/domain/interfaces/i_teams_repository.dart';
import 'package:core_flutter/core_flutter.dart';

import '../entities/entities.dart';

class TeamsLocalRepository extends ITeamsRepository {
  static const String _jsonPath = "data/json/teams.json";
  bool _isInit = false;
  late final Teams _teams;

  @override
  Future<List<String>> getTeamsByLocale(String locale) async {
    String currentLocale = locale.substring(0, 2);
    if (!_isInit) {
      await getTeams();
    }
    if (currentLocale == 'ru') {
      return _teams.ru;
    } else if (currentLocale == 'uk') {
      return _teams.ua;
    } else {
      return _teams.en;
    }
  }

  @override
  Future<Teams> getTeams() async {
    Map<String, dynamic> json = {};

    try {
      json = await _readJson(_jsonPath);
      _teams = Teams.fromJson(json);
      _isInit = true;
    } catch (e) {
      log('Invalid reading teams operation');
    }

    return _teams;
  }

  Future<Map<String, dynamic>> _readJson(String path) async {
    final String jsonString = await rootBundle.loadString(path);
    return jsonDecode(jsonString);
  }
}
