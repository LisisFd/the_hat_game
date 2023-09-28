import 'package:app_core/app_core.dart';
import 'package:app_main/controllers/controllers.dart';
import 'package:app_main/localization.dart';
import 'package:app_main/navigation/navigation.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:core_get_it/core_get_it.dart';

//TODO: add localization
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
  final IGameService gameService = getWidgetService<IGameService>();
  final AppRoutes appRoutes = getWidgetService<AppRoutes>();
  final FlowFactory flowFactory = getWidgetService<FlowFactory>();

  @override
  void initState() {
    super.initState();
    listen(gameService.appGame);
  }

  @override
  Widget build(BuildContext context) {
    final IGameRestoreFlow gameRestoreFlow = flowFactory.getFlow(context);
    final AppLocalizations localize = context.localization();
    final Size device = MediaQuery.of(context).size;
    double hatWidth =
        (device.width > device.height ? device.height : device.width) / 2;
    List<Widget> menu = [
      if (gameService.gameIsNotEmpty)
        MenuButton(
          onPressed: gameRestoreFlow.restoreGame,
          child: const Text('Continue'),
        ),
      MenuButton(
        onPressed: () => RootAppNavigation.of(context).pushWithoutAnimation(
          appRoutes.teamsScreen(),
        ),
        child: Text(localize.screen_main_btn_play),
      ),
      MenuButton(
        onPressed: () => RootAppNavigation.of(context).pushWithoutAnimation(
          appRoutes.rulesScreen(),
        ),
        child: Text(localize.screen_main_btn_rules),
      ),
      MenuButton(
        onPressed: () => RootAppNavigation.of(context).pushWithoutAnimation(
          appRoutes.settingsScreen(),
        ),
        child: Text(localize.screen_main_btn_settings),
      ),
    ];
    return MyAppWrap(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 110),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RotatedBox(
                quarterTurns: 2,
                child: Image(
                  image: AppConfig.fillHatIcon,
                  width: hatWidth,
                ),
              ),
              Column(
                children: menu,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
