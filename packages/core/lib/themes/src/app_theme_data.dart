import 'package:flutter/material.dart';

import '../themes.dart';

class AppThemeData {
  static const _lightFillColor = AppColors.black;
  static const _darkFillColor = AppColors.white;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData = themeData(_lightFocusColor);
  static ThemeData darkThemeData = themeData(_darkFocusColor);

  static ThemeData themeData(Color focusColor) {
    return ThemeData(
        useMaterial3: true,
        // colorScheme: colorScheme,
        textTheme: _textTheme,

        //CardTheme
        cardTheme: CardTheme(
          elevation: AppSize.s3,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s10)),
        ),

        //Icon Theme
        iconTheme: const IconThemeData(),
        highlightColor: Colors.transparent,
        focusColor: focusColor,

        //Elevated Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          textStyle: getMediumStyle(
            fontSize: 14,
          ),
        )),

        // Outline Button Theme
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
          shadowColor: Colors.transparent,
          side: const BorderSide(color: AppColors.greYer),
          shape: RoundedRectangleBorder(
              side: const BorderSide(color: AppColors.black, width: 10),
              borderRadius: BorderRadius.circular(10)),
          fixedSize: const Size(AppSize.s110, AppSize.s40),
        )),

        // AppBar Theme
        appBarTheme: const AppBarTheme(
          // backgroundColor: AppColors.aquaBlue,
          elevation: 0,
          iconTheme: IconThemeData(),
        ),

        // Snackbar Theme
        snackBarTheme: SnackBarThemeData(
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            contentTextStyle: getMediumStyle(fontSize: 15)),

        // Input Decoration Theme
        inputDecorationTheme: InputDecorationTheme(
            errorStyle: getLightStyle(fontSize: FontSize.s16),
            labelStyle: getMediumStyle(fontSize: 14.0),
            errorBorder: const UnderlineInputBorder(borderSide: BorderSide()),
            focusedBorder:
                const UnderlineInputBorder(borderSide: BorderSide(width: 2)),
            border:
                const UnderlineInputBorder(borderSide: BorderSide(width: 2))),

        //TabBarTheme
        tabBarTheme: TabBarTheme(
          indicator: BoxDecoration(borderRadius: BorderRadius.circular(100)),
          labelStyle: getMediumStyle(fontSize: 16),
          unselectedLabelStyle: getMediumStyle(fontSize: FontSize.s14),
        ));
  }

  // static const ColorScheme lightColorScheme = ColorScheme(
  //   primary: AppColors.black,
  //   primaryContainer: AppColors.darkBlue,
  //   secondary: AppColors.pink,
  //   secondaryContainer: AppColors.orange,
  //   background: Color(0xFFE6EBEB),
  //   surface: Color(0xFFFAFBFB),
  //   onBackground: Colors.white,
  //   error: _lightFillColor,
  //   onError: _lightFillColor,
  //   onPrimary: _lightFillColor,
  //   onSecondary: Color(0xFF322942),
  //   onSurface: Color(0xFF241E30),
  //   brightness: Brightness.light,
  //   tertiary: AppColors.beige,
  //   tertiaryContainer: AppColors.lightOrange,
  //   onTertiary: AppColors.lightPink,
  //   onTertiaryContainer: AppColors.greyBlue,
  //   shadow: AppColors.grey,
  //   onSecondaryContainer: AppColors.greYer,
  //   onPrimaryContainer: AppColors.greYest,
  // );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: AppColors.aquaBlue,
    primaryContainer: AppColors.darkBlue,
    secondary: AppColors.pink,
    secondaryContainer: AppColors.orange,
    background: Color(0xFF241E30),
    surface: Color(0xFF1F1929),
    onBackground: Color(0x0DFFFFFF), // White with 0.05 opacity
    error: _darkFillColor,
    onError: _darkFillColor,
    onPrimary: _darkFillColor,
    onSecondary: _darkFillColor,
    onSurface: _darkFillColor,
    brightness: Brightness.dark,
  );

  static const regular = FontWeight.w400;
  static const medium = FontWeight.w500;
  static const semiBold = FontWeight.w600;
  static const bold = FontWeight.w700;

  static final TextTheme _textTheme = TextTheme(
    displayLarge: const TextStyle(fontSize: 59.0, fontFamily: "Gotham"),
    displayMedium: const TextStyle(fontSize: 47.0, fontFamily: "Gotham"),
    displaySmall: const TextStyle(fontSize: 38.0, fontFamily: "Gotham"),
    headlineLarge: const TextStyle(
        fontWeight: bold, fontSize: 34.0, fontFamily: "SuezOne"),
    headlineMedium: getMediumStyle(fontSize: 27.0),
    headlineSmall: getBoldStyle(fontSize: 18),
    titleLarge: getMediumStyle(fontSize: 18),
    titleMedium: getExtraLightStyle(
      fontSize: 18.0,
    ),
    titleSmall: getExtraMoreLightStyle(
      fontSize: 18.0,
    ),
    labelLarge: getLightStyle(fontSize: 15.0),
    labelMedium: getRegularStyle(fontSize: 12.0),
    labelSmall: getLightStyle(fontSize: 12.0),
    bodyLarge: getRegularStyle(fontSize: 15),
    bodyMedium: getMediumStyle(fontSize: 15.0),
    bodySmall: getBoldStyle(fontSize: 12.0),
  );
}
