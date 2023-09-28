import 'package:core_flutter/core_flutter.dart';

abstract class IGameRestoreFlow extends FlowBase {
  IGameRestoreFlow({required super.context});

  void restoreGame();
}
