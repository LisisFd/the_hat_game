import 'package:core_get_it/core_get_it.dart';

import 'domain.dart';

extension TeamsRepositoryFeature on ServiceScope {
  void addTeamsRepository() {
    registerSingleton<ITeamsRepository>(TeamsLocalRepository());
  }
}
