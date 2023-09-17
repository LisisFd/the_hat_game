import 'package:core_flutter/core_flutter.dart';

class WordsScreen extends StatefulWidget {
  static Widget pageBuilder(
      BuildContext context, PageArgumentsGeneric arguments) {
    return const WordsScreen();
  }

  const WordsScreen({super.key});

  @override
  State<WordsScreen> createState() => _WordsScreenState();
}

class _WordsScreenState extends State<WordsScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
}
