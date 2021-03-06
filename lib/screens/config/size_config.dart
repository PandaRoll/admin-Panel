import 'dart:math';

import 'package:flutter/widgets.dart';

class SizeConfig {
  static double _screenWidth = 0;
  static double _screenHeight = 0;
  static double _blockWidth = 0;
  static double _blockHeight = 0;
  static double screenwidth = 0;
  static double screenheight = 0;
  static double textMultiplier = 0;
  static double vw = 0;
  static double vh = 0;
  static double vmin = 0;
  static double vmax = 0;

  static double imageSizeMultiplier = 0;
  static double heightMultiplier = 0;
  static double widthMultiplier = 0;
  static bool isPortrait = true;
  static bool isMobilePortrait = false;

  void init(BoxConstraints constraints, Orientation orientation) {
    if (orientation == Orientation.portrait) {
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
      isPortrait = true;
    } else {
      _screenHeight = constraints.maxWidth;
      _screenWidth = constraints.maxHeight;
      isPortrait = false;
      isMobilePortrait = false;
    }

    _blockWidth = _screenWidth / 100;
    _blockHeight = _screenHeight / 100;
    screenwidth = _screenWidth;
    screenheight = _screenHeight;
    vw = _blockWidth;
    vh = _blockHeight;
    vmin = [
      _blockWidth,
      _blockHeight,
    ].reduce(min);
    vmax = [
      _blockWidth,
      _blockHeight,
    ].reduce(max);
    imageSizeMultiplier = _blockWidth;
    heightMultiplier = _blockHeight;
    widthMultiplier = _blockWidth;
  }
}
