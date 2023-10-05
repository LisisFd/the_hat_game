import 'package:app_core/app_core.dart';
import 'package:app_main/controllers/controllers.dart';
import 'package:app_main/domain/domain.dart';
import 'package:app_main/localization.dart';
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
      RootAppNavigation.of(context).pushReplacementMultipleWithoutAnimation(
          [_appRoutes.mainScreen(), _appRoutes.preGameScreen()]);
    }
  }

  void _updateCurrentPlayer() {
    final localization = context.localization();
    final int wordsCount = _words.length;
    final int newPlayer = (wordsCount / _wordOnOnePlayer).floor();
    final int oldPlayer = _playerNumber;
    _playerNumber = newPlayer;
    if (oldPlayer != newPlayer) {
      DefaultAlertDialog.show(
          context: context,
          title: localization.title_great,
          description: localization.description_great);
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
    final localization = context.localization();
    final theme = MyAppTheme.of(context);
    final padding = theme.custom.defaultAppMargin.vertical / 2;
    return MyAppWrap(
        appBar: AppBar(
          centerTitle: true,
          title: Text(localization.title_words),
        ),
        body: LayoutBuilder(builder: (context, constraint) {
          return SingleChildScrollView(
              child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraint.maxHeight),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 2,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      color: const Color(0xFFFFE7D0),
                    ),
                    margin: EdgeInsets.symmetric(
                        horizontal: padding * 4, vertical: padding * 2),
                    padding: theme.custom.defaultAppPadding,
                    child: Text(
                      localization.helper_words_text,
                      style: theme.material.textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                        color: ThemeConstants.lightBackground,
                      ),
                      padding: EdgeInsets.only(
                          top: padding, left: padding, right: padding),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Form(
                                key: _formKey,
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                      fillColor: Colors.white70,
                                      filled: true,
                                      border: OutlineInputBorder()),
                                  validator: (val) {
                                    String? res = localization.error_input_word;
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
                              Container(
                                padding:
                                    EdgeInsets.symmetric(vertical: padding * 2),
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                        Radius.elliptical(30, 30))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      localization.title_player_number(
                                          playerNumber.toString()),
                                      style: theme.material.textTheme.bodyLarge,
                                    ),
                                    Text(
                                      localization.title_word_number(
                                          countWords.toString()),
                                      style: theme.material.textTheme.bodyLarge,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          ElevatedMenuButton(
                            key: ValueKey(_gameIsReady),
                            lightStyle: false,
                            onPressed:
                                !_gameIsReady ? _inTheHatPress : _nextPress,
                            child: Text(!_gameIsReady
                                ? localization.btn_in_hat
                                : localization.btn_next),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ));
        }));
  }
}
