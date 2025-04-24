import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:studiffy/core/localization/flutter_localization.dart';

import 'package:studiffy/core/style/dimensions.dart';
import 'package:studiffy/core/style/themes/app_text_styles.dart';

import 'app_colors.dart';

class AppTheme {
  // Theme Data Accessors
  static ThemeData get lightTheme => _lightTheme;
  static ThemeData get darkTheme => _darkTheme;
  static bool get islight =>
      Theme.of(mainContext).brightness == Brightness.light;
  static Color get disabledColor =>
      islight ? lightDisabledColor : darkDisabledColor;

  // Light Theme Definition
  static final ThemeData _lightTheme = ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: backgroundLight,
      primaryColor: accentColorLight,
      colorScheme: _lightColorScheme,
      textTheme: AppTextStyles.textTheme,
      appBarTheme: _appBarTheme(accentColorLight, textColorLight, true),
      inputDecorationTheme: _inputDecorationTheme,
      scrollbarTheme: _scrollbarTheme(accentColorLight),
      filledButtonTheme: _filledButtonTheme(accentColorLight, lightColor, true),
      elevatedButtonTheme: _elevatedButtonTheme(accentColorLight, true),
      outlinedButtonTheme: _outlinedButtonTheme(accentColorLight, true),
      textButtonTheme: _textButtonTheme(accentColorLight, true),
      checkboxTheme: _checkboxTheme(darkColor, accentColorLight),
      tabBarTheme: _tabBarTheme(accentColorLight, true),
      dialogTheme: _dilaogTheme(accentColorLight, true));

  // Dark Theme Definition
  static final ThemeData _darkTheme = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: backgroundDark,
      primaryColor: accentColorDark,
      colorScheme: _darkColorScheme,
      textTheme: AppTextStyles.textTheme,
      appBarTheme: _appBarTheme(accentColorDark, textColorDark, false),
      inputDecorationTheme: _inputDecorationTheme,
      scrollbarTheme: _scrollbarTheme(accentColorDark),
      filledButtonTheme: _filledButtonTheme(accentColorDark, darkColor, false),
      elevatedButtonTheme: _elevatedButtonTheme(accentColorDark, false),
      outlinedButtonTheme: _outlinedButtonTheme(accentColorDark, false),
      textButtonTheme: _textButtonTheme(accentColorDark, false),
      checkboxTheme: _checkboxTheme(lightColor, accentColorDark),
      tabBarTheme: _tabBarTheme(accentColorDark, false),
      dialogTheme: _dilaogTheme(accentColorDark, false));

  // Color Schemes
  static const ColorScheme _lightColorScheme = ColorScheme.light(
    primary: accentColorLight,
    onPrimary: textOnPrimary,
    secondary: secondaryAccentColorLight,
    onSecondary: Colors.white,
    surface: backgroundLight,
    onSurface: textColorLight,
    error: Colors.red,
    onError: Colors.white,
  );

  static const ColorScheme _darkColorScheme = ColorScheme.dark(
    primary: accentColorDark,
    onPrimary: textOnPrimary,
    secondary: secondaryAccentColorDark,
    onSecondary: Colors.white,
    surface: backgroundDark,
    onSurface: textColorDark,
    error: Colors.red,
    onError: Colors.white,
  );

  // Theme Components
  static AppBarTheme _appBarTheme(
      Color primaryColor, Color textColor, bool isLight) {
    return AppBarTheme(
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarBrightness: isLight ? Brightness.light : Brightness.dark,
        statusBarIconBrightness: isLight ? Brightness.dark : Brightness.light,
        systemNavigationBarIconBrightness:
            isLight ? Brightness.dark : Brightness.light,
        systemNavigationBarColor:
            (isLight ? Colors.black : Colors.white).withOpacity(0.01),
      ),
      centerTitle: true,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.transparent,
      foregroundColor: textColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Dimensions.extraLargeRadius,
          bottomLeft: Dimensions.extraLargeRadius,
        ),
      ),
    );
  }

  static const InputDecorationTheme _inputDecorationTheme =
      InputDecorationTheme(
    filled: false,
    hintStyle: TextStyle(color: darkDisabledColor),
    isCollapsed: true,
    contentPadding: EdgeInsets.only(
      left: 20,
      right: 20,
      top: 32,
      bottom: 5,
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: Dimensions.largeBorderRadius,
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: Dimensions.largeBorderRadius,
    ),
    floatingLabelBehavior: FloatingLabelBehavior.always,
  );

  static ScrollbarThemeData _scrollbarTheme(Color thumbColor) {
    return ScrollbarThemeData(
      trackVisibility: const WidgetStatePropertyAll(true),
      thumbVisibility: const WidgetStatePropertyAll(true),
      thumbColor: WidgetStatePropertyAll(thumbColor),
    );
  }

  static FilledButtonThemeData _filledButtonTheme(
      Color primaryColor, Color textColor, bool isLight) {
    return FilledButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) {
            return isLight ? Colors.grey.shade300 : Colors.grey.shade700;
          }
          return primaryColor;
        }),
        foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) {
            return isLight ? Colors.grey.shade500 : Colors.grey.shade400;
          }
          return textColor;
        }),
        overlayColor: WidgetStatePropertyAll(primaryColor.withOpacity(0.1)),
        elevation: const WidgetStatePropertyAll(0),
        fixedSize: const WidgetStatePropertyAll(Size.fromHeight(50)),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: Dimensions.mediumBorderRadius,
          ),
        ),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }

  static ElevatedButtonThemeData _elevatedButtonTheme(
      Color primaryColor, bool isLight) {
    return ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) {
            return isLight ? Colors.grey.shade300 : Colors.grey.shade700;
          }
          return primaryColor;
        }),
        foregroundColor: const WidgetStatePropertyAll(textOnPrimary),
        overlayColor: WidgetStatePropertyAll(primaryColor.withOpacity(0.1)),
        elevation: WidgetStateProperty.resolveWith<double>((states) {
          if (states.contains(WidgetState.pressed)) return 0;
          if (states.contains(WidgetState.disabled)) return 0;
          return 2;
        }),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: Dimensions.mediumBorderRadius,
          ),
        ),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }

  static OutlinedButtonThemeData _outlinedButtonTheme(
      Color primaryColor, bool isLight) {
    return OutlinedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) {
            return isLight ? Colors.grey.shade300 : Colors.grey.shade700;
          }
          return Colors.transparent;
        }),
        foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) {
            return isLight ? Colors.grey.shade500 : Colors.grey.shade400;
          }
          return primaryColor;
        }),
        side: WidgetStateProperty.resolveWith<BorderSide>((states) {
          if (states.contains(WidgetState.disabled)) {
            return BorderSide(
              color: isLight ? Colors.grey.shade500 : Colors.grey.shade400,
            );
          }
          return BorderSide(color: primaryColor);
        }),
        overlayColor: WidgetStatePropertyAll(primaryColor.withOpacity(0.1)),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: Dimensions.mediumBorderRadius,
          ),
        ),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }

  static TextButtonThemeData _textButtonTheme(
      Color primaryColor, bool isLight) {
    return TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.resolveWith<Color>((states) {
          if (states.contains(WidgetState.disabled)) {
            return isLight ? Colors.grey.shade500 : Colors.grey.shade400;
          }
          return primaryColor;
        }),
        overlayColor: WidgetStatePropertyAll(primaryColor.withOpacity(0.1)),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: Dimensions.mediumBorderRadius,
          ),
        ),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),
    );
  }

  static CheckboxThemeData _checkboxTheme(Color borderColor, Color fillColor) {
    return CheckboxThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      side: BorderSide(
        color: borderColor,
        width: 1.5,
      ),
      fillColor: WidgetStateProperty.resolveWith<Color>((states) {
        if (states.contains(WidgetState.selected)) {
          return fillColor;
        }
        return Colors.transparent;
      }),
    );
  }

  static TabBarTheme _tabBarTheme(Color primaryColor, bool isLight) {
    return TabBarTheme(
      indicatorSize: TabBarIndicatorSize.tab,
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(
          width: 3,
          color: isLight ? textColorLight : textColorDark,
        ),
        borderRadius: Dimensions.smallBorderRadius,
      ),
      labelStyle: AppTextStyles.textTheme.titleLarge?.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w900,
          color: isLight ? textColorLight : textColorDark),
      unselectedLabelStyle: AppTextStyles.textTheme.titleSmall?.copyWith(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: isLight ? Colors.grey.shade600 : Colors.grey.shade400,
      ),
      dividerColor: Colors.grey.shade400,
    );
  }

  static DialogTheme _dilaogTheme(Color primaryColor, bool isLight) {
    return DialogTheme(
      barrierColor: isLight ? Colors.grey.shade600 : Colors.grey.shade400,
      backgroundColor: isLight ? Colors.grey.shade600 : Colors.grey.shade400,
    );
  }
}
