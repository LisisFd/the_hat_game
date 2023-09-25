import 'package:core_flutter/core_flutter.dart';

class AppConfig {
  AppConfig._();

  static const String storageKey = "2bfAM4FdkDDF";
  static const double phoneAppSize = 390;
  static const double tabletAppSize = 829;
  static const AssetImage fillHatIcon = AssetImage('images/fill.png');
  static const AssetImage strokeHatIcon = AssetImage('images/stroke.png');

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
