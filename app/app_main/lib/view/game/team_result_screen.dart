import 'package:app_core/app_core.dart';
import 'package:app_main/controllers/controllers.dart';
import 'package:app_main/navigation/app_routes.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:core_get_it/core_get_it.dart';

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

  Lap get _currentLap => _gameService.currentLap ?? Lap.first;

  int get _plusPoints =>
      _words.where((w) => w.status == WordStatus.right).length;

  late final List<Word> _words = _gameService.wordsWithStatus
      .where((w) => w.status == WordStatus.right || w.status == WordStatus.skip)
      .toList();

  void _updateWordState(Word word) {
    setState(() {
      int wordIndex = _words.indexWhere((w) => w.id == word.id);
      WordStatus newStatus =
          word.status == WordStatus.right ? WordStatus.skip : WordStatus.right;
      _words[wordIndex] = _words[wordIndex].copyWith(status: newStatus);
      _gameService.updateGame(
          pointPlus: newStatus == WordStatus.right ? 1 : -1);
    });
  }

  void _continue() {
    bool lapIsOver = !_words.any((w) => w.status == WordStatus.active);
    if (lapIsOver) {
      _setAllWordsActive();
      RootAppNavigation.of(context).pushReplacement(_appRoutes.preGameScreen());
    } else {
      _setSkipRightWordsDisable();
      RootAppNavigation.of(context)
          .pushReplacement(_appRoutes.teamsRateScreen());
    }
  }

  void _end() {}

  void _setAllWordsActive() {
    List<Word> updateWords =
        _words.map((w) => w.copyWith(status: WordStatus.active)).toList();
    _gameService.updateGame(words: updateWords);
    _gameService.saveGame();
  }

  void _setSkipRightWordsDisable() {
    List<Word> updateWords = [];
    for (var word in _words) {
      Word newWord = word;
      if (word.status == WordStatus.right || word.status == WordStatus.skip) {
        newWord = word.copyWith(status: WordStatus.disable);
      }
      updateWords.add(newWord);
    }
    _gameService.updateGame(words: updateWords);
    _gameService.saveGame();
  }

  ///TODO addLocalization
  @override
  Widget build(BuildContext context) {
    List<Widget> wordsWidgets = _words.map((w) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(w.word),
          GestureDetector(
            key: ValueKey(w.status),
            onTap: () {
              _updateWordState(w);
            },
            child: Image(
              image: w.status == WordStatus.right
                  ? AppConfig.fillHatIcon
                  : AppConfig.strokeHatIcon,
              width: 20,
            ),
          ),
        ],
      );
    }).toList();
    Widget buttonWidget = _currentLap == Lap.third &&
            !_words.any((w) => w.status == WordStatus.active)
        ? TextButton(
            onPressed: _end,
            child: const Text('End'),
          )
        : TextButton(
            onPressed: _continue,
            child: const Text('Continue'),
          );
    return MyAppWrap(
      body: Column(
        children: [
          const Text('Points'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(_currentTeam.name),
              Text(key: ValueKey(_plusPoints), '+$_plusPoints')
            ],
          ),
          SingleChildScrollView(
            child: Column(
              children: wordsWidgets,
            ),
          ),
          buttonWidget,
        ],
      ),
    );
  }
}
