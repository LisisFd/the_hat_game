import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_uk.dart';

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
    Locale('uk')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'The Hat'**
  String get appName;

  /// No description provided for @btn_play.
  ///
  /// In en, this message translates to:
  /// **'Play'**
  String get btn_play;

  /// No description provided for @btn_previous.
  ///
  /// In en, this message translates to:
  /// **'Previous'**
  String get btn_previous;

  /// No description provided for @btn_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get btn_next;

  /// No description provided for @btn_continue.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get btn_continue;

  /// No description provided for @btn_end.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get btn_end;

  /// No description provided for @btn_start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get btn_start;

  /// No description provided for @btn_stop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get btn_stop;

  /// No description provided for @btn_add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get btn_add;

  /// No description provided for @btn_menu.
  ///
  /// In en, this message translates to:
  /// **'Menu'**
  String get btn_menu;

  /// No description provided for @btn_in_hat.
  ///
  /// In en, this message translates to:
  /// **'In to the hat'**
  String get btn_in_hat;

  /// No description provided for @title_rules.
  ///
  /// In en, this message translates to:
  /// **'Rules'**
  String get title_rules;

  /// No description provided for @title_settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get title_settings;

  /// No description provided for @title_last_word.
  ///
  /// In en, this message translates to:
  /// **'Last word'**
  String get title_last_word;

  /// No description provided for @title_winner.
  ///
  /// In en, this message translates to:
  /// **'Winner'**
  String get title_winner;

  /// No description provided for @title_round_timer.
  ///
  /// In en, this message translates to:
  /// **'Timer'**
  String get title_round_timer;

  /// No description provided for @title_animation.
  ///
  /// In en, this message translates to:
  /// **'Animation'**
  String get title_animation;

  /// No description provided for @title_points.
  ///
  /// In en, this message translates to:
  /// **'Points'**
  String get title_points;

  /// No description provided for @title_command_rate.
  ///
  /// In en, this message translates to:
  /// **'Command Rate'**
  String get title_command_rate;

  /// No description provided for @title_words_on_player.
  ///
  /// In en, this message translates to:
  /// **'Count words on player'**
  String get title_words_on_player;

  /// No description provided for @title_new_name.
  ///
  /// In en, this message translates to:
  /// **'New name'**
  String get title_new_name;

  /// No description provided for @title_teams.
  ///
  /// In en, this message translates to:
  /// **'Teams'**
  String get title_teams;

  /// No description provided for @title_count_players.
  ///
  /// In en, this message translates to:
  /// **'Count players'**
  String get title_count_players;

  /// No description provided for @title_words.
  ///
  /// In en, this message translates to:
  /// **'Words'**
  String get title_words;

  /// No description provided for @title_great.
  ///
  /// In en, this message translates to:
  /// **'Great'**
  String get title_great;

  /// No description provided for @title_ready.
  ///
  /// In en, this message translates to:
  /// **'Ready to game'**
  String get title_ready;

  /// No description provided for @description_great.
  ///
  /// In en, this message translates to:
  /// **'Please, pass device to the next player'**
  String get description_great;

  /// No description provided for @error_input_word.
  ///
  /// In en, this message translates to:
  /// **'Please write a word'**
  String get error_input_word;

  /// No description provided for @rules_alias.
  ///
  /// In en, this message translates to:
  /// **'Explain words using synonyms, antonyms, descriptions and various hints without using cognate words.'**
  String get rules_alias;

  /// No description provided for @rules_one_word.
  ///
  /// In en, this message translates to:
  /// **'Since at the first stage you learned all the words in the hat, now your explanation should contain only one word.'**
  String get rules_one_word;

  /// No description provided for @rules_crocodile.
  ///
  /// In en, this message translates to:
  /// **'Now let\'s move a little. Use only facial expressions, gestures or dances to show your comrades the word without making a sound'**
  String get rules_crocodile;

  /// No description provided for @helper_words_text.
  ///
  /// In en, this message translates to:
  /// **'Each player must write the words that you will guess during the game. (Hint: the number of words that each player must enter can be changed in the settings)'**
  String get helper_words_text;

  /// No description provided for @helper_game_text.
  ///
  /// In en, this message translates to:
  /// **'Swipe the piece of paper to the right if your team guessed the word and to the left if you decided to skip it'**
  String get helper_game_text;

  /// No description provided for @title_round_number.
  ///
  /// In en, this message translates to:
  /// **'Round {number}'**
  String title_round_number(String number);

  /// No description provided for @title_player_number.
  ///
  /// In en, this message translates to:
  /// **'Player: {number}'**
  String title_player_number(String number);

  /// No description provided for @title_word_number.
  ///
  /// In en, this message translates to:
  /// **'Words left: {number}'**
  String title_word_number(String number);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru', 'uk'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
    case 'uk':
      return AppLocalizationsUk();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
