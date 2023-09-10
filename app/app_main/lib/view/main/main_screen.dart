import 'package:app_core/app_core.dart';
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
    return MyAppWrap(
        body: Center(
      child: SizedBox(
        width: 200,
        height: 200,
        child: Text(
          'Main Screen',
          style: TextStyle(fontSize: 40),
          textAlign: TextAlign.center,
        ),
      ),
    ));
  }
}
