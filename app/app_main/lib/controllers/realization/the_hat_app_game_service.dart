import 'dart:async';

import 'package:app_main/domain/domain.dart';
import 'package:core_get_it/core_get_it.dart';
import 'package:core_storage/core_storage.dart';

import '../interfaces/interfaces.dart';

///TODO: remove storage settings, create repository
class TheHatGameService extends IGameService {
  late final ISettingService _settingService;
  late final IGameRepository _gameRepository;

  TheHatAppGame? _appGame;

  TheHatAppGame? get appGame => _appGame;

  @override
  List<Team> get teams => appGame?.teams ?? [];

  @override
  Duration get roundTime {
    Duration? savedTime = appGame?.roundTime;
    if (savedTime == null || savedTime == Duration.zero) {
      return _settingService.appSettings.value.timePlayerTurn;
    }
    return savedTime;
  }

  @override
  Lap? get currentLap => appGame?.currentLap;

  @override
  Team get currentTeam =>
      teams.isEmpty ? const Team(name: 'null') : teams.first;

  @override
  int get countOfPlayers => _appGame?.playersCount ?? 2;

  @override
  int get countWordsOnPlayer =>
      _appGame?.countWordsOnPlayer ??
      _settingService.appSettings.value.countWordsOnPlayer;

  @override
  List<String> get words => _appGame?.words ?? [];

  @override
  bool get gameIsReady =>
      countOfPlayers * countWordsOnPlayer - words.length == 1;

  @override
  String get word => words.isNotEmpty ? words.first : '';

  TheHatGameService(
      {required IGameRepository gameRepository,
      required ISettingService settingService}) {
    _settingService = settingService;
    _gameRepository = gameRepository;
  }

  Future<void> init() async {
    await _initGame();
  }

  Future<void> _initGame() async {
    _appGame = await _gameRepository.getGame();
  }

  @override
  void setUpGameTeams(List<Team> teams, int countOfPlayers) {
    TheHatAppGame game = TheHatAppGame(
      teams: teams,
      playersCount: countOfPlayers,
      countWordsOnPlayer: _settingService.appSettings.value.countWordsOnPlayer,
      roundTime: _settingService.appSettings.value.timePlayerTurn,
    );
    _saveGame(game);
  }

  @override
  void addWord(String word) {
    List<String> currentWords = words.toList();
    currentWords.add(word);
    currentWords.shuffle();
    TheHatAppGame? game = _appGame?.copyWith(words: currentWords);
    _saveGame(game);
  }

  @override
  void updateGame({Duration? time, int? pointPlus}) {
    int currentTeamIndex = teams.indexWhere((t) => t.name == currentTeam.name);
    teams.insert(
      currentTeamIndex,
      currentTeam.copyWith(
        points: currentTeam.points + (pointPlus ?? 0),
      ),
    );
    _appGame = _appGame?.copyWith(roundTime: time);
  }

  @override
  void saveGame() {
    _saveGame(_appGame);
  }

  void _saveGame(TheHatAppGame? game) {
    if (game != null) {
      _gameRepository.setGame(game);
    }
    _appGame = game;
  }

  @override
  void updateWord() {
    TheHatAppGame? game = _appGame;
    if (game == null) {
      return;
    }
    List<String> words = game.words.toList();
    List<String> skipWords = game.skipWords.toList();
    skipWords.add(words.removeAt(0));
    _appGame = _appGame?.copyWith(words: words, skipWords: skipWords);
  }
}

extension TheHatGameServiceFeatureExtension on ServiceScope {
  Future<IGameService> _serviceFactory() async {
    TheHatGameService service = TheHatGameService(
      gameRepository: get<IGameRepository>(),
      settingService: get<ISettingService>(),
    );
    await service.init();
    return service;
  }

  void addTheHatGameServiceFeature() {
    registerSingletonAsync(
      _serviceFactory,
      dependsOn: [
        IKeyValueStorage,
        ISettingService,
      ],
    );
  }
}
