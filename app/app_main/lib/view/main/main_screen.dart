import 'package:app_core/app_core.dart';
import 'package:app_main/localization.dart';
import 'package:app_main/navigation/navigation.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:core_get_it/core_get_it.dart';
import 'package:core_ui/core_ui.dart';

class MainScreen extends StatefulWidget {
  static Widget pageBuilder(
      BuildContext context, PageArgumentsGeneric arguments) {
    return const MainScreen();
  }

  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _routes = getWidgetService<AppRoutes>();

  @override
  Widget build(BuildContext context) {
    AppLocalizations localize = context.localization();
    List<Widget> menu = [
      MenuButton(
        onPressed: () => RootAppNavigation.of(context).push(
            _routes.teamsScreen(),
            transition: TransitionAnimations.disable()),
        child: Text(localize.screen_main_btn_play),
      ),
      MenuButton(
        onPressed: () => RootAppNavigation.of(context).push(
            _routes.rulesScreen(),
            transition: TransitionAnimations.disable()),
        child: Text(localize.screen_main_btn_rules),
      ),
      MenuButton(
        onPressed: () => RootAppNavigation.of(context).push(
            _routes.settingsScreen(),
            transition: TransitionAnimations.disable()),
        child: Text(localize.screen_main_btn_settings),
      ),
    ];
    return MyAppWrap(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...menu,
          ],
        ),
      ),
    );
  }
}
