import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppColors {
  static const backgroundLight = Color.fromRGBO(255, 253, 252, 1);
  static const mandarin = Color.fromRGBO(255, 135, 2, 1);
  static const black = Color.fromRGBO(76, 76, 105, 1);
  static const white = Color.fromRGBO(255, 255, 255, 1);
  static const grey2 = Color.fromRGBO(188, 188, 191, 1);
  static const grey3 = Color.fromRGBO(145, 158, 171, 1);
  static const grey4 = Color.fromRGBO(242, 242, 242, 1);
  static const grey5 = Color.fromRGBO(225, 221, 216, 1);
  static const mandarinTransparent = Color.fromRGBO(255, 135, 2, 0.25);
  static const shadow = Color.fromRGBO(182, 161, 192, 0.11);
}

final appTheme = ThemeData(
  primaryColor: AppColors.mandarin,
  scaffoldBackgroundColor: AppColors.backgroundLight,
  appBarTheme: const AppBarTheme(
    backgroundColor: AppColors.backgroundLight,
    surfaceTintColor: AppColors.backgroundLight,
  ),
  tabBarTheme: TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    indicator: BoxDecoration(
      borderRadius: BorderRadius.circular(47.0),
      color: AppColors.mandarin,
    ),
    labelColor: Colors.white,
    labelStyle: TextStyle(
      fontFamily: GoogleFonts.nunito().fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 12,
      color: AppColors.white,
    ),
    unselectedLabelColor: AppColors.grey2,
    unselectedLabelStyle: TextStyle(
      fontFamily: GoogleFonts.nunito().fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 12,
      color: AppColors.grey2,
    ),
    dividerHeight: 0,
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: AppColors.white,
    contentTextStyle: TextStyle(
      fontFamily: GoogleFonts.nunito().fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: AppColors.black,
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontFamily: GoogleFonts.nunito().fontFamily,
            fontWeight: FontWeight.w400,
            fontSize: 20,
            color: AppColors.white,
          ),
        ),
        minimumSize: const WidgetStatePropertyAll(
          Size(double.infinity, 44),
        ),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 15, vertical: 16),
        ),
        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(69.0),
        ))),
  ),
  chipTheme: ChipThemeData(
      showCheckmark: false,
      selectedColor: AppColors.mandarin,
      backgroundColor: AppColors.white,
      surfaceTintColor: Colors.transparent,
      padding: EdgeInsets.zero,
      labelPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      elevation: 4,
      pressElevation: 4,
      shadowColor:AppColors.shadow,
      selectedShadowColor: AppColors.shadow,
      side: BorderSide.none,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      )),
  textTheme: TextTheme(
    labelLarge: TextStyle(
      fontFamily: GoogleFonts.nunito().fontFamily,
      fontWeight: FontWeight.w800,
      fontSize: 16,
      color: AppColors.black,
    ),
    labelMedium: TextStyle(
      fontFamily: GoogleFonts.nunito().fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: AppColors.black,
    ),
    labelSmall: TextStyle(
      fontFamily: GoogleFonts.nunito().fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 11,
      color: AppColors.black,
    ),
    displayMedium: TextStyle(
      fontFamily: GoogleFonts.nunito().fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: AppColors.grey3,
    ),
    displaySmall: TextStyle(
      fontFamily: GoogleFonts.nunito().fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 11,
      color: AppColors.grey3,
    ),
    headlineLarge: TextStyle(
      fontFamily: GoogleFonts.nunito().fontFamily,
      fontWeight: FontWeight.w700,
      fontSize: 18,
      color: AppColors.grey2,
    ),
    headlineMedium: TextStyle(
      fontFamily: GoogleFonts.nunito().fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: AppColors.grey2,
    ),
  ),
);
