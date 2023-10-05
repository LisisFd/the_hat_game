import 'package:app_core/app_core.dart';
import 'package:app_main/controllers/controllers.dart';
import 'package:app_main/localization.dart';
import 'package:app_main/navigation/app_routes.dart';
import 'package:app_main/view/view.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:core_get_it/core_get_it.dart';
import 'package:core_ui/core_ui.dart';

import '../../domain/domain.dart';

class TeamResultScreen extends StatefulWidget {
  const TeamResultScreen({super.key});

  static Widget pageBuilder(
      BuildContext context, PageArgumentsGeneric arguments) {
    return const TeamResultScreen();
  }

  @override
  State<TeamResultScreen> createState() => _TeamResultScreenState();
}

class _TeamResultScreenState extends State<TeamResultScreen> {
  final IGameService _gameService = getWidgetService<IGameService>();
  final AppRoutes _appRoutes = getWidgetService<AppRoutes>();

  Team get _currentTeam => _gameService.currentTeam;

  Team? get _lastWordTeam => _gameService.appGame.value?.lastWordTeam;

  Lap get _currentLap => _gameService.currentLap;

  int get _plusPoints {
    int points = _words.where((w) => w.status == WordStatus.right).length;
    if (_lastWordTeam?.name != _currentTeam.name && _lastWordTeam != null) {
      points -= 1;
    }
    return points;
  }

  late final List<Word> _words = _gameService.wordsWithStatus
      .where((w) => w.status == WordStatus.right || w.status == WordStatus.skip)
      .toList();

  @override
  void initState() {
    _gameService.setNewScreen(CurrentScreen.result);
    super.initState();
  }

  void _updateWordState(Word word) async {
    Team? anotherTeam;
    bool isLast = false;
    int wordIndex = _words.indexWhere((w) => w.id == word.id);
    WordStatus newStatus =
        word.status == WordStatus.right ? WordStatus.skip : WordStatus.right;
    if (word.isLastWord && _gameService.generalLastWord) {
      if (newStatus == WordStatus.right) {
        anotherTeam = await TeamsDialog.show(context);
      } else {
        isLast = true;
      }
    }
    setState(() {
      _words[wordIndex] = _words[wordIndex].copyWith(status: newStatus);
      _gameService.updateGame(
          pointPlus: newStatus == WordStatus.right ? 1 : -1,
          anotherTeam: anotherTeam,
          isLast: isLast);
    });
  }

  void _continue() {
    bool lapIsOver =
        !_gameService.wordsWithStatus.any((w) => w.status == WordStatus.active);

    if (lapIsOver) {
      _resetGameWithUpdateLap();
      RootAppNavigation.of(context)
          .pushReplacementWithoutAnimation(_appRoutes.preGameScreen());
    } else {
      _resetWordsAndTeam();
      RootAppNavigation.of(context)
          .pushReplacementWithoutAnimation(_appRoutes.teamsRateScreen());
    }
  }

  void _end() {
    RootAppNavigation.of(context)
        .pushReplacementWithoutAnimation(_appRoutes.winner());
  }

  void _resetGameWithUpdateLap() {
    List<Word> updateWords = _gameService.wordsWithStatus
        .map((w) => w.copyWith(status: WordStatus.active))
        .toList();
    _gameService.updateGame(words: updateWords);
    _gameService.setNewLap();
    _gameService.changeCurrentTeam();
    _gameService.saveGame();
  }

  void _resetWordsAndTeam() {
    List<Word> updateWords = [];
    for (var word in _gameService.wordsWithStatus) {
      Word newWord = word;
      if (word.status == WordStatus.right || word.status == WordStatus.skip) {
        newWord = word.copyWith(status: WordStatus.disable);
      }
      updateWords.add(newWord);
    }
    _gameService.updateGame(words: updateWords);
    _gameService.changeCurrentTeam();
    _gameService.saveGame();
  }

  Future<bool> _onWillPop() async {
    _gameService.saveGame();
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final localization = context.localization();
    final theme = MyAppTheme.of(context);
    final List<Widget> wordsWidgets = _words.map((w) {
      String word = w.word;
      if (w.isLastWord && _gameService.generalLastWord) {
        if (w.status == WordStatus.skip) {
          word += '(${localization.title_general})';
        } else {
          word += '(${_lastWordTeam?.name})';
        }
      }
      return Column(
        children: [
          theme.custom.padding1,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                word,
                style: theme.material.textTheme.titleSmall,
              ),
              GestureDetector(
                key: ValueKey(w.status),
                onTap: () {
                  _updateWordState(w);
                },
                child: Image(
                  image: w.status == WordStatus.right
                      ? AppConfig.fillHatIcon
                      : AppConfig.strokeHatIcon,
                  width: 30,
                ),
              ),
            ],
          ),
          theme.custom.padding1,
        ],
      );
    }).toList();

    Widget buttonWidget = _currentLap == Lap.third &&
            !_words.any((w) => w.status == WordStatus.active)
        ? ElevatedMenuButton(
            onPressed: _end,
            child: Text(localization.btn_end),
          )
        : ElevatedMenuButton(
            onPressed: _continue,
            child: Text(localization.btn_continue),
          );
    return WillPopScope(
      onWillPop: _onWillPop,
      child: MyAppWrap(
        body: Column(
          children: [
            theme.custom.padding5,
            Text(
              localization.title_points,
              style: theme.material.textTheme.titleLarge,
            ),
            Expanded(
              child: DefaultContainer(
                margin: theme.custom.defaultAppMargin,
                padding: theme.custom.defaultAppPadding,
                child: Column(
                  children: [
                    Column(
                      children: [
                        theme.custom.padding1,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              _currentTeam.name,
                              style: theme.material.textTheme.titleMedium,
                            ),
                            Text(
                              key: ValueKey(_plusPoints),
                              '+$_plusPoints',
                              style: theme.material.textTheme.titleMedium,
                            ),
                          ],
                        ),
                        AnimatedVisibility(
                          visible: _lastWordTeam != null &&
                              _lastWordTeam?.name != _currentTeam.name,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _lastWordTeam?.name ?? "null",
                                style: theme.material.textTheme.titleMedium,
                              ),
                              Text(
                                '+1',
                                style: theme.material.textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                        theme.custom.padding1,
                      ],
                    ),
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: wordsWidgets,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            buttonWidget,
          ],
        ),
      ),
    );
  }
}
