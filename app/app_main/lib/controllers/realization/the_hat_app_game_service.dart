import 'dart:async';

import 'package:app_main/domain/domain.dart';
import 'package:core_get_it/core_get_it.dart';
import 'package:core_storage/core_storage.dart';

import '../interfaces/interfaces.dart';

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
  List<Word> get words =>
      _appGame?.words.where((w) => w.status == WordStatus.active).toList() ??
      [];

  @override
  List<Word> get wordsWithStatus => _appGame?.words ?? [];

  @override
  bool get gameIsReady =>
      countOfPlayers * countWordsOnPlayer - words.length == 1;

  @override
  Word get word => words.isNotEmpty ? words.first : Word.create(word: '');

  @override
  bool get gameIsNotEmpty => _appGame != null;

  TheHatGameService(
      {required IGameRepository gameRepository,
      required ISettingService settingService}) {
    _settingService = settingService;
    _gameRepository = gameRepository;
    _init();
  }

  void _init() {
    _appGame = _gameRepository.getGame();
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
    List<Word> currentWords = words.toList();
    currentWords.add(
      Word.create(word: word),
    );
    currentWords.shuffle();
    TheHatAppGame? game = _appGame?.copyWith(words: currentWords);
    _saveGame(game);
  }

  @override
  void updateGame({Duration? time, int? pointPlus, List<Word>? words}) {
    int currentTeamIndex = teams.indexWhere((t) => t.name == currentTeam.name);
    teams[currentTeamIndex] = teams[currentTeamIndex].copyWith(
      points: currentTeam.points + (pointPlus ?? 0),
    );
    _appGame = _appGame?.copyWith(roundTime: time, teams: teams, words: words);
  }

  @override
  void saveGame() {
    _saveGame(_appGame);
  }

  @override
  void deleteGame() {
    _deleteGame();
  }

  void _saveGame(TheHatAppGame? game) {
    if (game != null) {
      _gameRepository.setGame(game);
    }
    _appGame = game;
  }

  void _deleteGame() {
    _gameRepository.setGame(null);
    _appGame = null;
  }

  @override
  void updateWord(isRight) {
    TheHatAppGame? game = _appGame;
    if (game == null) {
      return;
    }
    List<Word> currentWords = game.words.toList();
    int indexWord = currentWords.indexWhere((w) => w.id == word.id);
    if (isRight) {
      currentWords[indexWord] =
          currentWords[indexWord].copyWith(status: WordStatus.right);
    } else {
      currentWords[indexWord] =
          currentWords[indexWord].copyWith(status: WordStatus.skip);
    }

    _appGame = _appGame?.copyWith(words: currentWords);
  }
}

extension TheHatGameServiceFeatureExtension on ServiceScope {
  Future<IGameService> _serviceFactory() async {
    TheHatGameService service = TheHatGameService(
      gameRepository: get<IGameRepository>(),
      settingService: get<ISettingService>(),
    );
    return service;
  }

  void addTheHatGameServiceFeature() {
    registerSingletonWithDependencies(
      _serviceFactory,
      dependsOn: [
        IKeyValueStorage,
        ISettingService,
      ],
    );
  }
}
