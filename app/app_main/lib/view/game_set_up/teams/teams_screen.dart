import 'package:app_core/app_core.dart';
import 'package:core_flutter/core_flutter.dart';

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
  int _totalPlayers = _minPlayers;
  final List<String> _teams = [
    'First',
    'Second',
    'Another',
    'Firs',
    'Secon',
    'Anothr',
    'Fist',
    'Seond',
    'Aoher',
    'Fit',
    'Seond',
    'Anther',
    'Fst',
    'Sond',
    'ther',
    '1',
    '2',
    '3',
    '5',
  ];
  late final List<String> _currentTeams = _teams.sublist(0, 3);

  List<Widget> _genTeamLine() {
    List<Widget> teams = [];
    for (String i in _currentTeams) {
      teams.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            i,
            style: TextStyle(fontSize: 30),
          ),
          if (_currentTeams.indexOf(i) >= 2)
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.clear),
            ),
        ],
      ));
    }
    teams.add(
      GestureDetector(
        onTap: () {
          int length = _currentTeams.length;
          if (length < _teams.length) {
            setState(() {
              _currentTeams.add(_teams[length]);
            });
          }
        },
        child: const SizedBox(
          width: double.infinity,
          height: 40,
          child: ColoredBox(
            color: Colors.red,
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
    return teams;
  }

//TODO: add localization
  @override
  Widget build(BuildContext context) {
    return MyAppWrap(
        body: Column(
      children: [
        const Text(
          'Teams',
          textAlign: TextAlign.center,
        ),
        Expanded(
          child: ListView(
            physics: const PositionRetainedScrollPhysics(),
            children: _genTeamLine(),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Count players'),
            Row(
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
    ));
  }
}

class PositionRetainedScrollPhysics extends ScrollPhysics {
  final bool shouldRetain;

  const PositionRetainedScrollPhysics({super.parent, this.shouldRetain = true});

  @override
  PositionRetainedScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return PositionRetainedScrollPhysics(
      parent: buildParent(ancestor),
      shouldRetain: shouldRetain,
    );
  }

  @override
  double adjustPositionForNewDimensions({
    required ScrollMetrics oldPosition,
    required ScrollMetrics newPosition,
    required bool isScrolling,
    required double velocity,
  }) {
    final position = super.adjustPositionForNewDimensions(
      oldPosition: oldPosition,
      newPosition: newPosition,
      isScrolling: isScrolling,
      velocity: velocity,
    );

    final diff = newPosition.maxScrollExtent - oldPosition.maxScrollExtent;
    return position + diff;
  }
}
