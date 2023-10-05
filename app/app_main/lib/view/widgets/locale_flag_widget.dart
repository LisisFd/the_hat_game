import 'package:app_core/app_core.dart';
import 'package:app_main/localization.dart';
import 'package:core_flutter/core_flutter.dart';

class _FlagTranslations {
  static String uk(AppLocalizations context) {
    return context.ua;
  }

  static String en(AppLocalizations context) {
    return context.en;
  }

  static String r(AppLocalizations context) {
    return context.r;
  }
}

enum Flag {
  uk(
    FlagWidget(
      title: _FlagTranslations.uk,
      image: AppConfig.flagUa,
    ),
    Locale('uk'),
  ),
  en(
    FlagWidget(
      title: _FlagTranslations.en,
      image: AppConfig.flagEn,
    ),
    Locale('en'),
  ),
  r(
    FlagWidget(
      title: _FlagTranslations.r,
      image: AppConfig.flagR,
    ),
    Locale('ru'),
  );

  const Flag(this.widget, this.locale);

  final FlagWidget widget;
  final Locale locale;
}

class FlagWidget extends StatelessWidget {
  final AssetImage image;
  final LocalizeDelegate title;

  const FlagWidget({super.key, required this.title, required this.image});

  @override
  Widget build(BuildContext context) {
    final localization = context.localization();
    final theme = MyAppTheme.of(context);

    return Row(
      children: [
        Image(
          image: image,
          width: 24,
        ),
        theme.custom.padding3,
        Text(
          title(
            localization,
          ),
          style: theme.material.textTheme.bodyLarge,
        ),
      ],
    );
  }
}
