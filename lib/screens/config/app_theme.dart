import 'package:flutter/material.dart';

import 'colors.dart';

@immutable
class AppTheme {
  static const colors = AppColors();

  const AppTheme._();

  static ThemeData define() {
    return ThemeData(
      fontFamily: "monsterrat",
      primaryColor: const Color(0xFF2A3867),
      focusColor: const Color(0xFF6f93ed),
      backgroundColor: const Color(0xFFFFFFFF),
      colorScheme: const ColorScheme(
        primary: Color(0xFF2A3867),
        onPrimary: Colors.white,
        background: Colors.white,
        onBackground: Colors.black,
        secondary: Color(0xFFD82953),
        onSecondary: Colors.white,
        error: Colors.black,
        onError: Colors.white,
        surface: Colors.white,
        onSurface: Colors.black,
        brightness: Brightness.light,
      ),
    );
  }

  // static final TextTheme appTextTheme = TextTheme(
  //   headline6: apptitles,
  //   subtitle2: appsubTitles,
  //   button: appbuttons,
  // );

  // static final TextStyle apptitles = TextStyle(
  //   color: AppTheme.colors.foscherblue,
  //   fontSize: 3.5 * SizeConfig.textMultiplier,
  // );

  // static final TextStyle appsubTitles = TextStyle(
  //   color: AppTheme.colors.foscherblue,
  //   fontSize: 2 * SizeConfig.textMultiplier,
  //   height: 1.5,
  // );

  // static final TextStyle appbuttons = TextStyle(
  //   color: Colors.black,
  //   fontSize: 2.5 * SizeConfig.textMultiplier,
  // );

  // static final TextStyle _greetingLight = TextStyle(
  //   color: Colors.black,
  //   fontSize: 2.0 * SizeConfig.textMultiplier,
  // );

  // static final TextStyle _searchLight = TextStyle(
  //   color: Colors.black,
  //   fontSize: 2.3 * SizeConfig.textMultiplier,
  // );

  // static final TextStyle _selectedTabLight = TextStyle(
  //   color: Colors.black,
  //   fontWeight: FontWeight.bold,
  //   fontSize: 2 * SizeConfig.textMultiplier,
  // );

  // static final TextStyle _unSelectedTabLight = TextStyle(
  //   color: Colors.grey,
  //   fontSize: 2 * SizeConfig.textMultiplier,
  // );
}
