import 'package:app_core/app_core.dart';
import 'package:app_main/controllers/controllers.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:core_get_it/core_get_it.dart';
import 'package:core_ui/core_ui.dart';

class TeamsScreenArguments {}

class TeamsScreen extends StatefulWidget {
  const TeamsScreen({super.key});

  static Widget pageBuilder(
      BuildContext context, PageArgumentsGeneric arguments) {
    return const TeamsScreen();
  }

  @override
  State<TeamsScreen> createState() => _TeamsScreenState();
}

class _TeamsScreenState extends State<TeamsScreen> {
  static const int _minTeamCount = 2;
  static const int _minPlayers = 4;
  static const int _maxPlayers = 10;
  final ITheHatAppService appService = getWidgetService<ITheHatAppService>();
  final _listTeamsKey = GlobalKey<AnimatedListState>();

  late final List<String> _teams = appService.teams;
  late final List<String> _currentTeams = _teams.sublist(0, _minTeamCount);

  int _totalPlayers = _minPlayers;

  void _addItem() {
    int length = _currentTeams.length;
    if (length < _teams.length) {
      setState(() {
        _currentTeams.add(_teams[length]);
        _listTeamsKey.currentState?.insertItem(length);
      });
    }
  }

  void _removeItem(int index) {
    setState(() {
      _listTeamsKey.currentState
          ?.removeItem(index, (context, animation) => const SizedBox());
      _currentTeams.removeAt(index);
    });
  }

  Widget _getRow(int index) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _currentTeams[index],
              style: const TextStyle(fontSize: 30),
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
                onPressed: () {},
                child: const Text('Next'),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
