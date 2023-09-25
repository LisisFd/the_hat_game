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
    RootAppNavigation.of(context).push(_appRoutes.wordsScreen());
  }

  Widget _getRow(int index) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                _currentTeams[index].name,
                style: const TextStyle(fontSize: 30),
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
        if (_currentTeams.length - index == 1)
          ElevatedButton(
            onPressed: _addItem,
            child: const Icon(Icons.add),
          ),
      ],
    );
  }

//TODO: add localization
  @override
  Widget build(BuildContext context) {
    return MyAppWrap(
        body: Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Column(
        children: [
          const Text(
            'Teams',
            textAlign: TextAlign.center,
          ),
          Expanded(
            child: AnimatedList(
              key: _listTeamsKey,
              initialItemCount: _currentTeams.length,
              physics: CoreScrollPhysics.positionRetained,
              itemBuilder: (BuildContext context, int index,
                  Animation<double> animation) {
                return _getRow(index);
              },
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Count players'),
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
                  Text(_totalPlayers.toString()),
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
              TextButton(
                onPressed: () => _createGame(context),
                child: const Text('Next'),
              ),
            ],
          ),
        ],
      ),
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
