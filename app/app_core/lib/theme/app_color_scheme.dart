import 'package:core_flutter/core_flutter.dart';
import 'package:material_color_utilities/material_color_utilities.dart';

class AppColorScheme {
  static ColorScheme get colorScheme {
    ColorScheme colorScheme = ColorScheme.fromSeed(
      seedColor: primaryTonal.c40,
      secondary: secondaryTonal.c40,
      onSecondary: secondaryTonal.c100,
      secondaryContainer: secondaryTonal.c90,
      onSecondaryContainer: secondaryTonal.c10,
      surface: neutralTonal.c99,
      onSurface: neutralTonal.c10,
      tertiary: tertiaryTonal.c40,
      background: background,
      error: error,
    );

    return colorScheme;
  }

  static Scheme _scheme(Color color) {
    return Scheme.light(color.value);
  }

  static Palette toTonalPalette(Color value) {
    final color = Hct.fromInt(value.value);
    TonalPalette palette = TonalPalette.of(color.hue, color.chroma);
    List<Color> colors = palette.asList.map((e) => Color(e)).toList();
    Palette tonalPalette = Palette(colors);
    return tonalPalette;
  }

  static Color get primary => const Color(0xFF1C50D0);

  static Color get secondary => const Color(0xFF23252F);

  static Color get background => const Color(0xFFEBEDF2);

  static Color get card => const Color(0xFFFFFFFF);

  static Color get placeholder => const Color(0xFF94A3B7);

  static Color get stroke => const Color(0xFFD9DADE);

  static Color get error => const Color(0xFFFF3B30);

  static Palette get primaryTonal => toTonalPalette(primary);

  static Palette get secondaryTonal =>
      toTonalPalette(Color(_scheme(secondary).primary));

  static Palette get errorTonal =>
      toTonalPalette(Color(_scheme(error).primary));

  static Palette get tertiaryTonal =>
      toTonalPalette(Color(_scheme(primary).tertiary));

  static Palette get neutralTonal =>
      toTonalPalette(Color(_scheme(primary).background));
}

class Palette {
  final List<Color> colors;

  Palette(this.colors);

  Color get c0 => colors[0];

  Color get c10 => colors[1];

  Color get c20 => colors[2];

  Color get c30 => colors[3];

  Color get c40 => colors[4];

  Color get c50 => colors[5];

  Color get c60 => colors[6];

  Color get c70 => colors[7];

  Color get c80 => colors[8];

  Color get c90 => colors[9];

  Color get c95 => colors[10];

  Color get c99 => colors[11];

  Color get c100 => colors[12];
}
