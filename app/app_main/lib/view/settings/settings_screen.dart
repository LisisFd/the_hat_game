import 'package:app_core/app_core.dart';
import 'package:app_main/controllers/controllers.dart';
import 'package:app_main/domain/domain.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:core_get_it/core_get_it.dart';

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

//TODO: add localizaton
  @override
  Widget build(BuildContext context) {
    final TheHatAppSettings currentSettings = appSettings;

    //  AppLocalizations localize = context.localization();
    return WillPopScope(
      onWillPop: () async {
        return _onPop(currentSettings);
      },
      child: MyAppWrap(
        appBar: AppBar(
          title: const Text('Settings'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Count words on player'),
                Row(
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
                    Text('${currentSettings.countWordsOnPlayer}'),
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
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Animation'),
                Switch(
                    value: currentSettings.animation,
                    onChanged: (val) {
                      _updateSettings(currentSettings.copyWith(animation: val));
                    })
              ],
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Round timer'),
                    Text("${currentSettings.timePlayerTurn.inSeconds}")
                  ],
                ),
                Slider(
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
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Last word'),
                Switch(
                    value: currentSettings.lastWord,
                    onChanged: (val) {
                      _updateSettings(
                        currentSettings.copyWith(lastWord: val),
                      );
                    })
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
