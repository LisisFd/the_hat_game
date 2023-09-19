import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'The Hat';

  @override
  String get screen_main_btn_play => 'Play';

  @override
  String get screen_main_btn_settings => 'Settings';

  @override
  String get screen_main_btn_rules => 'Rules';

  @override
  String get rules_alias =>
      'Explain words using synonyms, antonyms, descriptions and various hints without using cognate words.';

  @override
  String get rules_one_word =>
      'Since at the first stage you learned all the words in the hat, now your explanation should contain only one word.';

  @override
  String get rules_crocodile =>
      'Now let\'s move a little. Use only facial expressions, gestures or dances to show your comrades the word without making a sound';
}
