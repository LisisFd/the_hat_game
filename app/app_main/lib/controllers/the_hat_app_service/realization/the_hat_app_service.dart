import 'package:app_main/controllers/controllers.dart';
import 'package:app_main/domain/domain.dart';
import 'package:app_main/models/models.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:core_get_it/core_get_it.dart';
import 'package:core_storage/core_storage.dart';
import 'package:core_utils/core_utils.dart';

class TheHatAppService extends ITheHatAppService {
  static const String storageKeyGame = "current.game";
  static const String storageKeySettings = "current.settings";

  final IKeyValueStorage storage;
  final ITeamsRepository teamsRepository;

  final Logger _logger = Logger("TheHatAppService");

  late final Teams _teams;
  final BehaviorSubject<TheHatAppSettings> _appSettings =
      BehaviorSubject<TheHatAppSettings>.updateNotNull(
          const TheHatAppSettings());

  @override
  IBehaviorSubjectReadonly<TheHatAppSettings> get appSettings => _appSettings;

  @override
  Teams get teams => _teams;

  TheHatAppService({required this.storage, required this.teamsRepository});

  Future<void> init() async {
    await _initSettings();
    await _initTeams();
    _logger.log(Level.INFO, 'TheHatAppService initialize');
  }

  @override
  void updateSettings(TheHatAppSettings newSettings) {
    _appSettings.setValue(newSettings);
    storage.write<TheHatAppSettings>(storageKeySettings, newSettings);
  }

  Future<void> _initSettings() async {
    var settings =
        await storage.read(storageKeySettings, TheHatAppSettings.fromJson);
    settings ??= const TheHatAppSettings();
    _appSettings.setValue(settings);
  }

  Future<void> _initTeams() async {
    _teams = await teamsRepository.getTeams();
  }
}

extension TheHatAppServiceFeatureExtension on ServiceScope {
  Future<ITheHatAppService> _serviceFactory() async {
    TheHatAppService service = TheHatAppService(
      storage: get<IKeyValueStorage>(),
      teamsRepository: get<ITeamsRepository>(),
    );
    await service.init();
    return service;
  }

  void addTheHatAppServiceFeature() {
    registerSingletonAsync(
      _serviceFactory,
      dependsOn: [
        IKeyValueStorage,
      ],
    );
  }
}
