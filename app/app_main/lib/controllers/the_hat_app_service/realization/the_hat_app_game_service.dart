import 'package:app_main/controllers/controllers.dart';
import 'package:app_main/domain/domain.dart';
import 'package:app_main/models/models.dart';
import 'package:core_get_it/core_get_it.dart';
import 'package:core_storage/core_storage.dart';

///TODO: remove storage settings, create repository
class TheHatGameService extends IGameService {
  static const String storageKeyGame = "current.game";

  late final ISettingService _settingService;

  late final ITeamsRepository _teamsRepository;
  late final IKeyValueStorage _storage;

  late final List<String> _teams;
  TheHatAppGame? _appGame;

  TheHatAppGame? get appGame => _appGame;

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
  void setUpGameTeams(List<String> teams, countOfPlayers) {
    _appGame = TheHatAppGame(
        teams: teams,
        playersCount: countOfPlayers,
        countWordsOnOnePlayer:
            _settingService.appSettings.value.countWordsOnPlayer);
  }

  @override
  List<String> get teams => _teams;

  Future<void> _initGame() async {
    _appGame = await _storage.read(storageKeyGame, TheHatAppGame.fromJson);
  }

  Future<void> _initTeams() async {
    _teams = await _teamsRepository.getTeamsByLocale('');
  }
}

extension TheHatGameServiceFeatureExtension on ServiceScope {
  Future<IGameService> _serviceFactory() async {
    TheHatGameService service = TheHatGameService(
      storage: get<IKeyValueStorage>(),
      teamsRepository: get<ITeamsRepository>(),
      settingService: get<ITheHatAppService>(),
    );
    await service.init();
    return service;
  }

  void addTheHatGameServiceFeature() {
    registerSingletonAsync(
      _serviceFactory,
      dependsOn: [
        IKeyValueStorage,
        ITeamsRepository,
        ITheHatAppService,
      ],
    );
  }
}
