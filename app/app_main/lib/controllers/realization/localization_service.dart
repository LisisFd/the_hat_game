import 'package:app_core/app_core.dart';
import 'package:app_main/domain/domain.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:core_get_it/core_get_it.dart';
import 'package:core_localization/core_localization.dart';
import 'package:core_utils/core_utils.dart';

import '../interfaces/interfaces.dart';

class AppLocaleService extends IAppLocaleService {
  late final ILocaleRepository _localeRepository;
  late final LocalizationService _localizationService;

  final BehaviorSubject<AppLocale> _appLocale =
      BehaviorSubject.updateNotEqual();

  @override
  IBehaviorSubjectReadonly<AppLocale?> get appLocale => _appLocale;

  @override
  Locale get locale => Locale(appLocale.value?.locale ?? AppConfig.defLocale);

  AppLocaleService({
    required ILocaleRepository localeRepository,
    required LocalizationService localizationService,
  }) {
    _localeRepository = localeRepository;
    _localizationService = localizationService;
  }

  Future<void> init() async {
    await _initLocale();
  }

  @override
  void updateLocale(Locale newLocale, [bool? sR]) {
    AppLocale? currentLocale =
        _appLocale.value?.copyWith(locale: newLocale.toString(), sR: sR);
    currentLocale ??= AppLocale(locale: newLocale.toString(), sR: sR ?? false);
    _appLocale.setValue(currentLocale);
    _localeRepository.setLocale(currentLocale);
  }

  Future<void> _initLocale() async {
    _appLocale.setValue(await _localeRepository.getLocale());
    List<Locale> supportedLocales = _localizationService.supportedLocales;
    String? currentLocale = _appLocale.value?.locale;
    bool? sR;
    Locale deviceLocale;
    if (currentLocale == null) {
      String? locale;
      if (!kIsWeb) {
        locale = DeviceLocaleService.getCountryCodeFromLocale();
      }
      String? ip = await DeviceLocaleService.getCountryCodeFromIp();
      if (locale != AppConfig.ua && ip != AppConfig.ua) {
        sR = true;
      }
      deviceLocale =
          Locale(ip?.toString() ?? locale?.toString() ?? AppConfig.defLocale);
      if (!supportedLocales.contains(deviceLocale)) {
        deviceLocale = const Locale(AppConfig.defLocale);
      }
    } else {
      deviceLocale = Locale(currentLocale);
    }

    updateLocale(deviceLocale, sR);

    _localeRepository.setLocale(_appLocale.value!);
  }
}

extension AppLocaleServiceFeatureExtension on ServiceScope {
  Future<IAppLocaleService> _serviceFactory() async {
    AppLocaleService service = AppLocaleService(
      localizationService: get<LocalizationService>(),
      localeRepository: get<ILocaleRepository>(),
    );
    await service.init();
    return service;
  }

  void addAppLocaleServiceFeature() {
    registerSingletonAsync<IAppLocaleService>(
      () async => await _serviceFactory(),
      dependsOn: [
        ILocaleRepository,
      ],
    );
  }
}
