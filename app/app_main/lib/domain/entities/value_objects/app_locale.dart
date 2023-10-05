import 'package:core_api/core_api.dart';

part 'app_locale.g.dart';

@CopyWith()
@JsonSerializable()
class AppLocale implements IJsonWrite<AppLocale> {
  final String? locale;
  final bool sR;

  AppLocale({this.locale, this.sR = false});

  @override
  Map<String, dynamic> toJson() => _$AppLocaleToJson(this);

  factory AppLocale.fromJson(Map<String, dynamic> json) =>
      _$AppLocaleFromJson(json);
}
