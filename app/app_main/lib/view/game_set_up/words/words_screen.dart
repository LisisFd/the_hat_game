import 'package:app_core/app_core.dart';
import 'package:app_main/controllers/controllers.dart';
import 'package:app_main/domain/domain.dart';
import 'package:app_main/navigation/app_routes.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:core_get_it/core_get_it.dart';
import 'package:core_ui/core_ui.dart';

const _semanticOne = 1;

class WordsScreen extends StatefulWidget {
  static Widget pageBuilder(
      BuildContext context, PageArgumentsGeneric arguments) {
    return const WordsScreen();
  }

  const WordsScreen({super.key});

  @override
  State<WordsScreen> createState() => _WordsScreenState();
}

//TODO: add localization
class _WordsScreenState extends State<WordsScreen> {
  final IGameService _gameService = getWidgetService<IGameService>();
  final AppRoutes _appRoutes = getWidgetService<AppRoutes>();
  final _formKey = GlobalKey<FormState>();

  int get _wordOnOnePlayer => _gameService.countWordsOnPlayer;

  List<String> get _words => _gameService.words.map((w) => w.word).toList();

  bool get _gameIsReady => _gameService.gameIsReady;

  int _playerNumber = 0;
  int _countWords = _semanticOne;
  String _currentWord = '';

  int get countWords => _countWords + _semanticOne;

  int get playerNumber => _playerNumber + _semanticOne;

  @override
  void initState() {
    _gameService.setNewScreen(CurrentScreen.setUp);
    _update();
    super.initState();
  }

  void _update() {
    _updateCurrentPlayer();
    _updateCountWord();
  }

  void _inTheHatPress() {
    if (_addWord()) {
      setState(() {
        _formKey.currentState?.reset();
        _update();
      });
    }
  }

  void _nextPress() {
    if (_addWord()) {
      RootAppNavigation.of(context).pushReplacementMultiple(
          [_appRoutes.mainScreen(), _appRoutes.preGameScreen()]);
    }
  }

  void _updateCurrentPlayer() {
    final int wordsCount = _words.length;
    final int newPlayer = (wordsCount / _wordOnOnePlayer).floor();
    final int oldPlayer = _playerNumber;
    _playerNumber = newPlayer;
    if (oldPlayer != newPlayer) {
      DefaultAlertDialog.show(
          context: context,
          title: 'Great',
          description: 'Please, pass device to the next player');
    }
  }

  void _updateCountWord() {
    final int wordsCount = _words.length;
    if (wordsCount < _wordOnOnePlayer) {
      _countWords = wordsCount;
    } else {
      _countWords = (wordsCount % _wordOnOnePlayer).ceil();
    }
  }

  bool _addWord() {
    bool wordIsAdded = false;
    final state = _formKey.currentState;
    if (state != null) {
      if (state.validate()) {
        _gameService.addWord(_currentWord);
        wordIsAdded = true;
      }
    }
    return wordIsAdded;
  }

  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MyAppWrap(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Player Number $playerNumber'),
        Text('Count Words $countWords'),
        Form(
          key: _formKey,
          child: TextFormField(
            validator: (val) {
              String? res = 'Please write a word';
              if (val != null && val.isNotEmpty) {
                res = null;
              }
              return res;
            },
            onChanged: (val) {
              _currentWord = val;
            },
          ),
        ),
        TextButton(
          key: ValueKey(_gameIsReady),
          onPressed: !_gameIsReady ? _inTheHatPress : _nextPress,
          child: !_gameIsReady ? const Text('In the hat') : const Text('Next'),
        )
      ],
    ));
  }
}
