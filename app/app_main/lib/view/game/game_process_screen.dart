import 'package:app_core/app_core.dart';
import 'package:app_main/controllers/controllers.dart';
import 'package:app_main/view/view.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:core_get_it/core_get_it.dart';

import '../../domain/domain.dart';

const _semanticOne = 1;

class GameProcessScreen extends StatefulWidget {
  const GameProcessScreen({super.key});

  static Widget pageBuilder(
      BuildContext context, PageArgumentsGeneric arguments) {
    return const GameProcessScreen();
  }

  @override
  State<GameProcessScreen> createState() => _GameProcessScreenState();
}

class _GameProcessScreenState extends State<GameProcessScreen> {
  final IGameService _gameService = getWidgetService<IGameService>();
  final GlobalKey<TimerWidgetState> _timerKey = GlobalKey<TimerWidgetState>();
  final GlobalKey<TransitionContainerState> _animKey =
      GlobalKey<TransitionContainerState>();

  TimerWidgetState? get _timer => _timerKey.currentState;

  TransitionContainerState? get _anim => _animKey.currentState;

  bool get _isTicking => _timer?.isTicking ?? false;

  Team get _currentTeam => _gameService.currentTeam;

  String get word => _gameService.word;

  void _startGame() {
    setState(() {
      _timer?.start();
    });
  }

  void _stopGame() {
    setState(() {
      _timer?.stop();
      _gameService.saveGame();
    });
  }

  void _onStopTimer(Duration timerTime) {
    _gameService.updateGame(time: timerTime);
  }

  void _right() {
    setState(() {
      _anim?.start();
      _gameService.updateGame(pointPlus: _semanticOne);
    });
  }

  void _newWord() {
    setState(() {
      _gameService.updateGame(pointPlus: _semanticOne);
    });
  }

  ///TODO: add theme
  @override
  Widget build(BuildContext context) {
    return MyAppWrap(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text(_currentTeam.name),
                Text(_currentTeam.points.toString()),
              ],
            ),
            Container(
              decoration: BoxDecoration(color: Colors.blue),
              child: TransitionContainer(
                key: _animKey,
              ),
            ),
            RawMaterialButton(
              child: SizedBox(
                width: 150,
                height: 150,
              ),
              onPressed: () {
                _right();
              },
              elevation: 2.0,
              fillColor: Colors.white,
              shape: const CircleBorder(),
            ),
            Row(
              children: [
                TimerWidget(
                  key: _timerKey,
                  onStop: (Duration timer) {},
                  currentDuration: _gameService.roundTime,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
