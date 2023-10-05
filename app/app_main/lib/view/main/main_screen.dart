import 'package:app_core/app_core.dart';
import 'package:app_main/controllers/controllers.dart';
import 'package:app_main/localization.dart';
import 'package:app_main/navigation/navigation.dart';
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
    final localization = context.localization();
    final IGameRestoreFlow gameRestoreFlow = flowFactory.getFlow(context);
    final AppLocalizations localize = context.localization();
    final Size device = MediaQuery.of(context).size;
    double hatWidth =
        (device.width > device.height ? device.height : device.width) / 2;
    List<Widget> menu = [
      if (gameService.gameIsNotEmpty)
        ElevatedMenuButton(
          onPressed: gameRestoreFlow.restoreGame,
          child: Text(localization.btn_continue),
        ),
      ElevatedMenuButton(
        onPressed: () => RootAppNavigation.of(context).pushWithoutAnimation(
          appRoutes.teamsScreen(),
        ),
        child: Text(localize.btn_play),
      ),
      ElevatedMenuButton(
        onPressed: () => RootAppNavigation.of(context).pushWithoutAnimation(
          appRoutes.rulesScreen(),
        ),
        child: Text(localize.title_rules),
      ),
      ElevatedMenuButton(
        onPressed: () => RootAppNavigation.of(context).pushWithoutAnimation(
          appRoutes.settingsScreen(),
        ),
        child: Text(localize.title_settings),
      ),
    ];
    return MyAppWrap(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image(
              image: AppConfig.fillHatIcon,
              width: hatWidth,
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
