import 'package:app_core/app_core.dart';
import 'package:app_main/controllers/controllers.dart';
import 'package:app_main/navigation/app_routes.dart';
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
  final AppRoutes _appRoutes = getWidgetService<AppRoutes>();
  final GlobalKey<TimerWidgetState> _timerKey = GlobalKey<TimerWidgetState>();
  final GlobalKey<TransitionContainerState> _animKey =
      GlobalKey<TransitionContainerState>();

  TimerWidgetState? get _timer => _timerKey.currentState;

  bool _isTickingEnded = false;

  Team get _currentTeam => _gameService.currentTeam;

  Word get _word => _gameService.word;

  bool get _isLast => _gameService.words.length == 1;

  bool isStart = false;
  bool isPaused = false;

  @override
  void initState() {
    if (_gameService.currentScreen != CurrentScreen.process) {
      _gameService.updateGame(newScreen: CurrentScreen.process);
      _gameService.saveGame();
    }
    _initGame();
    super.initState();
  }

  void _initGame() {
    if (_gameService.gameState == GameState.start) {
      return;
    }
    setState(() {
      if (_gameService.gameState == GameState.paused) {
        isStart = true;
        isPaused = true;
      } else {
        isStart = true;
        _isTickingEnded = true;
      }
    });
  }

  void _startGame() {
    setState(() {
      _timer?.start();
      isStart = true;
    });
  }

  void _stopGame() {
    setState(() {
      isPaused = true;
      _timer?.stop();
      _gameService.updateGame(gameState: GameState.paused);
      _gameService.saveGame();
    });
  }

  void _playGame() {
    setState(() {
      isPaused = false;
      _timer?.start();
    });
  }

  void _onStopTimer(Duration timerTime) {
    setState(() {
      _gameService.updateGame(time: timerTime);
      if (timerTime == Duration.zero) {
        _gameService.updateGame(gameState: GameState.lastWord);
        _gameService.saveGame();
        setState(() {
          _isTickingEnded = true;
        });
      }
    });
  }

  void _checkWord(bool right) {
    if (right) {
      _gameService.updateGame(pointPlus: _semanticOne);
    }

    if (_isLast || _isTickingEnded) {
      _gameService.updateWord(right);
      _gameService.saveGame();
      RootAppNavigation.of(context).pushReplacement(_appRoutes.teamResult());
    } else {
      setState(() {
        _gameService.updateWord(right);
      });
    }
  }

  Future<bool> _onWillPop() async {
    if (_gameService.gameState != GameState.lastWord) {
      _gameService.updateGame(gameState: GameState.paused);
      _timer?.stop();
      _gameService.saveGame();
    }
    return true;
  }

  ///TODO: add theme
  @override
  Widget build(BuildContext context) {
    Widget wordWidget = TransitionContainer(
      key: _animKey,
      color: Colors.redAccent,
      onSkip: _checkWord,
      child: Text(key: ValueKey(_word.id), _word.word),
    );

    Widget buttonWidget = RawMaterialButton(
      onPressed: !isStart
          ? _startGame
          : isPaused
              ? _playGame
              : null,
      elevation: 2.0,
      fillColor: isPaused ? Colors.grey : Colors.redAccent,
      shape: const CircleBorder(),
      child: const SizedBox(
        width: 150,
        height: 150,
      ),
    );

    Widget centerWidget = isStart && !isPaused ? wordWidget : buttonWidget;
    Widget stopWidget = isStart && !isPaused && !_isTickingEnded
        ? RawMaterialButton(
            onPressed: _stopGame,
            elevation: 2.0,
            fillColor: isPaused ? Colors.grey : Colors.redAccent,
            shape: const CircleBorder(),
            child: const Text('Stop'),
          )
        : const SizedBox();
    Widget timerWidget = !_isTickingEnded
        ? TimerWidget(
            key: _timerKey,
            onStop: _onStopTimer,
            currentDuration: _gameService.roundTime,
          )
        : const Text('Last word');
    return WillPopScope(
      onWillPop: _onWillPop,
      child: MyAppWrap(
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
              centerWidget,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [const SizedBox(), timerWidget, stopWidget],
              )
            ],
          ),
        ),
      ),
    );
  }
}
