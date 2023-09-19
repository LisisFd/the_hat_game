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
  Lap? get currentLap => appGame?.currentLap;

  TheHatGameService(
      {required IGameRepository gameRepository,
      required ISettingService settingService}) {
    _settingService = settingService;
    _gameRepository = gameRepository;
  }

  Future<void> init() async {
    await _initGame();
  }

  @override
  void setUpGameTeams(List<Team> teams, int countOfPlayers) {
    TheHatAppGame game = TheHatAppGame(
        teams: teams,
        playersCount: countOfPlayers,
        countWordsOnPlayer:
            _settingService.appSettings.value.countWordsOnPlayer);
    _appGame = game;
    _gameRepository.setGame(game);
  }

  Future<void> _initGame() async {
    _appGame = await _gameRepository.getGame();
  }

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

  // TODO add isolate
  @override
  void addWord(String word) {
    List<String> currentWords = words.toList();
    currentWords.add(word);
    TheHatAppGame? game = _appGame?.copyWith(words: currentWords);
    if (game != null) {
      _gameRepository.setGame(game);
    }
    _appGame = game;
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
