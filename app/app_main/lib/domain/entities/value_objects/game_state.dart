import 'package:core_api/core_api.dart';

enum GameState {
  @JsonValue('init')
  init,
  @JsonValue('play')
  play,
  @JsonValue('paused')
  paused,
  @JsonValue('lastWord')
  lastWord,
}
