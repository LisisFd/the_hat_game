import 'package:app_core/app_core.dart';
import 'package:app_main/localization.dart';
import 'package:core_flutter/core_flutter.dart';

class MainScreenArguments {}

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
  @override
  Widget build(BuildContext context) {
    AppLocalizations localize = context.localization();
    List<Widget> menu = [
      MenuButton(
        onPressed: () {},
        child: Text(localize.screen_main_btn_play),
      ),
      MenuButton(
        onPressed: () {},
        child: Text(localize.screen_main_btn_rules),
      ),
      MenuButton(
        onPressed: () {},
        child: Text(localize.screen_main_btn_settings),
      ),
    ];
    return MyAppWrap(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: menu,
        ),
      ),
    );
  }
}
