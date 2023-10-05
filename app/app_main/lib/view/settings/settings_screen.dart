import 'package:app_core/app_core.dart';
import 'package:app_main/controllers/controllers.dart';
import 'package:app_main/domain/domain.dart';
import 'package:app_main/localization.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:core_get_it/core_get_it.dart';

import '../widgets/widgets.dart';

class SettingsScreen extends StatefulWidget {
  static Widget pageBuilder(
      BuildContext context, PageArgumentsGeneric arguments) {
    return const SettingsScreen();
  }

  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final ISettingService _settingsService = getWidgetService<ISettingService>();

  late TheHatAppSettings appSettings;

  @override
  void initState() {
    appSettings = _settingsService.appSettings.value;
    DurationSeconds defDuration = _settingsService.defaultDuration;
    double timePlayerTurn = appSettings.timePlayerTurn.inSeconds.toDouble();
    if (timePlayerTurn < defDuration.min) {
      _updateSettings(
        appSettings.copyWith(
          timePlayerTurn: Duration(
            seconds: defDuration.min.toInt(),
          ),
        ),
      );
    } else if (timePlayerTurn > defDuration.max) {
      _updateSettings(
        appSettings.copyWith(
          timePlayerTurn: Duration(
            seconds: defDuration.max.toInt(),
          ),
        ),
      );
    }
    super.initState();
  }

  void _updateSettings(TheHatAppSettings newSettings) {
    setState(() {
      appSettings = newSettings;
    });
  }

  bool _onPop(TheHatAppSettings newSettings) {
    _settingsService.updateSettings(newSettings);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final theme = MyAppTheme.of(context);
    final localization = context.localization();
    final TheHatAppSettings currentSettings = appSettings;
    List<_SettingsModel> settingModels = [
      _SettingsModel(
        title: localization.title_words_on_player,
        action: Row(
          children: [
            IconButton(
              onPressed: () {
                if (currentSettings.countWordsOnPlayer > 1) {
                  _updateSettings(
                    currentSettings.copyWith(
                        countWordsOnPlayer:
                            currentSettings.countWordsOnPlayer - 1),
                  );
                }
              },
              icon: const Icon(Icons.remove),
            ),
            Text(
              '${currentSettings.countWordsOnPlayer}',
              style: theme.material.textTheme.titleMedium,
            ),
            IconButton(
              onPressed: () {
                if (currentSettings.countWordsOnPlayer < 5) {
                  _updateSettings(
                    currentSettings.copyWith(
                        countWordsOnPlayer:
                            currentSettings.countWordsOnPlayer + 1),
                  );
                }
              },
              icon: const Icon(Icons.add),
            ),
          ],
        ),
      ),
      _SettingsModel(
          title: localization.title_animation,
          action: Switch(
              value: currentSettings.animation,
              onChanged: (val) {
                _updateSettings(currentSettings.copyWith(animation: val));
              })),
      _SettingsModel(
          title: localization.title_round_timer,
          action: Slider(
              max: _settingsService.defaultDuration.max,
              min: _settingsService.defaultDuration.min,
              value: currentSettings.timePlayerTurn.inSeconds.toDouble(),
              onChanged: (val) {
                _updateSettings(
                  currentSettings.copyWith(
                    timePlayerTurn: Duration(
                      seconds: val.toInt(),
                    ),
                  ),
                );
              }),
          position: _SettingsPosition.vertical),
      _SettingsModel(
        title: localization.title_last_word,
        action: Switch(
            value: currentSettings.lastWord,
            onChanged: (val) {
              _updateSettings(
                currentSettings.copyWith(lastWord: val),
              );
            }),
      ),
    ];

    List<Widget> settingWidgets =
        settingModels.map((m) => _SettingsElem(child: m)).toList();
    //  AppLocalizations localize = context.localization();
    return WillPopScope(
      onWillPop: () async {
        return _onPop(currentSettings);
      },
      child: MyAppWrap(
        appBar: AppBar(
          title: Text(localization.title_settings),
        ),
        body: Padding(
          padding: theme.custom.defaultAppPadding,
          child: Column(children: settingWidgets),
        ),
      ),
    );
  }
}

class _SettingsElem extends StatelessWidget {
  final _SettingsModel child;

  const _SettingsElem({required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = MyAppTheme.of(context);
    List<Widget> widgets = [
      Expanded(
          child: Text(child.title, style: theme.material.textTheme.titleSmall)),
      child.action
    ];
    Widget finalWidget = child.position == _SettingsPosition.vertical
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: widgets,
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: widgets,
          );
    return IntrinsicHeight(
      child: DefaultContainer(
          padding: theme.custom.defaultAppPadding / 2,
          margin: EdgeInsets.symmetric(
              vertical: theme.custom.defaultAppMargin.vertical / 2),
          child: finalWidget),
    );
  }
}

class _SettingsModel {
  final String title;
  final Widget action;
  final _SettingsPosition position;

  const _SettingsModel({
    required this.title,
    required this.action,
    this.position = _SettingsPosition.horizontal,
  });
}

enum _SettingsPosition {
  vertical,
  horizontal,
}
