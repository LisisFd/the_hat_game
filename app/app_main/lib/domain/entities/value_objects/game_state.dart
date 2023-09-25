import 'package:core_api/core_api.dart';

enum GameState {
  @JsonValue('start')
  start,
  @JsonValue('paused')
  paused,
  @JsonValue('lastWord')
  lastWord,
}
