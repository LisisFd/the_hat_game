import 'package:app_core/app_core.dart';
import 'package:app_main/localization.dart';
import 'package:core_flutter/core_flutter.dart';

import 'default_text_container.dart';

class _RulesTranslations {
  static const String _aliasNum = '1';
  static const String _oneWordNum = '2';
  static const String _crocodileNum = '3';

  static String aliasDescription(AppLocalizations context) {
    return context.rules_alias;
  }

  static String oneWordDescription(AppLocalizations context) {
    return context.rules_one_word;
  }

  static String crocodileDescription(AppLocalizations context) {
    return context.rules_crocodile;
  }

  static String aliasTitle(AppLocalizations context) {
    return context.rules_title(_aliasNum);
  }

  static String oneWordTitle(AppLocalizations context) {
    return context.rules_title(_oneWordNum);
  }

  static String crocodileTitle(AppLocalizations context) {
    return context.rules_title(_crocodileNum);
  }
}

enum Rules {
  alias(
    RulesWidget(
      key: ValueKey(_aliasKey),
      title: _RulesTranslations.aliasTitle,
      description: _RulesTranslations.aliasDescription,
    ),
  ),
  oneWord(
    RulesWidget(
      key: ValueKey(_oneWordKey),
      title: _RulesTranslations.oneWordTitle,
      description: _RulesTranslations.oneWordDescription,
    ),
  ),
  crocodile(
    RulesWidget(
      key: ValueKey(_crocodileKey),
      title: _RulesTranslations.crocodileTitle,
      description: _RulesTranslations.crocodileDescription,
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
  final LocalizeDelegate title;

  const RulesWidget(
      {super.key, required this.title, required this.description});

  @override
  State<RulesWidget> createState() => _RulesWidgetState();
}

class _RulesWidgetState extends State<RulesWidget> {
  @override
  Widget build(BuildContext context) {
    final localization = context.localization();

    final theme = MyAppTheme.of(context);

    return Center(
      child: Column(
        children: [
          Text(
            widget.title(
              localization,
            ),
            style: theme.material.textTheme.headlineLarge,
          ),
          const Icon(
            Icons.flutter_dash_outlined,
            size: 200,
          ),
          theme.custom.padding5,
          DefaultTextContainer(
            child: Text(
              widget.description(
                localization,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
