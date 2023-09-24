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
  void addGameRepository() {
    registerSingletonWithDependencies<IGameRepository>(
        () => GameLocalRepository(storage: get<IKeyValueStorage>()),
        dependsOn: [IKeyValueStorage]);
  }
}

extension SettingsRepositoryFeature on ServiceScope {
  void addSettingsRepository() {
    registerSingletonWithDependencies<ISettingsRepository>(
        () => SettingsLocalRepository(storage: get<IKeyValueStorage>()),
        dependsOn: [IKeyValueStorage]);
  }
}
