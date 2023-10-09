import 'package:app_core/app_core.dart';
import 'package:app_main/controllers/controllers.dart';
import 'package:app_main/localization.dart';
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

  bool get _helper => _settingService.appSettings.value.isFirstLaunch;
  bool _wordView = false;
  bool _startBounce = false;
  late bool _skipAnimation = !_settingService.appSettings.value.animation;

  @override
  void initState() {
    _gameService.setNewScreen(CurrentScreen.process);
    _initGame();
    super.initState();
  }

  void _initGame() {
    if (_gameState == GameState.paused || _gameState == GameState.lastWord) {
      _skipAnimation = true;
    }
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
      if (_skipAnimation) {
        _gameService.updateGame(gameState: GameState.play);
      } else {
        _startBounce = true;
      }
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
    });
  }

  void _onRotateComplete() {
    setState(() {
      _wordView = true;
      _skipAnimation = true;
      _timer?.start();
    });
  }

  void _onStopTimer(Duration timerTime) {
    if (_gameService.gameState == GameState.init) return;
    setState(() {
      _gameService.updateGame(time: timerTime);
      if (timerTime == Duration.zero) {
        _gameService.updateGame(gameState: GameState.lastWord);
        _gameService.saveGame();
      }
    });
  }

  void _checkWord(bool right) async {
    if (_isLast || _gameState == GameState.lastWord) {
      _timer?.stop();
      Team? anotherTeam;
      if (_gameService.generalLastWord &&
          right &&
          _gameState == GameState.lastWord) {
        anotherTeam = await TeamsDialog.show(context);
      } else {
        if (right) {
          _gameService.updateGame(pointPlus: _semanticOne);
        }
      }
      _gameService.updateGame(
          time: _settingService.appSettings.value.timePlayerTurn,
          gameState: GameState.init);
      _gameService.updateWord(right, anotherTeam);
      _gameService.saveGame();
      if (mounted) {
        RootAppNavigation.of(context)
            .pushReplacementWithoutAnimation(_appRoutes.teamResult());
      }
    } else {
      setState(() {
        if (right) {
          _gameService.updateGame(pointPlus: _semanticOne);
        }
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

  @override
  void dispose() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: ThemeConstants.primaryColor,
    ));
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = context.localization();
    final theme = MyAppTheme.of(context);
    Widget wordWidget = Stack(
      alignment: Alignment.center,
      children: [
        HatRotateWidget(
          skipAnimation: _skipAnimation,
          size: 200,
          onComplete: _onRotateComplete,
        ),
        if (_wordView)
          TransitionContainer(
            key: _animKey,
            color: const Color(0xFFFCF1D5),
            onSkip: _checkWord,
            child: Text(key: ValueKey(_word.id), _word.word),
          )
      ],
    );
    Widget centerWidget = Column(
      children: [
        Visibility(
          visible: _gameState == GameState.init,
          child: Column(
            children: [
              HatBounceWidget(
                complete: _startBounce,
                skipAnimation: _skipAnimation,
                onStop: () {
                  setState(() {
                    _gameService.updateGame(gameState: GameState.play);
                  });
                },
                size: 150,
              ),
              if (!_startBounce)
                ElevatedMenuButton(
                  lightStyle: false,
                  onPressed: _startGame,
                  child: Text(localization.btn_start),
                )
            ],
          ),
        ),
        Visibility(
          visible: _gameState == GameState.paused,
          child: ElevatedMenuButton(
            onPressed: _playGame,
            child: Text(localization.btn_play),
          ),
        ),
        Visibility(
            visible: _gameState == GameState.play ||
                _gameState == GameState.lastWord,
            child: wordWidget),
      ],
    );

    Widget stopWidget = _gameState == GameState.play &&
            _gameState != GameState.lastWord &&
            _wordView
        ? RawMaterialButton(
            onPressed: _stopGame,
            elevation: 2.0,
            fillColor: ColorPallet.colorBlue,
            shape: const CircleBorder(),
            padding: theme.custom.defaultAppPadding,
            child: Text(localization.btn_stop),
          )
        : const SizedBox();
    Widget timerWidget = Column(
      children: [
        _gameState != GameState.lastWord
            ? TimerWidget(
                key: _timerKey,
                onStop: _onStopTimer,
                currentDuration: _gameService.roundTime,
                baseDuration: _settingService.appSettings.value.timePlayerTurn,
              )
            : Text(_gameService.generalLastWord
                ? localization.title_general_last_word
                : localization.title_last_word),
        theme.custom.padding2,
      ],
    );

    Widget body = _helper
        ? HelperGameWidget(
            onClose: () {
              setState(() {
                var settings = _settingService.appSettings.value;
                _settingService
                    .updateSettings(settings.copyWith(isFirstLaunch: false));
              });
            },
          )
        : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(100),
                    ),
                    color: ColorPallet.colorBlue,
                  ),
                  child: Column(
                    children: [
                      Text(_currentTeam.name,
                          style: theme.material.textTheme.titleSmall?.copyWith(
                              color: ThemeConstants.lightBackground)),
                      Text(_currentTeam.points.toString(),
                          style: theme.material.textTheme.headlineLarge
                              ?.copyWith(
                                  color: ThemeConstants.lightBackground)),
                      theme.custom.padding4,
                    ],
                  ),
                ),
                centerWidget,
                timerWidget,
              ],
            ),
          );
    return WillPopScope(
      onWillPop: _onWillPop,
      child: MyAppWrap(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: ColorPallet.colorBlue,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: ColorPallet.colorBlue,
          ),
        ),
        floatingActionButton: stopWidget,
        body: body,
      ),
    );
  }
}
