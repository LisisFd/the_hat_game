import 'package:app_core/app_core.dart';
import 'package:core_ui/core_ui.dart';

class MyAppWrap extends AppWrap {
  const MyAppWrap({
    required super.body,
    super.key,
    super.appBar,
    super.safeArea = true,
    super.bottomNavigationBar,
    super.floatingActionButton,
    super.floatingActionButtonLocation,
    super.onWillPop,
    super.backgroundColor = ThemeConstants.primaryColor,
    super.enableAuthentication = false,
  });
}
