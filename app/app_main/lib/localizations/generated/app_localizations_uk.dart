import 'app_localizations.dart';

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appName => 'Капелюх';

  @override
  String get btn_play => 'Грати';

  @override
  String get btn_previous => 'Назад';

  @override
  String get btn_next => 'Далі';

  @override
  String get btn_continue => 'Продовжити';

  @override
  String get btn_end => 'Кінець';

  @override
  String get btn_start => 'Старт';

  @override
  String get btn_stop => 'Стоп';

  @override
  String get btn_add => 'Додати';

  @override
  String get btn_menu => 'Меню';

  @override
  String get btn_in_hat => 'До капелюха';

  @override
  String get title_rules => 'Правила';

  @override
  String get title_settings => 'Налаштування';

  @override
  String get title_last_word => 'Останнє слово';

  @override
  String get title_winner => 'Переможець';

  @override
  String get title_round_timer => 'Таймер';

  @override
  String get title_animation => 'Анімація';

  @override
  String get title_points => 'Рахунок';

  @override
  String get title_command_rate => 'Командна рахунок';

  @override
  String get title_words_on_player => 'Кількість слів на одного ігрока';

  @override
  String get title_new_name => 'Нова назва';

  @override
  String get title_teams => 'Команди';

  @override
  String get title_count_players => 'Кількість гравців';

  @override
  String get title_words => 'Слова';

  @override
  String get title_great => 'Чудово';

  @override
  String get title_ready => 'Гототуються до гри';

  @override
  String get description_great =>
      'Будь ласка, передайте пристрій наступному гравцеві';

  @override
  String get error_input_word => 'Будь ласка, напишіть слово';

  @override
  String get rules_alias =>
      'Поясніть слова, використовуючи синоніми, антоніми, описи та різні підказки без використання спільнокореневих слів.';

  @override
  String get rules_one_word =>
      'Оскільки на першому етапі ви вивчили всі слова в капелюсі, тепер ваше пояснення має містити лише одне слово.';

  @override
  String get rules_crocodile =>
      'Тепер трохи порухаємося. Використовуйте тільки міміку, жести або танці, щоб показати своїм товаришам слово без звуку.';

  @override
  String get helper_words_text =>
      'Кожен гравець повинен написати слова, які ви відгадаєте під час гри. (Підказка: кількість слів, які повинен ввести кожен гравець, можна змінити в налаштуваннях)';

  @override
  String get helper_game_text =>
      'Змахніть папірець праворуч, якщо ваша команда вгадала слово, і вліво, якщо ви вирішили його пропустити.';

  @override
  String title_round_number(String number) {
    return 'Раунд $number';
  }

  @override
  String title_player_number(String number) {
    return 'Гравець: $number';
  }

  @override
  String title_word_number(String number) {
    return 'Залишилося слів: $number';
  }
}
