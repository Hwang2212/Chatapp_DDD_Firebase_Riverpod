import 'package:flutter/material.dart';

import '../themes.dart';

class AppThemeData {
  static const _lightFillColor = AppColors.black;
  static const _darkFillColor = AppColors.white;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
        colorScheme: colorScheme,
        textTheme: _textTheme,

        //CardTheme
        cardTheme: CardTheme(
          elevation: AppSize.s3,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s10)),
        ),

        //Icon Theme
        iconTheme: IconThemeData(color: colorScheme.onPrimary),
        canvasColor: colorScheme.background,
        scaffoldBackgroundColor: colorScheme.background,
        highlightColor: Colors.transparent,
        focusColor: focusColor,

        //Elevated Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                elevation: 0,
                disabledForegroundColor: colorScheme.onBackground,
                disabledBackgroundColor: colorScheme.shadow,
                // shadowColor: Colors.transparent,
                backgroundColor: colorScheme.primaryContainer,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                textStyle: getMediumStyle(
                    fontSize: 14, color: colorScheme.onBackground),
                foregroundColor: colorScheme.onPrimary)),

        // Outline Button Theme
        outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
          disabledForegroundColor: colorScheme.onBackground,
          disabledBackgroundColor: colorScheme.shadow,
          shadowColor: Colors.transparent,
          backgroundColor: colorScheme.onBackground,
          side: const BorderSide(color: AppColors.greYer),
          shape: RoundedRectangleBorder(
              side: const BorderSide(color: AppColors.black, width: 10),
              borderRadius: BorderRadius.circular(10)),
          fixedSize: const Size(AppSize.s110, AppSize.s40),
          foregroundColor: colorScheme.primaryContainer,
        )),

        // AppBar Theme
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.aquaBlue,
          elevation: 0,
          iconTheme: IconThemeData(color: colorScheme.primary),
        ),

        // Snackbar Theme
        snackBarTheme: SnackBarThemeData(
            actionTextColor: colorScheme.onBackground,
            behavior: SnackBarBehavior.floating,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: colorScheme.secondaryContainer,
            contentTextStyle:
                getMediumStyle(color: colorScheme.onBackground, fontSize: 15)),

        // Input Decoration Theme
        inputDecorationTheme: InputDecorationTheme(
            errorStyle: getLightStyle(fontSize: FontSize.s16)
                .copyWith(color: colorScheme.secondary),
            labelStyle: getMediumStyle(
                fontSize: 14.0, color: colorScheme.primaryContainer),
            errorBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: colorScheme.secondary)),
            focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: colorScheme.primaryContainer, width: 2)),
            border: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: colorScheme.primaryContainer, width: 2))),

        //TabBarTheme
        tabBarTheme: TabBarTheme(
            indicator: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(100)),
            labelStyle:
                getMediumStyle(color: colorScheme.onBackground, fontSize: 16),
            unselectedLabelStyle: getMediumStyle(
                color: colorScheme.primaryContainer.withOpacity(0.5),
                fontSize: FontSize.s14),
            unselectedLabelColor:
                colorScheme.primaryContainer.withOpacity(0.5)));
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: AppColors.black,
    primaryContainer: AppColors.darkBlue,
    secondary: AppColors.pink,
    secondaryContainer: AppColors.orange,
    background: Color(0xFFE6EBEB),
    surface: Color(0xFFFAFBFB),
    onBackground: Colors.white,
    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: _lightFillColor,
    onSecondary: Color(0xFF322942),
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
    tertiary: AppColors.beige,
    tertiaryContainer: AppColors.lightOrange,
    onTertiary: AppColors.lightPink,
    onTertiaryContainer: AppColors.greyBlue,
    shadow: AppColors.grey,
    onSecondaryContainer: AppColors.greYer,
    onPrimaryContainer: AppColors.greYest,
  );

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
