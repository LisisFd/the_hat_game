import 'package:app_core/app_core.dart';
import 'package:app_main/view/view.dart';
import 'package:core_flutter/core_flutter.dart';

class RulesScreen extends StatefulWidget {
  const RulesScreen({super.key});

  static Widget pageBuilder(
      BuildContext context, PageArgumentsGeneric arguments) {
    return const RulesScreen();
  }

  @override
  State<RulesScreen> createState() => _RulesScreenState();
}

class _RulesScreenState extends State<RulesScreen> {
  final List<Rules> _rules = Rules.values;
  late Rules _currentRule;

  @override
  void initState() {
    super.initState();
    _currentRule = _rules.first;
  }

  void _next() {
    final int currentRuleIndex = _rules.indexOf(_currentRule);
    if (_currentRule == _rules.last) {
      return;
    }
    setState(() {
      _currentRule = _rules[currentRuleIndex + 1];
    });
  }

  void _prev() {
    final int currentRuleIndex = _rules.indexOf(_currentRule);
    if (_currentRule == _rules.first) {
      return;
    }
    setState(() {
      _currentRule = _rules[currentRuleIndex - 1];
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = MyAppTheme.of(context);
    return MyAppWrap(
        appBar: AppBar(
          title: const Text('Rules'),
        ),
        body: Column(
          children: [
            AnimatedSwitcher(
              duration: const Duration(seconds: 1),
              child: _currentRule.widget,
            ),
            theme.custom.padding2,
            Row(
              children: [
                TextButton(
                  onPressed: _currentRule == _rules.first ? null : _prev,
                  child: const Text('Previous'),
                ),
                TextButton(
                  onPressed: _currentRule == _rules.last ? null : _next,
                  child: const Text('Next'),
                ),
              ],
            ),
          ],
        ));
  }
}
