import 'package:core_flutter/core_flutter.dart';
import 'package:core_utils/core_utils.dart';

class AppLifeStyleObserver with WidgetsBindingObserver {
  final BehaviorSubjectNotNull<AppLifecycleState> _appState =
      BehaviorSubjectNotNull.updateNotEqual(AppLifecycleState.resumed);

  IBehaviorSubjectReadonlyNotNull<AppLifecycleState> get appState => _appState;

  AppLifeStyleObserver() {
    _init();
  }

  void _init() {
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.resumed) {
      _appState.setValue(state);
    }
  }
}
