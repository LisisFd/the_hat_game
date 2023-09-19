import 'package:app_main/localization.dart';
import 'package:core_flutter/core_flutter.dart';

class _RulesTranslations {
  static String alias(AppLocalizations context) {
    return context.rules_alias;
  }

  static String oneWord(AppLocalizations context) {
    return context.rules_one_word;
  }

  static String crocodile(AppLocalizations context) {
    return context.rules_crocodile;
  }
}

enum Rules {
  alias(RulesWidget(description: _RulesTranslations.alias)),
  oneWord(RulesWidget(description: _RulesTranslations.oneWord)),
  crocodile(RulesWidget(description: _RulesTranslations.crocodile));

  const Rules(this.widget);

  final RulesWidget widget;
}

class RulesWidget extends StatefulWidget {
  final LocalizeDelegate description;

  const RulesWidget({super.key, required this.description});

  @override
  State<RulesWidget> createState() => _RulesWidgetState();
}

class _RulesWidgetState extends State<RulesWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Icon(
            Icons.flutter_dash_outlined,
            size: 50,
          ),
          Text(
            widget.description(
              context.localization(),
            ),
          ),
        ],
      ),
    );
  }
}
