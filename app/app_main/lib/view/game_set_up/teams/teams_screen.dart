import 'dart:math';

import 'package:app_core/app_core.dart';
import 'package:app_main/controllers/controllers.dart';
import 'package:app_main/domain/domain.dart';
import 'package:app_main/navigation/app_routes.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:core_get_it/core_get_it.dart';
import 'package:core_ui/core_ui.dart';

class TeamsScreen extends StatefulWidget {
  const TeamsScreen({super.key});

  static Widget pageBuilder(
      BuildContext context, PageArgumentsGeneric arguments) {
    return const TeamsScreen();
  }

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

/// TODO: add animation
class _TeamsScreenState extends State<TeamsScreen> {
  static const int _minPlayers = 1;
  static const int _maxPlayers = 10;

  final IGameService _gameService = getWidgetService<IGameService>();
  final ITeamsService _teamsService = getWidgetService<ITeamsService>();
  final AppRoutes _appRoutes = getWidgetService<AppRoutes>();

  final _listTeamsKey = GlobalKey<AnimatedListState>();

  late final _ModelTeamsScreen _screenModel =
      _ModelTeamsScreen(teams: _teamsService.teams);

  int _totalPlayers = _minPlayers;

  List<Team> get _currentTeams => _screenModel.currentTeams;

  @override
  void initState() {
    _gameService.deleteGame();
    super.initState();
  }

  void _addItem() {
    int length = _currentTeams.length;
    setState(() {
      if (_screenModel.addTeam()) {
        _listTeamsKey.currentState?.insertItem(length);
      }
    });
  }

  void _removeItem(int index) {
    setState(() {
      _listTeamsKey.currentState
          ?.removeItem(index, (context, animation) => const SizedBox());
      _screenModel.removeTeam(index);
    });
  }

  void _renameItem(int index, String name) {
    setState(() {
      _screenModel.renameTeam(index, name);
    });
  }

  void _createGame(BuildContext context) {
    _gameService.setUpGameTeams(_currentTeams, _totalPlayers);
    RootAppNavigation.of(context)
        .pushWithoutAnimation(_appRoutes.wordsScreen());
  }

  Widget _getRow(int index) {
    return ColoredBox(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                _currentTeams[index].name,
                style: const TextStyle(fontSize: 25),
              ),
            ),
          ),
          Row(
            children: [
              IconButton(
                onPressed: () async {
                  String value = '';
                  bool isRenamed = await YesNoDialog.showWidget(
                    context: context,
                    title: 'New name',
                    descriptionWidget: TextFormField(
                      initialValue: _currentTeams[index].name,
                      onChanged: (val) {
                        value = val;
                      },
                    ),
                  );
                  if (isRenamed && value.isNotEmpty) {
                    _renameItem(index, value);
                  }
                },
                icon: const Icon(Icons.edit),
              ),
              if (_currentTeams.length > 2)
                IconButton(
                  onPressed: () {
                    _removeItem(index);
                  },
                  icon: const Icon(Icons.clear),
                ),
            ],
          ),
        ],
      ),
    );
  }

//TODO: add localization
  @override
  Widget build(BuildContext context) {
    var theme = MyAppTheme.of(context).custom;
    return MyAppWrap(
        body: Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: const Text(
            'Teams',
            style: TextStyle(fontSize: 25),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(
          child: AnimatedList(
            key: _listTeamsKey,
            initialItemCount: _currentTeams.length,
            physics: CoreScrollPhysics.positionRetained,
            itemBuilder:
                (BuildContext context, int index, Animation<double> animation) {
              return Column(
                children: [
                  Material(elevation: 3, child: _getRow(index)),
                  if (index != _currentTeams.length - 1)
                    ColoredBox(
                      color: theme.primaryColor.withOpacity(0),
                      child: const SizedBox(
                        width: double.infinity,
                        height: 7,
                      ),
                    )
                  else
                    const SizedBox(
                      height: 20,
                    ),
                ],
              );
            },
          ),
        ),
        ColoredBox(
          color: MyAppTheme.getColorScheme().surface,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: IntrinsicHeight(
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Count players',
                              style: TextStyle(fontSize: 15),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    if (_totalPlayers > _minPlayers) {
                                      setState(() {
                                        _totalPlayers--;
                                      });
                                    }
                                  },
                                  icon: const Icon(Icons.remove),
                                ),
                                Text(
                                  _totalPlayers.toString(),
                                  style: const TextStyle(fontSize: 25),
                                ),
                                IconButton(
                                  onPressed: () {
                                    if (_totalPlayers < _maxPlayers) {
                                      setState(() {
                                        _totalPlayers++;
                                      });
                                    }
                                  },
                                  icon: const Icon(Icons.add),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: RawMaterialButton(
                          elevation: 2.0,
                          shape: const CircleBorder(),
                          fillColor: Colors.white,
                          onPressed: _addItem,
                          child: Container(
                              margin: const EdgeInsets.all(10),
                              child: const Icon(Icons.add)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              MenuButton(
                onPressed: () => _createGame(context),
                child: Text(
                  'Next',
                  style: TextStyle(color: MyAppTheme.getColorScheme().surface),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}

class _ModelTeamsScreen {
  late final int _minTeamsCount;
  final Random _randomService = Random();
  final List<Team> _currentTeams = [];
  final List<Team> _teams = [];

  _ModelTeamsScreen({required List<Team> teams, int minTeamsCount = 2}) {
    _teams.addAll(teams);
    _minTeamsCount = minTeamsCount;
    for (var i = 0; i < _minTeamsCount; i++) {
      addTeam();
    }
  }

  List<Team> get currentTeams => _currentTeams;

  bool get isEmptyTeams => _teams.isEmpty;

  bool addTeam() {
    bool isAdd = false;
    if (!isEmptyTeams) {
      int randomValue = _random();
      _currentTeams.add(_teams.removeAt(randomValue));
      isAdd = true;
    }
    return isAdd;
  }

  void removeTeam(int index) {
    _teams.add(_currentTeams.removeAt(index));
  }

  void renameTeam(int index, String name) {
    _currentTeams.removeAt(index);
    _currentTeams.insert(index, Team(name: name));
  }

  int _random() {
    final int currentValue = _randomService.nextInt(_teams.length);
    return currentValue;
  }
}
