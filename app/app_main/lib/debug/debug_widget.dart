import 'dart:convert';

import 'package:app_main/domain/domain.dart';
import 'package:core_app_test/core_app_testing.dart';
import 'package:core_flutter/core_flutter.dart';
import 'package:core_get_it/core_get_it.dart';

class DebugNavigationWidget extends AppTestWidgetBuilder {
  DebugNavigationWidget()
      : super(title: "Debug Navigation", id: "debugNavigation");

  @override
  Widget create(BuildContext context, AppTestApi api) {
    IGameRepository gameRepository = getWidgetService<IGameRepository>();
    TheHatAppGame? appGame = gameRepository.getGame();
    JsonEncoder encoder = const JsonEncoder.withIndent('  ');
    String prettyprint = encoder.convert(appGame?.toJson().toString());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(prettyprint),
      ],
    );
  }
}
