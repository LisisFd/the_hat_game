import 'package:core_flutter/core_flutter.dart';

class PreGameScreen extends StatefulWidget {
  const PreGameScreen({super.key});

  static Widget pageBuilder(
      BuildContext context, PageArgumentsGeneric arguments) {
    return const PreGameScreen();
  }

  @override
  State<PreGameScreen> createState() => _PreGameScreenState();
}

class _PreGameScreenState extends State<PreGameScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder(
      child: Text('PreGame'),
    );
  }
}
