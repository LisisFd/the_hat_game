import 'package:core_flutter/core_flutter.dart';
import 'package:core_ui/core_ui.dart';

class ThemeConstants {
  static const textColor = Color(0xFF332E30);
  static const appColor = Color(0xFFFEAE62);
  static const heightBigButton = 64.0;
  static const minWidthBigButton = 320.0;
  static const maxWidthForm = 400.0;
  static const ChipThemeData chipThemeDefault = ChipThemeData(
    disabledColor: Colors.white,
    labelStyle: TextStyle(color: Colors.black),
    shape: StadiumBorder(side: BorderSide(color: Colors.black12)),
    selectedColor: primaryColor,
  );

  static const BorderRadius defaultCardRadius =
      BorderRadius.all(Radius.circular(20));
  static const ShapeBorder appBarDialogBorder = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(20.0),
      topRight: Radius.circular(20.0),
    ),
  );

  static const EdgeInsetsGeometry defaultCardPadding =
      EdgeInsetsDirectional.all(ThemeConstants.paddingPoint * 2);
  static const Color primaryColor = ThemeConstants.appColor;
  static const Color textOnPrimaryColor = Color(0xFFFFFFFF);
  static const Color hideColor = Color(0xFFA7A5AF);

  static const String fontFamily = 'Roboto';
  static const String thinFontFamily = 'RobotoCondensed';

  static const List<String> fallback = [
    'SF Pro',
    'Noto Sans',
    'Noto Serif',
    'sans-serif',
  ];

  static const double paddingPoint = 5;
  static const double sizePoint = 1;
  static const double appBarButtonSize = 18;
}

class ColorPallet {
  static const Color colorGreen = Color(0xFF00B611);
  static const Color colorBlue = Color(0xFF0073E5);
  static const Color colorOrange = Color(0xFFE54500);
  static const Color colorGrey = Color(0xFFA1A1A1);
}

class MyAppTheme extends CustomAppThemeData {
  MyAppTheme._(
      {required super.cardPadding,
      required super.primarySwatch,
      required super.defaultTextStyle,
      required this.appBarTextButtonStyle});

  final TextStyle appBarTextButtonStyle;

  static MyAppTheme? _themeCache;

  static MyAppTheme _createTheme() {
    var cache = _themeCache;
    if (cache != null) {
      return cache;
    }

    cache = MyAppTheme._(
      cardPadding: EdgeInsets.zero,
      primarySwatch: createMaterialColor(ThemeConstants.primaryColor),
      defaultTextStyle: const TextStyle(
        fontFamilyFallback: ThemeConstants.fallback,
        fontFamily: ThemeConstants.fontFamily,
        color: ThemeConstants.textColor,
      ),
      appBarTextButtonStyle: const TextStyle(
          decoration: TextDecoration.none,
          color: ThemeConstants.textOnPrimaryColor,
          fontSize: ThemeConstants.appBarButtonSize,
          fontWeight: FontWeight.normal),
    );

    _themeCache = cache;
    return cache;
  }

  static AppThemeData<MyAppTheme> _getTheme(BuildContext context) {
    var material = Theme.of(context);
    return AppThemeData<MyAppTheme>(material: material, custom: _createTheme());
  }

  static ColorScheme getColorScheme() {
    return ColorScheme.fromSeed(seedColor: ThemeConstants.appColor);
  }

