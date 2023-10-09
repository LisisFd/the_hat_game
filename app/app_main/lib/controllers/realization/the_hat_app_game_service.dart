import 'package:app_main/domain/domain.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:core_get_it/core_get_it.dart';
import 'package:core_storage/core_storage.dart';
import 'package:core_utils/core_utils.dart';

import '../interfaces/interfaces.dart';

class TheHatGameService extends IGameService {
  late final ISettingService _settingService;
  late final IGameRepository _gameRepository;
  late final AppLifeStyleRepository _appLifeStyleRepository;

  final ManualSubjectContext _context = ManualSubjectContext();

  final BehaviorSubject<TheHatAppGame> _appGame =
      BehaviorSubject.alwaysUpdate(null);

  @override
  IBehaviorSubjectReadonly<TheHatAppGame> get appGame => _appGame;

  @override
  List<Team> get teams => appGame.value?.teams ?? [];

  @override
  GameState get gameState => appGame.value?.gameState ?? GameState.values.first;

  @override
  bool get generalLastWord => appGame.value?.generalLastWordGame ?? false;

  @override
  Duration get roundTime {
    Duration? savedTime = appGame.value?.roundTime;
    if (savedTime == null || savedTime == Duration.zero) {
      return _settingService.appSettings.value.timePlayerTurn;
    }
    return savedTime;
  }

  @override
  Lap get currentLap => appGame.value?.currentLap ?? Lap.first;

  @override
  Team get currentTeam =>
      teams.isEmpty ? const Team(name: 'null') : teams.first;

  @override
  int get countOfPlayers => _appGame.value?.playersCount ?? 2;

  @override
  int get countWordsOnPlayer =>
      _appGame.value?.countWordsOnPlayer ??
      _settingService.appSettings.value.countWordsOnPlayer;

  @override
  List<Word> get words =>
      _appGame.value?.words
          .where((w) => w.status == WordStatus.active)
          .toList() ??
      [];

  @override
  List<Word> get wordsWithStatus => _appGame.value?.words ?? [];

  @override
  bool get gameIsReady =>
      countOfPlayers * countWordsOnPlayer - words.length == 1;

  @override
  Word get word => words.isNotEmpty ? words.first : Word.create(word: '');

  @override
  bool get gameIsNotEmpty => _appGame.value != null;

  TheHatGameService(
      {required AppLifeStyleRepository appLifeStyleRepository,
      required IGameRepository gameRepository,
      required ISettingService settingService}) {
    _settingService = settingService;
    _gameRepository = gameRepository;
    _appLifeStyleRepository = appLifeStyleRepository;
    _init();
  }

  void _init() {
    _appGame.setValue(_gameRepository.getGame());
    _appLifeStyleRepository.appState.subscribe(_context, (value) {
      if (_appGame.value?.currentScreen != CurrentScreen.process) {
        saveGame();
      }
    });
  }

  @override
  void setUpGameTeams(List<Team> teams, int countOfPlayers) {
    TheHatAppGame game = TheHatAppGame(
      teams: teams,
      playersCount: countOfPlayers,
      countWordsOnPlayer: _settingService.appSettings.value.countWordsOnPlayer,
      roundTime: _settingService.appSettings.value.timePlayerTurn,
      generalLastWordGame: _settingService.appSettings.value.lastWord,
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
    TheHatAppGame? game = _appGame.value?.copyWith(words: currentWords);
    game?.words.shuffle();
    _saveGame(game);
  }

  @override
  void updateGame({
    GameState? gameState,
    Duration? time,
    int? pointPlus,
    List<Word>? words,
    Team? anotherTeam,
    bool isLast = false,
  }) {
    int currentTeamIndex = teams.indexWhere((t) => t.name == currentTeam.name);
    Team team = currentTeam;
    if (anotherTeam != null) {
      currentTeamIndex = teams.indexWhere((t) => t.name == anotherTeam?.name);
      team = anotherTeam;
      pointPlus ??= 1;
      anotherTeam =
          anotherTeam.copyWith(points: anotherTeam.points + pointPlus);
    } else if (isLast) {
      currentTeamIndex =
          teams.indexWhere((t) => t.name == _appGame.value?.lastWordTeam?.name);
      if (currentTeamIndex != -1) {
        anotherTeam = _appGame.value!.lastWordTeam!;
        team = anotherTeam;
      }
    }
    team = team.copyWith(points: team.points + (pointPlus ?? 0));
    teams[currentTeamIndex] = teams[currentTeamIndex].copyWith(
      points: team.points,
    );
    anotherTeam ??= _appGame.value?.lastWordTeam;
    _appGame.setValue(
      _appGame.value?.copyWith(
        gameState: gameState,
        roundTime: time,
        teams: teams,
        words: words,
        lastWordTeam: isLast ? null : anotherTeam,
      ),
    );
  }

  @override
  void saveGame() {
    _saveGame(
      _appGame.value,
    );
  }

  @override
  void deleteGame() {
    _deleteGame();
  }

  void _saveGame(
    TheHatAppGame? game,
  ) {
    if (game != null) {
      _gameRepository.setGame(game);
    }
    _appGame.setValue(game);
  }

  void _deleteGame() {
    _gameRepository.setGame(null);
    _appGame.setValue(null);
  }

  @override
  void updateWord(isRight, [Team? anotherTeam]) {
    TheHatAppGame? game = _appGame.value;
    if (game == null) {
      return;
    }
    if (anotherTeam?.name == currentTeam.name) {
      anotherTeam = null;
    }
    List<Word> currentWords = game.words.toList();
    int indexWord = currentWords.indexWhere((w) => w.id == word.id);
    if (isRight) {
      currentWords[indexWord] = currentWords[indexWord]
          .copyWith(status: WordStatus.right, isLastWord: anotherTeam != null);
    } else {
      currentWords[indexWord] =
          currentWords[indexWord].copyWith(status: WordStatus.skip);
    }
    updateGame(words: currentWords, anotherTeam: anotherTeam);
  }

  @override
  void setNewScreen(CurrentScreen newScreen) {
    if (_appGame.value?.currentScreen != newScreen) {
      _appGame.setValue(
        _appGame.value?.copyWith(
          currentScreen: newScreen,
        ),
      );
      saveGame();
    }
  }

  @override
  void setNewLap() {
    int currentLapIndex = Lap.values.indexOf(currentLap);
    if (currentLapIndex >= Lap.values.length - 1) return;
    TheHatAppGame? game =
        _appGame.value?.copyWith(currentLap: Lap.values[currentLapIndex + 1]);
    if (game == null) return;
    game.words.shuffle();
    _appGame.setValue(game);
  }

  @override
  void changeCurrentTeam() {
    if (teams.isEmpty) return;
    List<Team> updateTeams = teams.toList();
    updateTeams.add(updateTeams.removeAt(0));
    TheHatAppGame? game = _appGame.value?.copyWith(teams: updateTeams);
    if (game == null) return;
    _appGame.setValue(game);
  }
}

extension TheHatGameServiceFeatureExtension on ServiceScope {
  IGameService _serviceFactory() {
    TheHatGameService service = TheHatGameService(
      appLifeStyleRepository: get<AppLifeStyleRepository>(),
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
