//GENERATED BARREL FILE
import 'package:core_get_it/core_get_it.dart';

import 'interfaces/interfaces.dart';
import 'realizations/realizations.dart';

export './interfaces/interfaces.dart';
export './realizations/realizations.dart';

extension TeamsRepositoryFeature on ServiceScope {
  void addTeamsRepository() {
    registerSingleton<ITeamsRepository>(TeamsLocalRepository());
  }
}
