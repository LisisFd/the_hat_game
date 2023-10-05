import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'The Hat';

  @override
  String get btn_play => 'Play';

  @override
  String get btn_previous => 'Previous';

  @override
  String get btn_next => 'Next';

  @override
  String get btn_continue => 'Continue';

  @override
  String get btn_end => 'End';

  @override
  String get btn_start => 'Start';

  @override
  String get btn_stop => 'Stop';

  @override
  String get btn_add => 'Add';

  @override
  String get btn_menu => 'Menu';

  @override
  String get btn_in_hat => 'In to the hat';

  @override
  String get title_rules => 'Rules';

  @override
  String get title_settings => 'Settings';

  @override
  String get title_last_word => 'Last word';

  @override
  String get title_winner => 'Winner';

  @override
  String get title_round_timer => 'Timer';

  @override
  String get title_animation => 'Animation';

  @override
  String get title_points => 'Points';

  @override
  String get title_command_rate => 'Command Rate';

  @override
  String get title_words_on_player => 'Count words on player';

  @override
  String get title_new_name => 'New name';

  @override
  String get title_teams => 'Teams';

  @override
  String get title_count_players => 'Count players';

  @override
  String get title_words => 'Words';

  @override
  String get title_great => 'Great';

  @override
  String get title_ready => 'Ready to game';

  @override
  String get description_great => 'Please, pass device to the next player';

  @override
  String get error_input_word => 'Please write a word';

  @override
  String get rules_alias =>
      'Explain words using synonyms, antonyms, descriptions and various hints without using cognate words.';

  @override
  String get rules_one_word =>
      'Since at the first stage you learned all the words in the hat, now your explanation should contain only one word.';

  @override
  String get rules_crocodile =>
      'Now let\'s move a little. Use only facial expressions, gestures or dances to show your comrades the word without making a sound';

  @override
  String get helper_words_text =>
      'Each player must write the words that you will guess during the game. (Hint: the number of words that each player must enter can be changed in the settings)';

  @override
  String get helper_game_text =>
      'Swipe the piece of paper to the right if your team guessed the word and to the left if you decided to skip it';

  @override
  String title_round_number(String number) {
    return 'Round $number';
  }

  @override
  String title_player_number(String number) {
    return 'Player: $number';
  }

  @override
  String title_word_number(String number) {
    return 'Words left: $number';
  }
}
