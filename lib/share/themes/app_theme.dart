import 'package:flutter/material.dart';

part 'app_colors.dart';

enum AppTheme { lightTheme, dartTheme }

final Map<AppTheme, ThemeData> appThemeData = {
  AppTheme.lightTheme: AppThemeData.lightThemeData,
  AppTheme.dartTheme: AppThemeData.darkThemeData,
};

class AppThemeData {
  AppThemeData._();

  static final AppColors _lightColors = AppColors(Brightness.light);
  static final AppColors _darkColors = AppColors(Brightness.dark);

  static AppColors get appLightColors => _lightColors;

  static AppColors get appDarkColors => _darkColors;

  static ThemeData lightThemeData = themeData(_lightColors);
  static ThemeData darkThemeData = themeData(_darkColors);

  static ThemeData themeData(AppColors appColor) {
    /// NOTE:
    /// Use Default MaterialDesign FontFamily (Roboto)
    /// Only modify them color
    return ThemeData(
      useMaterial3: true,
      iconTheme: IconThemeData(color: appColor.neutralColor[80]),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          disabledBackgroundColor: Colors.transparent,
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: appColor.primaryColor,
        selectionColor: appColor.primaryColor,
        selectionHandleColor: appColor.primaryColor,
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
      // checkboxTheme: CheckboxThemeData(
      //   fillColor: WidgetStateProperty.all(appColor.neutralColor[0]),
      //   checkColor: WidgetStateProperty.all(appColor.neutralColor[0]),
      // ),
      dividerTheme: DividerThemeData(
          color: appColor.neutralColor[20],
          thickness: 1,
          space: 0,
          indent: 0,
          endIndent: 0),
      visualDensity: VisualDensity.adaptivePlatformDensity,
      cardTheme: CardTheme(
        color: appColor.neutralColor[0],
        shadowColor: appColor.neutralColor[10],
        surfaceTintColor: appColor.neutralColor[0],
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), side: BorderSide.none),
        margin: EdgeInsets.zero,
      ),
      radioTheme: RadioThemeData(
          fillColor: WidgetStatePropertyAll(appColor.primaryColor)),
      dialogTheme: DialogTheme(backgroundColor: appColor.neutralColor),
      primaryColor: appColor.primaryColor,
      primaryColorLight: appColor.successColor,
      disabledColor: appColor.neutralColor[20],
      dialogBackgroundColor: appColor.neutralColor[0],
      cardColor: appColor.neutralColor[0],
      dividerColor: appColor.neutralColor[10],
      timePickerTheme: TimePickerThemeData(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), side: BorderSide.none),
      ),
      scaffoldBackgroundColor: appColor.neutralColor[0],
      hintColor: appColor.neutralColor[40],
      highlightColor: appColor.neutralColor[10],
      colorScheme: ColorScheme(
        brightness: appColor.brightness,
        primary: appColor.primaryColor,
        onPrimary: appColor.neutralColor[0]!,
        secondary: appColor.secondaryColor,
        onSecondary: appColor.neutralColor[100]!,
        tertiary: appColor.tertiaryColor,
        onTertiary: appColor.neutralColor[0]!,
        error: appColor.errorColor,
        onError: appColor.neutralColor[0]!,
        surface: appColor.neutralColor[0]!,
        onSurface: appColor.neutralColor[80]!,
        surfaceContainerHighest: appColor.neutralColor[95],
        surfaceTint: appColor.neutralColor[0],
        outline: appColor.neutralColor[10],
        inverseSurface: appColor.primaryColor,
        onInverseSurface: appColor.neutralColor[0],
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          height: 1.6,
          color: appColor.neutralColor[100],
        ),
        titleMedium: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          height: 1.5,
          color: appColor.neutralColor[100],
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          height: 1.5,
          color: appColor.neutralColor[100],
        ),
        titleSmall: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          height: 1.5,
          color: appColor.neutralColor[100],
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          height: 1.5,
          color: appColor.neutralColor[100],
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          height: 1.5,
          color: appColor.neutralColor[100],
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          height: 1.6,
          color: appColor.neutralColor[100],
        ),
        displaySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          height: 1.5,
          color: appColor.neutralColor[100],
        ),
      ),
    );
  }
}
