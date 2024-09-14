import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const backgroundLight = Color.fromRGBO(255, 253, 252, 1);
const mandarin = Color.fromRGBO(255, 135, 2, 1);
const black = Color.fromRGBO(76, 76, 105, 1);
const white = Color.fromRGBO(255, 255, 255, 1);
const grey2 = Color.fromRGBO(188, 188, 191, 1);
const grey3 = Color.fromRGBO(145, 158, 171, 1);
const grey4 = Color.fromRGBO(242, 242, 242, 1);
const grey5 = Color.fromRGBO(225, 221, 216, 1);
const shadow = Color.fromRGBO(182, 161, 192, 0.11);

final appTheme = ThemeData(
  //colorScheme: ColorScheme.fromSeed(seedColor: mandarin),
  primaryColor: mandarin,
  scaffoldBackgroundColor: backgroundLight,
  tabBarTheme: TabBarTheme(
    indicatorSize: TabBarIndicatorSize.tab,
    indicator: BoxDecoration(
      borderRadius: BorderRadius.circular(47.0),
      color: mandarin,
    ),
    labelColor: Colors.white,
    labelStyle: TextStyle(
      fontFamily: GoogleFonts.nunito().fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 12,
      color: white,
    ),
    unselectedLabelColor: grey2,
    unselectedLabelStyle: TextStyle(
      fontFamily: GoogleFonts.nunito().fontFamily,
      fontWeight: FontWeight.w500,
      fontSize: 12,
      color: grey2,
    ),
    dividerHeight: 0,
  ),
  snackBarTheme: SnackBarThemeData(
    backgroundColor: white,
    contentTextStyle: TextStyle(
      fontFamily: GoogleFonts.nunito().fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: black,
    ),
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontFamily: GoogleFonts.nunito().fontFamily,
            fontWeight: FontWeight.w400,
            fontSize: 20,
            color: white,
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
      selectedColor: mandarin,
      backgroundColor: white,
      surfaceTintColor: Colors.transparent,
      padding: EdgeInsets.zero,
      labelPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
      elevation: 4,
      pressElevation: 4,
      shadowColor: shadow,
      selectedShadowColor: shadow,
      side: BorderSide.none,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      )),
  textTheme: TextTheme(
    labelLarge: TextStyle(
      fontFamily: GoogleFonts.nunito().fontFamily,
      fontWeight: FontWeight.w800,
      fontSize: 16,
      color: black,
    ),
    labelMedium: TextStyle(
      fontFamily: GoogleFonts.nunito().fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: black,
    ),
    labelSmall: TextStyle(
      fontFamily: GoogleFonts.nunito().fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 11,
      color: black,
    ),
    displayMedium: TextStyle(
      fontFamily: GoogleFonts.nunito().fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: grey3,
    ),
    displaySmall: TextStyle(
      fontFamily: GoogleFonts.nunito().fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 11,
      color: grey3,
    ),
    headlineLarge: TextStyle(
      fontFamily: GoogleFonts.nunito().fontFamily,
      fontWeight: FontWeight.w700,
      fontSize: 18,
      color: grey2,
    ),
    headlineMedium: TextStyle(
      fontFamily: GoogleFonts.nunito().fontFamily,
      fontWeight: FontWeight.w400,
      fontSize: 14,
      color: grey2,
    ),
  ),
);
