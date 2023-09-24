import 'package:app_core/app_core.dart';
import 'package:app_main/controllers/controllers.dart';
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

  Team get _currentTeam => _gameService.currentTeam;

  Lap get _currentLap => _gameService.currentLap ?? Lap.first;

  int get _plusPoints => _gameService.wordsWithStatus
      .where((w) => w.status == WordStatus.right)
      .length;

  late final List<Word> _words = _gameService.wordsWithStatus
      .where((w) => w.status == WordStatus.right || w.status == WordStatus.skip)
      .toList();

  void _updateWordState(Word word) {
    setState(() {
      int wordIndex = _words.indexWhere((w) => w.id == word.id);
      WordStatus newStatus =
          word.status == WordStatus.right ? WordStatus.skip : WordStatus.right;
      _words[wordIndex] = _words[wordIndex].copyWith(status: newStatus);
    });
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
              child: Icon(w.status == WordStatus.right
                  ? HatIcon.fill
                  : HatIcon.stroke)),
        ],
      );
    }).toList();
    Widget buttonWidget = TextButton(
      onPressed: () {},
      child: _currentLap == Lap.third &&
              !_words.any((w) => w.status == WordStatus.active)
          ? const Text('End')
          : const Text('Continue'),
    );
    return MyAppWrap(
      body: Column(
        children: [
          const Text('Points'),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text(_currentTeam.name), Text('+$_plusPoints')],
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
