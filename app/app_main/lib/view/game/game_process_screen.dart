import 'package:app_core/app_core.dart';
import 'package:app_main/controllers/controllers.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:core_get_it/core_get_it.dart';

import '../../domain/domain.dart';

class GameProcessScreen extends StatefulWidget {
  const GameProcessScreen({super.key});

  @override
  State<GameProcessScreen> createState() => _GameProcessScreenState();
}

class _GameProcessScreenState extends State<GameProcessScreen> {
  final IGameService _gameService = getWidgetService<IGameService>();

  Team get _currentTeam => _gameService.currentTeam;

  void _startGame() {}

  void _stopGame() {}

  void _resumeGame() {}

  ///TODO: add theme
  @override
  Widget build(BuildContext context) {
    return MyAppWrap(
      body: Column(
        children: [
          Text(_currentTeam.name),
          Text(_currentTeam.points.toString()),
          RawMaterialButton(
            onPressed: () {},
            elevation: 2.0,
            fillColor: Colors.white,
            shape: const CircleBorder(),
            child: const Icon(
              Icons.pause,
              size: 35.0,
            ),
          )
        ],
      ),
    );
  }
}
