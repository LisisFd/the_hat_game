import 'package:core_api/core_api.dart';

enum CurrentScreen {
  @JsonValue('setUp')
  setUp,
  @JsonValue('preGame')
  preGame,
  @JsonValue('rate')
  rate,
  @JsonValue('process')
  process,
  @JsonValue('result')
  result,
}
