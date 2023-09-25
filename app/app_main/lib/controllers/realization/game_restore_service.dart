import 'package:app_main/controllers/controllers.dart';
import 'package:app_main/domain/domain.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:core_get_it/core_get_it.dart';

class GameRestoreService extends IGameRestoreService {
  late final IGameRepository _gameRepository;

  GameRestoreService({required IGameRepository gameRepository}) {
    _gameRepository = gameRepository;
  }

  TheHatAppGame get _appGame => _gameRepository.getGame()!;

  @override
  FullRouteInfo restoreGame() {
    return [];
  }
}

extension GameRestoreServiceFeatureExtension on ServiceScope {
  Future<IGameRestoreService> _serviceFactory() async {
    IGameRestoreService service = GameRestoreService(
      gameRepository: get<IGameRepository>(),
    );
    return service;
  }

  void addGameRestoreServiceFeature() {
    registerSingletonWithDependencies(
      _serviceFactory,
      dependsOn: [
        IGameRepository,
      ],
    );
  }
}
