import 'package:core_flutter/core_flutter.dart';
import 'package:core_get_it/core_get_it.dart';

class AppSubjectContext {
  final ManualSubjectContext _context = ManualSubjectContext();

  ManualSubjectContext get appContext => _context;
}

extension AppSubject on ServiceScope {
  void addAppSubject() {
    registerSingleton<AppSubjectContext>(AppSubjectContext());
  }
}
