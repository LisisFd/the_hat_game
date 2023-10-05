import 'package:core_flutter/core_flutter.dart';

class AppConfig {
  AppConfig._();

  static const String storageKey = "2bfAM4FdkDDF";
  static const double phoneAppSize = 390;
  static const double tabletAppSize = 829;
  static const AssetImage fillHatIcon = AssetImage('images/fill.png');
  static const AssetImage bottomHat = AssetImage('images/hat_bottom.png');
  static const AssetImage strokeHatIcon = AssetImage('images/stroke.png');
  static const String animationSwipeRight =
      'assets/animations/swipe_right.json';
  static const String animationSwipeLeft = 'assets/animations/swipe_left.json';
  static const String animationHatBounce = 'assets/animations/hat_bounce.json';
  static const String animationHatRotate = 'assets/animations/hat_rotate.json';
  static const String animationWinner = 'assets/animations/winner.json';
  static const ua = 'ua';
  static const defLocale = 'en';

  static const flagUa = AssetImage('images/ua.png');
  static const flagEn = AssetImage('images/en.png');
  static const flagR = AssetImage('images/r.png');
  static const flagUaEn = AssetImage('images/ua_en.png');

  /// If you want to use ByteBrew analytics
  ///
  /// Uncomment the following lines and fill in the appId and appKey
  /// for Android and iOS
  ///
// static ByteBrewConfig androidConfig = const ByteBrewConfig(
//   appId: ,
//   appKey: ,
// );
// static ByteBrewConfig iosConfig = const ByteBrewConfig(
//   appId:,
//   appKey:,
// );
}
