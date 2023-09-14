import 'package:app_main/controllers/controllers.dart';
import 'package:app_main/models/models.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:core_get_it/core_get_it.dart';
import 'package:core_storage/core_storage.dart';
import 'package:core_utils/core_utils.dart';

class TheHatAppService extends ITheHatAppService {
  static const String storageKeyGame = "current.game";
  static const String storageKeySettings = "current.settings";

  final Logger _logger = Logger("TheHatAppService");

  final BehaviorSubject<TheHatAppSettings> _appSettings =
      BehaviorSubject<TheHatAppSettings>.updateNotNull(
          const TheHatAppSettings());

  @override
  IBehaviorSubjectReadonly<TheHatAppSettings> get appSettings => _appSettings;

  IKeyValueStorage storage;

  TheHatAppService({
    required this.storage,
  });

  @override
  Future<void> init() async {
    var settings =
        await storage.read(storageKeySettings, TheHatAppSettings.fromJson);
    settings ??= const TheHatAppSettings();
    _appSettings.setValue(settings);
    _logger.log(Level.INFO, 'TheHatAppService initialize');
  }

  @override
  void updateSettings(TheHatAppSettings newSettings) {
    _appSettings.setValue(newSettings);
    storage.write<TheHatAppSettings>(storageKeySettings, newSettings);
  }
}

extension TheHatAppServiceFeatureExtension on ServiceScope {
  Future<ITheHatAppService> _serviceFactory() async {
    ITheHatAppService service = TheHatAppService(
      storage: get<IKeyValueStorage>(),
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
