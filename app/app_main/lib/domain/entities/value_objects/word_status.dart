import 'package:core_api/core_api.dart';

enum WordStatus {
  @JsonValue('disable')
  disable,
  @JsonValue('active')
  active,
  @JsonValue('right')
  right,
  @JsonValue('skip')
  skip,
}
