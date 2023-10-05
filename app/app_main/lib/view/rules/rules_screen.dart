import 'package:app_core/app_core.dart';
import 'package:app_main/localization.dart';
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
    final localization = context.localization();
    return MyAppWrap(
        appBar: AppBar(
          title: Text(localization.title_rules),
        ),
        body: Column(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 100),
              child: _currentRule.widget,
            ),
            theme.custom.padding2,
            Container(
              margin: theme.custom.defaultAppMargin,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: _currentRule == _rules.first ? null : _prev,
                    child: Text(localization.btn_previous),
                  ),
                  OutlinedButton(
                    onPressed: _currentRule == _rules.last ? null : _next,
                    child: Text(localization.btn_next),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
