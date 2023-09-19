import 'package:app_main/controllers/controllers.dart';
import 'package:app_main/domain/domain.dart';
import 'package:core_get_it/core_get_it.dart';

class TeamsService extends ITeamsService {
  late final ITeamsRepository _teamsRepository;
  final List<Team> _teams = [];

  @override
  List<Team> get teams => _teams;

  TeamsService({
    required ITeamsRepository teamsRepository,
  }) {
    _teamsRepository = teamsRepository;
  }

  Future<void> init() async {
    await _initTeams();
  }

  Future<void> _initTeams() async {
    List<String> repoTeams = await _teamsRepository.getTeamsByLocale('');
    _teams.addAll(repoTeams.map((t) => Team(name: t)));
  }
}

extension TeamsServiceFeatureExtension on ServiceScope {
  Future<ITeamsService> _serviceFactory() async {
    TeamsService service = TeamsService(
      teamsRepository: get<ITeamsRepository>(),
    );
    await service.init();
    return service;
  }

  void addTeamsServiceFeature() {
    registerSingletonAsync<ITeamsService>(
      _serviceFactory,
    );
  }
}
