import 'package:core_flutter/core_flutter.dart';
import 'package:core_ui/core_ui.dart';

class MainScreenArguments {}

class MainScreen extends StatelessWidget {
  static Widget pageBuilder(
      BuildContext context, PageArgumentsGeneric arguments) {
    return const MainScreen();
  }

  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppWrap(
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
