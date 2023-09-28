import 'package:app_main/domain/repositories/settings_local_repository.dart';
import 'package:core_get_it/core_get_it.dart';
import 'package:core_storage/core_storage.dart';

import 'domain.dart';

extension TeamsRepositoryFeature on ServiceScope {
  void addTeamsRepository() {
    registerSingleton<ITeamsRepository>(TeamsLocalRepository());
  }
}

extension GameRepositoryFeature on ServiceScope {
  Future<IGameRepository> _serviceFactory() async {
    GameLocalRepository service =
        GameLocalRepository(storage: get<IKeyValueStorage>());
    await service.init();
    return service;
  }

  void addGameRepository() {
    registerSingletonAsync(
      _serviceFactory,
      dependsOn: [
        IKeyValueStorage,
      ],
    );
  }
}

extension SettingsRepositoryFeature on ServiceScope {
  void addSettingsRepository() {
    registerSingletonWithDependencies<ISettingsRepository>(
        () => SettingsLocalRepository(storage: get<IKeyValueStorage>()),
        dependsOn: [IKeyValueStorage]);
  }
}
