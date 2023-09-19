import 'package:app_main/controllers/controllers.dart';
import 'package:app_main/domain/domain.dart';
import 'package:core_get_it/core_get_it.dart';
import 'package:core_storage/core_storage.dart';

///TODO: remove storage settings, create repository
class TheHatGameService extends IGameService {
  static const String _storageKeyGame = "current.game";

  late final ISettingService _settingService;

  late final ITeamsRepository _teamsRepository;
  late final IKeyValueStorage _storage;

  late final List<Team> _teams;
  TheHatAppGame? _appGame;

  TheHatAppGame? get appGame => _appGame;

  @override
  Lap? get currentLap => appGame?.currentLap;

  TheHatGameService(
      {required IKeyValueStorage storage,
      required ITeamsRepository teamsRepository,
      required ISettingService settingService}) {
    _settingService = settingService;
    _teamsRepository = teamsRepository;
    _storage = storage;
  }

  Future<void> init() async {
    await _initTeams();
    await _initGame();
  }

  @override
  void setUpGameTeams(List<Team> teams, int countOfPlayers) {
    _appGame = TheHatAppGame(
        teams: teams,
        playersCount: countOfPlayers,
        countWordsOnPlayer:
            _settingService.appSettings.value.countWordsOnPlayer);

    _writeGame();
  }

  @override
  List<Team> get teams => _teams;

  Future<void> _initGame() async {
    _appGame = await _storage.read(_storageKeyGame, TheHatAppGame.fromJson);
  }

  Future<void> _initTeams() async {
    List<String> repoTeams = await _teamsRepository.getTeamsByLocale('');
    _teams = repoTeams.map((t) => Team(name: t)).toList();
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
    _appGame = _appGame?.copyWith(words: currentWords);
    _writeGame();
  }

  void _writeGame() async {
    final currentGame = _appGame;
    if (currentGame != null) {
      await _storage.write(_storageKeyGame, currentGame);
    }
  }
}

extension TheHatGameServiceFeatureExtension on ServiceScope {
  Future<IGameService> _serviceFactory() async {
    TheHatGameService service = TheHatGameService(
      storage: get<IKeyValueStorage>(),
      teamsRepository: get<ITeamsRepository>(),
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
