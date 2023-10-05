import 'package:core_api/core_api.dart';

part 'settings.g.dart';

@CopyWith()
@JsonSerializable()
class TheHatAppSettings implements IJsonWrite<TheHatAppSettings> {
  final int countWordsOnPlayer;
  final bool animation;
  final Duration timePlayerTurn;
  final bool lastWord;
  final bool isFirstLaunch;

  @override
  Map<String, dynamic> toJson() => _$TheHatAppSettingsToJson(this);

  factory TheHatAppSettings.fromJson(Map<String, dynamic> json) =>
      _$TheHatAppSettingsFromJson(json);

  const TheHatAppSettings({
    this.countWordsOnPlayer = 3,
    this.animation = true,
    this.timePlayerTurn = const Duration(seconds: 60),
    this.lastWord = true,
    this.isFirstLaunch = true,
  });
}
