import 'package:app_core/app_core.dart';
import 'package:app_main/controllers/controllers.dart';
import 'package:app_main/view/view.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:core_get_it/core_get_it.dart';

import '../../models/models.dart';

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
  final IGameService _gameService = getWidgetService<IGameService>();

  Rules _getCurrentRule() {
    Rules result = Rules.alias;
    Lap? lap = _gameService.currentLap;
    if (lap != null) {
      switch (lap) {
        case Lap.first:
          result = Rules.alias;
          break;
        case Lap.second:
          result = Rules.oneWord;
          break;
        case Lap.third:
          result = Rules.crocodile;
          break;
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    Rules rules = _getCurrentRule();
    return MyAppWrap(
      body: Column(
        children: [
          rules.widget,
          const Text('OK'),
        ],
      ),
    );
  }
}
