import 'package:app_core/app_core.dart';
import 'package:app_main/controllers/controllers.dart';
import 'package:app_main/localization.dart';
import 'package:app_main/navigation/navigation.dart';
import 'package:app_main/view/view.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:core_get_it/core_get_it.dart';

class MainScreen extends StatefulWidget {
  static Widget pageBuilder(
      BuildContext context, PageArgumentsGeneric arguments) {
    return const MainScreen();
  }

  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SubjectWidgetContext {
  final IGameService _gameService = getWidgetService<IGameService>();
  final IAppLocaleService _appLocaleService =
      getWidgetService<IAppLocaleService>();
  final AppRoutes _appRoutes = getWidgetService<AppRoutes>();
  final FlowFactory _flowFactory = getWidgetService<FlowFactory>();

  @override
  void initState() {
    super.initState();
    listen(_gameService.appGame);
  }

  @override
  Widget build(BuildContext context) {
    final localization = context.localization();
    final IGameRestoreFlow gameRestoreFlow = _flowFactory.getFlow(context);
    final AppLocalizations localize = context.localization();
    final Size device = MediaQuery.of(context).size;
    double hatWidth =
        (device.width > device.height ? device.height : device.width) / 2;
    double flagWidth = hatWidth / 2.5;
    List<Widget> menu = [
      if (_gameService.gameIsNotEmpty)
        ElevatedMenuButton(
          onPressed: gameRestoreFlow.restoreGame,
          child: Text(localization.btn_continue),
        ),
      ElevatedMenuButton(
        onPressed: () => RootAppNavigation.of(context).pushWithoutAnimation(
          _appRoutes.teamsScreen(),
        ),
        child: Text(localize.btn_play),
      ),
      ElevatedMenuButton(
        onPressed: () => RootAppNavigation.of(context).pushWithoutAnimation(
          _appRoutes.rulesScreen(),
        ),
        child: Text(localize.title_rules),
      ),
      ElevatedMenuButton(
        onPressed: () => RootAppNavigation.of(context).pushWithoutAnimation(
          _appRoutes.settingsScreen(),
        ),
        child: Text(localize.title_settings),
      ),
    ];
    return MyAppWrap(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              children: [
                Image(
                  image: AppConfig.fillHatIcon,
                  width: hatWidth,
                ),
                Positioned(
                  right: flagWidth / 1.3,
                  bottom: flagWidth / 1.6,
                  child: IconButton(
                    color: ThemeConstants.lightBackground,
                    onPressed: () async {
                      Locale? locale = await FlagsDialog.show(context);
                      if (locale == null) return;
                      _appLocaleService.updateLocale(locale);
                    },
                    icon: Image(
                      image: AppConfig.flagUaEn,
                      width: flagWidth,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: menu,
            ),
          ],
        ),
      ),
    );
  }
}
