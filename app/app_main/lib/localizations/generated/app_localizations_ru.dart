import 'app_localizations.dart';

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appName => 'Шляпа';

  @override
  String get btn_play => 'Играть';

  @override
  String get btn_previous => 'Предыдущий';

  @override
  String get btn_next => 'Следующий';

  @override
  String get btn_continue => 'Продолжить';

  @override
  String get btn_end => 'Закончить';

  @override
  String get btn_start => 'Начать';

  @override
  String get btn_stop => 'Стоп';

  @override
  String get btn_add => 'Добавить';

  @override
  String get btn_menu => 'Меню';

  @override
  String get btn_in_hat => 'В шляпу';

  @override
  String get title_rules => 'Правила';

  @override
  String get title_settings => 'Настройки';

  @override
  String get title_last_word => 'Последнее слово';

  @override
  String get title_winner => 'Победитель';

  @override
  String get title_round_timer => 'Таймер';

  @override
  String get title_animation => 'Анимация';

  @override
  String get title_points => 'Точки';

  @override
  String get title_command_rate => 'Счет команды';

  @override
  String get title_words_on_player => 'Количество слов на игрока';

  @override
  String get title_new_name => 'Новое имя';

  @override
  String get title_teams => 'Команды';

  @override
  String get title_count_players => 'Количество игроков';

  @override
  String get title_words => 'Слова';

  @override
  String get title_great => 'Отлично';

  @override
  String get title_ready => 'Готовятся к игре';

  @override
  String get description_great =>
      'Пожалуйста, передайте устройство следующему игроку';

  @override
  String get error_input_word => 'Пожалуйста, напишите слово';

  @override
  String get rules_alias =>
      'Объясните слова, используя синонимы, антонимы, описания и различные подсказки без использования корневых слов.';

  @override
  String get rules_one_word =>
      'Поскольку на первом этапе вы изучили все слова в шляпе, теперь ваше объяснение должно содержать только одно слово.';

  @override
  String get rules_crocodile =>
      'Теперь немного подвигаемся. Используйте только мимику, жесты или пляски, чтобы показать своим товарищам слово без звука.';

  @override
  String get helper_words_text =>
      'Каждый игрок должен написать слова, которые вы будете отгадывать во время игры. (Подсказка: количество слов, которые должен ввести каждый игрок, можно изменить в настройках)';

  @override
  String get helper_game_text =>
      'Смахните бумажку вправо, если ваша команда угадала слово, и влево, если вы решили его пропустить.';

  @override
  String title_round_number(String number) {
    return 'Раунд $number';
  }

  @override
  String title_player_number(String number) {
    return 'Игрок: $number';
  }

  @override
  String title_word_number(String number) {
    return 'Осталось слов: $number';
  }
}
