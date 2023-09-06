import 'package:core_flutter/core_flutter.dart';
import 'package:core_ui/core_ui.dart';

import 'app_color_scheme.dart';

class ThemeConstants {
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
  static const Color primaryColor = Color(0xFF1C50D0);
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

  static ColorScheme _getScheme() {
    return AppColorScheme.colorScheme;
  }

  static ThemeData createMaterial() {
    final ThemeData theme = ThemeData(
      useMaterial3: true,
      colorScheme: _getScheme(),
      appBarTheme: AppBarTheme(
          backgroundColor: _getScheme().background, scrolledUnderElevation: 0),
      iconTheme: IconThemeData(color: AppColorScheme.secondary, size: 30),
      fontFamily: ThemeConstants.fontFamily,
      textTheme: _textTheme(),
      primaryTextTheme: _textTheme(),
      brightness: Brightness.light,
      popupMenuTheme: PopupMenuThemeData(
        color: AppColorScheme.card,
        surfaceTintColor: AppColorScheme.card,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColorScheme.placeholder),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: AppColorScheme.placeholder.withOpacity(0.5)),
        ),
        alignLabelWithHint: true,
        hintStyle:
            _textTheme().bodyLarge?.copyWith(color: AppColorScheme.placeholder),
        helperStyle:
            _textTheme().bodySmall?.copyWith(color: AppColorScheme.placeholder),
        labelStyle:
            MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
          if (states.contains(MaterialState.error)) {
            return _textTheme()
                    .bodyLarge
                    ?.copyWith(color: _getScheme().error) ??
                const TextStyle();
          } else if (states.contains(MaterialState.disabled)) {
            return _textTheme()
                    .bodyLarge
                    ?.copyWith(color: AppColorScheme.placeholder) ??
                const TextStyle();
          }
          return _textTheme().bodyLarge?.copyWith(
                  color: AppColorScheme.secondary.withOpacity(0.7)) ??
              const TextStyle();
        }),
        floatingLabelStyle:
            MaterialStateTextStyle.resolveWith((Set<MaterialState> states) {
          if (states.contains(MaterialState.error)) {
            return _textTheme()
                    .bodyLarge
                    ?.copyWith(color: _getScheme().error) ??
                const TextStyle();
          } else if (states.contains(MaterialState.focused)) {
            return _textTheme()
                    .bodyLarge
                    ?.copyWith(color: _getScheme().primary) ??
                const TextStyle();
          }
          return _textTheme()
                  .bodyLarge
                  ?.copyWith(color: AppColorScheme.secondary) ??
              const TextStyle();
        }),
        prefixIconColor:
            MaterialStateColor.resolveWith((Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColorScheme.placeholder;
          }
          return AppColorScheme.secondary;
        }),
        suffixIconColor:
            MaterialStateColor.resolveWith((Set<MaterialState> states) {
          if (states.contains(MaterialState.disabled)) {
            return AppColorScheme.placeholder;
          }
          return AppColorScheme.secondary;
        }),
        helperMaxLines: 4,
      ),
      listTileTheme: ListTileThemeData(
        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
        iconColor: AppColorScheme.secondary,
        minLeadingWidth: 0,
        minVerticalPadding: 22,
        selectedTileColor: AppColorScheme.neutralTonal.c95.withOpacity(.5),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return AppColorScheme.placeholder;
              }
              return _getScheme().onPrimary;
            },
          ),
          overlayColor: MaterialStateProperty.resolveWith(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered) ||
                  states.contains(MaterialState.focused)) {
                return AppColorScheme.primaryTonal.c30;
              } else if (states.contains(MaterialState.pressed)) {
                return AppColorScheme.primaryTonal.c20;
              }
              return _getScheme().primary;
            },
          ),
          splashFactory: InkRipple.splashFactory,
          backgroundColor: MaterialStateProperty.resolveWith(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return _getScheme().background;
              }
              return _getScheme().primary;
            },
          ),
          textStyle: MaterialStateProperty.all(_textTheme().labelLarge),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: _getScheme().primary,
          backgroundColor: Colors.transparent,
          textStyle: _textTheme().labelLarge,
          side: BorderSide(color: _getScheme().primary),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.resolveWith(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return AppColorScheme.placeholder;
              }
              return _getScheme().onSurface;
            },
          ),
          overlayColor: MaterialStateProperty.resolveWith(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return AppColorScheme.neutralTonal.c90;
              } else if (states.contains(MaterialState.focused)) {
                return AppColorScheme.neutralTonal.c80;
              } else if (states.contains(MaterialState.pressed)) {
                return AppColorScheme.neutralTonal.c70;
              }
              return AppColorScheme.neutralTonal.c95;
            },
          ),
          backgroundColor: MaterialStateProperty.resolveWith(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.disabled)) {
                return _getScheme().background;
              }
              return AppColorScheme.neutralTonal.c95;
            },
          ),
          textStyle: MaterialStateProperty.all(_textTheme().labelLarge),
        ),
      ),
      segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(AppColorScheme.secondary),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.selected)) {
                return _getScheme().background;
              }
              return Colors.white;
            },
          ),
          textStyle: MaterialStateProperty.all(_textTheme().labelLarge),
        ),
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return AppColorScheme.stroke;
            } else if (states.contains(MaterialState.selected)) {
              return _getScheme().primary;
            }
            return AppColorScheme.placeholder;
          },
        ),
      ),
      radioTheme: RadioThemeData(
        fillColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.disabled)) {
              return AppColorScheme.stroke;
            } else if (states.contains(MaterialState.selected)) {
              return _getScheme().primary;
            }
            return AppColorScheme.placeholder;
          },
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          textStyle: _textTheme().labelLarge,
        ),
      ),
      chipTheme: ThemeConstants.chipThemeDefault,
      progressIndicatorTheme:
          ProgressIndicatorThemeData(linearTrackColor: _getScheme().primary),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColorScheme.card,
        surfaceTintColor: AppColorScheme.card,
        shadowColor: AppColorScheme.card,
      ),
      dialogTheme: DialogTheme(
        backgroundColor: AppColorScheme.card,
        shadowColor: AppColorScheme.card,
        surfaceTintColor: AppColorScheme.card,
      ),
      cardColor: AppColorScheme.card,
      cardTheme: CardTheme(
        color: AppColorScheme.card,
        surfaceTintColor: AppColorScheme.card,
        elevation: 0,
        shadowColor: AppColorScheme.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: AppColorScheme.stroke,
          ),
        ),
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColorScheme.card,
        surfaceTintColor: AppColorScheme.card,
      ),
      dividerTheme: const DividerThemeData(
        space: 0,
      ),
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
      displayLarge: TextStyle(
        fontFamilyFallback: ThemeConstants.fallback,
        fontWeight: FontWeight.w400,
        fontSize: 57,
      ),
      displayMedium: TextStyle(
        fontFamilyFallback: ThemeConstants.fallback,
        fontWeight: FontWeight.w400,
        fontSize: 45,
      ),
      displaySmall: TextStyle(
        fontFamilyFallback: ThemeConstants.fallback,
        fontWeight: FontWeight.w400,
        fontSize: 36,
      ),
      headlineLarge: TextStyle(
        fontFamilyFallback: ThemeConstants.fallback,
        fontWeight: FontWeight.w400,
        fontSize: 32,
      ),
      headlineMedium: TextStyle(
        fontFamilyFallback: ThemeConstants.fallback,
        fontWeight: FontWeight.w400,
        fontSize: 28,
      ),
      headlineSmall: TextStyle(
        fontFamilyFallback: ThemeConstants.fallback,
        fontWeight: FontWeight.w400,
        fontSize: 24,
      ),
      titleLarge: TextStyle(
        fontFamilyFallback: ThemeConstants.fallback,
        fontWeight: FontWeight.w400,
        fontSize: 22,
      ),
      titleMedium: TextStyle(
          fontFamilyFallback: ThemeConstants.fallback,
          fontWeight: FontWeight.w500,
          fontSize: 16,
          letterSpacing: 0.15),
      titleSmall: TextStyle(
          fontFamilyFallback: ThemeConstants.fallback,
          fontWeight: FontWeight.w500,
          fontSize: 14,
          letterSpacing: 0.1),
      labelLarge: TextStyle(
          fontFamilyFallback: ThemeConstants.fallback,
          fontWeight: FontWeight.w500,
          fontSize: 14,
          letterSpacing: 0.1),
      labelMedium: TextStyle(
          fontFamilyFallback: ThemeConstants.fallback,
          fontWeight: FontWeight.w500,
          fontSize: 12,
          letterSpacing: 0.5),
      labelSmall: TextStyle(
          fontFamilyFallback: ThemeConstants.fallback,
          fontWeight: FontWeight.w500,
          fontSize: 11,
          letterSpacing: 0.5),
      bodyLarge: TextStyle(
          fontFamilyFallback: ThemeConstants.fallback,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5),
      bodyMedium: TextStyle(
          fontFamilyFallback: ThemeConstants.fallback,
          fontWeight: FontWeight.w400,
          fontSize: 14,
          letterSpacing: 0.25),
      bodySmall: TextStyle(
          fontFamilyFallback: ThemeConstants.fallback,
          fontWeight: FontWeight.w400,
          color: ThemeConstants.hideColor,
          fontSize: 12,
          letterSpacing: 0.4),
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