  static ThemeData createMaterial() {
    final ThemeData theme = ThemeData(
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        backgroundColor: getColorScheme().secondary,
        titleTextStyle: _textTheme().titleLarge?.copyWith(
              color: getColorScheme().onSecondary,
            ),
        iconTheme: IconThemeData(color: getColorScheme().onSecondary),
      ),
      colorScheme: getColorScheme(),
      iconTheme: const IconThemeData(size: 30),
      fontFamily: ThemeConstants.fontFamily,
      textTheme: _textTheme(),
      primaryTextTheme: _textTheme(),
      brightness: Brightness.light,
    );
    return theme;
  }

  final Color primaryColor = ThemeConstants.primaryColor;
  final String thinFontFamily = ThemeConstants.thinFontFamily;

  final SizedBox padding1 = _padding(1);
  final SizedBox padding2 = _padding(2);
  final SizedBox padding3 = _padding(3);
  final SizedBox padding4 = _padding(4);
  final SizedBox padding5 = _padding(5);
  final SizedBox padding6 = _padding(6);

  final EdgeInsetsGeometry insetPadding1 = _insetPadding(1);
  final EdgeInsetsGeometry insetPadding2 = _insetPadding(2);
  final EdgeInsetsGeometry insetPadding3 = _insetPadding(3.5);

  final EdgeInsetsGeometry sideInsetPadding1 = _insetPadding(1, true);
  final EdgeInsetsGeometry sideInsetPadding2 = _insetPadding(2, true);
  final EdgeInsetsGeometry sideInsetPadding5 = _insetPadding(5, true);

  final EdgeInsetsGeometry defaultCardWithTitleMargin =
      const EdgeInsets.all(16);
  final EdgeInsetsGeometry defaultSplitCardMargin = const EdgeInsets.only(
    left: 16,
    right: 16,
    bottom: 16,
  );

  final double insertBannerHeight = _insertHeight(250);
  final double insertIndicatorHeight = _insertHeight(30);
  final double defaultAvatarSize = 54;
  final double cardWrapSpace = 20;

  final BorderRadius dropdownBorderRadius = ThemeConstants.defaultCardRadius;

  final ChipThemeData chipDefault = ThemeConstants.chipThemeDefault;

  static TextTheme _textTheme() {
    return const TextTheme(
      // displayLarge: TextStyle(
      //   fontFamilyFallback: ThemeConstants.fallback,
      //   fontWeight: FontWeight.w400,
      //   fontSize: 57,
      // ),
      // displayMedium: TextStyle(
      //   fontFamilyFallback: ThemeConstants.fallback,
      //   fontWeight: FontWeight.w400,
      //   fontSize: 45,
      // ),
      // displaySmall: TextStyle(
      //   fontFamilyFallback: ThemeConstants.fallback,
      //   fontWeight: FontWeight.w400,
      //   fontSize: 36,
      // ),
      headlineLarge: TextStyle(
        fontFamilyFallback: ThemeConstants.fallback,
        fontWeight: FontWeight.w400,
        fontSize: 32,
      ),
      //   headlineMedium: TextStyle(
      //     fontFamilyFallback: ThemeConstants.fallback,
      //     fontWeight: FontWeight.w400,
      //     fontSize: 28,
      //   ),
      //   headlineSmall: TextStyle(
      //     fontFamilyFallback: ThemeConstants.fallback,
      //     fontWeight: FontWeight.w400,
      //     fontSize: 24,
      //   ),
      titleLarge: TextStyle(
        fontFamilyFallback: ThemeConstants.fallback,
        fontWeight: FontWeight.w400,
        fontSize: 22,
      ),
      //   titleMedium: TextStyle(
      //       fontFamilyFallback: ThemeConstants.fallback,
      //       fontWeight: FontWeight.w500,
      //       fontSize: 16,
      //       letterSpacing: 0.15),
      //   titleSmall: TextStyle(
      //       fontFamilyFallback: ThemeConstants.fallback,
      //       fontWeight: FontWeight.w500,
      //       fontSize: 14,
      //       letterSpacing: 0.1),
      //   labelLarge: TextStyle(
      //       fontFamilyFallback: ThemeConstants.fallback,
      //       fontWeight: FontWeight.w500,
      //       fontSize: 14,
      //       letterSpacing: 0.1),
      //   labelMedium: TextStyle(
      //       fontFamilyFallback: ThemeConstants.fallback,
      //       fontWeight: FontWeight.w500,
      //       fontSize: 12,
      //       letterSpacing: 0.5),
      //   labelSmall: TextStyle(
      //       fontFamilyFallback: ThemeConstants.fallback,
      //       fontWeight: FontWeight.w500,
      //       fontSize: 11,
      //       letterSpacing: 0.5),
      //   bodyLarge: TextStyle(
      //       fontFamilyFallback: ThemeConstants.fallback,
      //       fontSize: 16,
      //       fontWeight: FontWeight.w400,
      //       letterSpacing: 0.5),
      //   bodyMedium: TextStyle(
      //       fontFamilyFallback: ThemeConstants.fallback,
      //       fontWeight: FontWeight.w400,
      //       fontSize: 14,
      //       letterSpacing: 0.25),
      //   bodySmall: TextStyle(
      //       fontFamilyFallback: ThemeConstants.fallback,
      //       fontWeight: FontWeight.w400,
      //       color: ThemeConstants.hideColor,
      //       fontSize: 12,
      //       letterSpacing: 0.4),
    );
  }

  static SizedBox _padding(double multiplier) {
    return SizedBox(
        width: ThemeConstants.paddingPoint * multiplier,
        height: ThemeConstants.paddingPoint * multiplier);
  }

  static EdgeInsetsGeometry _insetPadding(double multiplier,
      [bool sideOnly = false]) {
    double padding = ThemeConstants.paddingPoint * 2 * multiplier;
    if (sideOnly) {
      return EdgeInsetsDirectional.fromSTEB(padding, 0, padding, 0);
    }
    return EdgeInsetsDirectional.all(padding);
  }

  static double _insertHeight(
    double multiplier,
  ) {
    double height = ThemeConstants.sizePoint * multiplier;

    return height;
  }

  SizedBox padding(double multiplier) {
    return _padding(multiplier);
  }

  EdgeInsetsGeometry insetPadding(double multiplier) {
    return _insetPadding(multiplier);
  }

  static AppThemeData<MyAppTheme> of(BuildContext context) {
    return AppTheme.ofCustom<MyAppTheme>(context);
  }

  static void registerAsMainTheme() {
    AppTheme.registerTheme<MyAppTheme>(_getTheme);
  }
}
