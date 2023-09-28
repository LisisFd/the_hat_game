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

class _GameProcessScreenState extends State<GameProcessScreen>
    with SubjectWidgetContext {
  final IGameService _gameService = getWidgetService<IGameService>();
  final ISettingService _settingService = getWidgetService<ISettingService>();
  final AppRoutes _appRoutes = getWidgetService<AppRoutes>();
  final AppLifeStyleRepository _appLifeStyleRepository =
      getWidgetService<AppLifeStyleRepository>();
  final GlobalKey<TimerWidgetState> _timerKey = GlobalKey<TimerWidgetState>();
  final GlobalKey<TransitionContainerState> _animKey =
      GlobalKey<TransitionContainerState>();

  TimerWidgetState? get _timer => _timerKey.currentState;

  Team get _currentTeam => _gameService.currentTeam;

  Word get _word => _gameService.word;

  bool get _isLast => _gameService.words.length == 1;

  GameState get _gameState => _gameService.gameState;

  @override
  void initState() {
    _gameService.setNewScreen(CurrentScreen.process);
    _initGame();

    super.initState();
  }

  void _initGame() {
    listenWith(_appLifeStyleRepository.appState, () {
      setState(() {
        if (_gameState == GameState.play) {
          _timer?.stop();
          _gameService.updateGame(gameState: GameState.paused);
        }
        _gameService.saveGame();
      });
    });
  }

  void _startGame() {
    setState(() {
      _gameService.updateGame(gameState: GameState.play);
      _timer?.start();
    });
  }

  void _stopGame() {
    setState(() {
      _timer?.stop();
      _gameService.updateGame(gameState: GameState.paused);
      _gameService.saveGame();
    });
  }

  void _playGame() {
    setState(() {
      _gameService.updateGame(gameState: GameState.play);

      _timer?.start();
    });
  }

  void _onStopTimer(Duration timerTime) {
    if (_gameService.gameState == GameState.init) return;
    setState(() {
      _gameService.updateGame(time: timerTime);
      if (timerTime == Duration.zero) {
        setState(() {
          _gameService.updateGame(gameState: GameState.lastWord);
          _gameService.saveGame();
        });
      }
    });
  }

  void _checkWord(bool right) {
    if (right) {
      _gameService.updateGame(pointPlus: _semanticOne);
    }

    if (_isLast || _gameState == GameState.lastWord) {
      _gameService.updateGame(
          time: _settingService.appSettings.value.timePlayerTurn,
          gameState: GameState.init);
      _gameService.updateWord(right);
      _gameService.saveGame();
      _timer?.stop();
      RootAppNavigation.of(context)
          .pushReplacementWithoutAnimation(_appRoutes.teamResult());
    } else {
      setState(() {
        _gameService.updateWord(right);
      });
    }
  }

  Future<bool> _onWillPop() async {
    if (_gameService.gameState == GameState.play) {
      _gameService.updateGame(gameState: GameState.paused);
    }
    _timer?.stop();
    _gameService.saveGame();
    return true;
  }

  Widget _getButtonWidget() {
    void Function()? fn;
    Color color = Colors.grey;
    switch (_gameState) {
      case GameState.init:
        fn = _startGame;
        color = Colors.redAccent;
      case GameState.play:
        break;
      case GameState.paused:
        fn = _playGame;
      case GameState.lastWord:
        break;
    }
    return RawMaterialButton(
      onPressed: fn,
      elevation: 2.0,
      fillColor: color,
      shape: const CircleBorder(),
      child: const SizedBox(
        width: 150,
        height: 150,
      ),
    );
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

    Widget buttonWidget = _getButtonWidget();

    Widget centerWidget =
        _gameState == GameState.play || _gameState == GameState.lastWord
            ? wordWidget
            : buttonWidget;
    Widget stopWidget =
        _gameState == GameState.play && _gameState != GameState.lastWord
            ? RawMaterialButton(
                onPressed: _stopGame,
                elevation: 2.0,
                fillColor: _gameState == GameState.paused
                    ? Colors.grey
                    : Colors.redAccent,
                shape: const CircleBorder(),
                child: const Text('Stop'),
              )
            : const SizedBox();
    Widget timerWidget = _gameState != GameState.lastWord
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
