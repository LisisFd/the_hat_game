import 'package:app_core/app_core.dart';
import 'package:app_main/controllers/controllers.dart';
import 'package:app_main/domain/domain.dart';
import 'package:core_get_it/core_get_it.dart';

class TeamsService extends ITeamsService {
  late final ITeamsRepository _teamsRepository;
  late final ILocaleRepository _localeRepository;
  late final AppSubjectContext _appSubjectContext;
  List<Team> _teams = [];

  @override
  List<Team> get teams => _teams;

  TeamsService({
    required ITeamsRepository teamsRepository,
    required ILocaleRepository localeRepository,
    required AppSubjectContext appSubjectContext,
  }) {
    _teamsRepository = teamsRepository;
    _localeRepository = localeRepository;
    _appSubjectContext = appSubjectContext;
  }

  Future<void> init() async {
    _localeRepository.localeUpdater.subscribe(_appSubjectContext.appContext,
        (appLocale) {
      _initTeams(appLocale?.locale);
    });
    await _initTeams(_localeRepository.localeUpdater.value?.locale);
  }

  Future<void> _initTeams(String? locale) async {
    _teams = [];
    List<String> repoTeams =
        await _teamsRepository.getTeamsByLocale(locale ?? AppConfig.defLocale);
    _teams = repoTeams.map((t) => Team(name: t)).toList();
  }
}

extension TeamsServiceFeatureExtension on ServiceScope {
  Future<ITeamsService> _serviceFactory() async {
    TeamsService service = TeamsService(
      teamsRepository: get<ITeamsRepository>(),
      localeRepository: get<ILocaleRepository>(),
      appSubjectContext: get<AppSubjectContext>(),
    );
    await service.init();
    return service;
  }

  void addTeamsServiceFeature() {
    registerSingletonAsync<ITeamsService>(_serviceFactory,
        dependsOn: [ILocaleRepository]);
  }
}
