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
  alias(
    RulesWidget(
      key: ValueKey(_aliasKey),
      description: _RulesTranslations.alias,
    ),
  ),
  oneWord(
    RulesWidget(
      key: ValueKey(_oneWordKey),
      description: _RulesTranslations.oneWord,
    ),
  ),
  crocodile(
    RulesWidget(
      key: ValueKey(_crocodileKey),
      description: _RulesTranslations.crocodile,
    ),
  );

  const Rules(this.widget);

  static const _aliasKey = 'ALIAS';
  static const _oneWordKey = 'ONE_WORD';
  static const _crocodileKey = 'CROCODILE';
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
