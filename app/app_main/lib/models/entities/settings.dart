import 'package:core_api/core_api.dart';

part 'settings.g.dart';

@CopyWith()
@JsonSerializable()
class TheHatAppSettings implements IJsonWrite<TheHatAppSettings> {
  final int countWordsOnPlayer;
  final bool animation;
  final int timePlayerTurn;
  final bool lastWord;

  @override
  Map<String, dynamic> toJson() => _$TheHatAppSettingsToJson(this);

  factory TheHatAppSettings.fromJson(Map<String, dynamic> json) =>
      _$TheHatAppSettingsFromJson(json);

  const TheHatAppSettings({
    this.countWordsOnPlayer = 3,
    this.animation = true,
    this.timePlayerTurn = 60,
    this.lastWord = true,
  });
}
