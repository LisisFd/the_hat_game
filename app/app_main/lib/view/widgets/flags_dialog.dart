import 'package:app_main/controllers/controllers.dart';
import 'package:app_main/localization.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:core_get_it/core_get_it.dart';

import 'locale_flag_widget.dart';

class FlagsDialog {
  FlagsDialog._();

  static Future<Locale?> show(BuildContext context) async {
    final localization = context.localization();
    final IAppLocaleService appLocaleService =
        getWidgetService<IAppLocaleService>();
    Locale? locale;
    bool sR = appLocaleService.appLocale.value?.sR ?? false;
    List<Flag> flags = sR
        ? Flag.values.where((f) => f.locale != const Locale('ru')).toList()
        : Flag.values;
    List<Widget> flagsWidgets = flags.map((f) {
      return GestureDetector(
        onTap: () {
          locale = f.locale;
          Navigator.of(context).pop();
        },
        child: f.widget,
      );
    }).toList();
    await showDialog<Locale?>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(localization.title_language),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  return flagsWidgets[i];
                },
                separatorBuilder: (context, i) {
                  if (flagsWidgets.length - 1 == i) {
                    return const SizedBox.shrink();
                  } else {
                    return const SizedBox(
                      height: 2,
                      width: double.infinity,
                      child: ColoredBox(
                        color: Colors.black38,
                      ),
                    );
                  }
                },
                itemCount: flagsWidgets.length),
          ),
        );
      },
    );
    return locale;
  }
}
