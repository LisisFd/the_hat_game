import 'package:app_core/app_core.dart';
import 'package:app_main/controllers/controllers.dart';
import 'package:app_main/localization.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:core_get_it/core_get_it.dart';

class SettingsScreenArguments {}

class SettingsScreen extends StatefulWidget {
  static Widget pageBuilder(
      BuildContext context, PageArgumentsGeneric arguments) {
    return const SettingsScreen();
  }

  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    with SubjectWidgetContext {
  final ISettingService settings = getWidgetService<ITheHatAppService>();

  @override
  void initState() {
    listen(settings.appSettings);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations localize = context.localization();
    return MyAppWrap(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text('Settings')],
        ),
      ),
    );
  }
}
