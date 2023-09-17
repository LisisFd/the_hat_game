import 'package:app_core/app_core.dart';
import 'package:app_main/controllers/controllers.dart';
import 'package:app_main/models/entities/entities.dart';
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
  final ISettingService settingsService = getWidgetService<ITheHatAppService>();

  TheHatAppSettings? appSettings;

  @override
  void initState() {
    appSettings = settingsService.appSettings.value;
    super.initState();
  }

  void _updateSettings(TheHatAppSettings newSettings) {
    setState(() {
      appSettings = newSettings;
    });
  }

  bool _onPop(TheHatAppSettings newSettings) {
    settingsService.updateSettings(newSettings);
    return true;
  }

//TODO: add localizaton
  @override
  Widget build(BuildContext context) {
    final TheHatAppSettings? currentSettings = appSettings;

    if (currentSettings == null) {
      return const SizedBox();
    }
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
                    Text("${currentSettings.timePlayerTurn.toInt()}")
                  ],
                ),
                Slider(
                    max: 120,
                    min: 10,
                    value: currentSettings.timePlayerTurn,
                    onChanged: (val) {
                      _updateSettings(
                        currentSettings.copyWith(timePlayerTurn: val),
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
