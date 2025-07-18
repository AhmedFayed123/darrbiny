import 'package:flutter/material.dart';

import '../constant/colors.dart';

/// Theme Constants
const double kHeadingSize = 24.0;
const double kSubHeadingSize = 20.0;
const double kBodyTextSize = 16.0;
const double kCaptionTextSize = 12.0;
const double kBorderRadius = 8.0;
const Color kDarkGreyColor = Color(0xFF212121);
const Color kDarkTextColor = Color(0xFF616161);
const Color kLightTextColor = Color(0xFFBDBDBD);
const Color kMediumGreyColor = Color(0xFF757575);
const Color kGreyColor = Color(0xFF9E9E9E);
const Color kLightGreyColor = Color(0xFFBDBDBD);

/// Light Theme Data
final ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: kWhiteColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: kWhiteColor,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: kDarkGreyColor,
      fontWeight: FontWeight.bold,
      fontSize: kHeadingSize,
    ),
    iconTheme: IconThemeData(color: kDarkGreyColor),
  ),
  primaryColor: kPrimaryColor,
  colorScheme: const ColorScheme.light(
    primary: kPrimaryColor,
    secondary: kSecondaryColor,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: kDarkGreyColor, fontSize: kHeadingSize),
    displayMedium: TextStyle(color: kDarkGreyColor, fontSize: kSubHeadingSize),
    bodyLarge: TextStyle(color: kDarkTextColor, fontSize: kBodyTextSize),
    bodyMedium: TextStyle(color: kLightTextColor, fontSize: kBodyTextSize),
    bodySmall: TextStyle(color: kMediumGreyColor, fontSize: kCaptionTextSize),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: kPrimaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(kBorderRadius),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: kWhiteColor, backgroundColor: kPrimaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
    ),
  ),
  iconTheme: const IconThemeData(
    color: kDarkGreyColor,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: kPrimaryColor,
    unselectedItemColor: kGreyColor,
    backgroundColor: kWhiteColor,
  ),
);

/// Dark Theme Data
final ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: kBlackColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: kBlackColor,
    elevation: 0,
    titleTextStyle: TextStyle(
      color: kWhiteColor,
      fontWeight: FontWeight.bold,
      fontSize: kHeadingSize,
    ),
    iconTheme: IconThemeData(color: kWhiteColor),
  ),
  primaryColor: kPrimaryColor,
  colorScheme: const ColorScheme.dark(
    primary: kPrimaryColor,
    secondary: kSecondaryColor,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: kWhiteColor, fontSize: kHeadingSize),
    displayMedium: TextStyle(color: kWhiteColor, fontSize: kSubHeadingSize),
    bodyLarge: TextStyle(color: kWhiteColor, fontSize: kBodyTextSize),
    bodyMedium: TextStyle(color: kLightGreyColor, fontSize: kBodyTextSize),
    bodySmall: TextStyle(color: kLightGreyColor, fontSize: kCaptionTextSize),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: kPrimaryColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(kBorderRadius),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: kWhiteColor, backgroundColor: kPrimaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
    ),
  ),
  iconTheme: const IconThemeData(
    color: kWhiteColor,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    selectedItemColor: kPrimaryColor,
    unselectedItemColor: kGreyColor,
    backgroundColor: kBlackColor,
  ),
);