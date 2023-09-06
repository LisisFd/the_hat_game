import 'package:app_main/localizations/generated/app_localizations.dart';
import 'package:core_flutter/core_flutter.dart';

extension AppLocalizationExtension on BuildContext {
  AppLocalizations localization() {
    return AppLocalizations.of(this)!;
  }
}

typedef LocalizeDelegate = String Function(AppLocalizations context);

extension LocalizeDelegateExtension on String Function(
    AppLocalizations context)? {
  String localize(BuildContext context) {
    var self = this;
    if (self == null) {
      return "";
    }
    return self(context.localization());
  }
}
