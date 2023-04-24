import 'package:flutter/material.dart';

class ScreenUtils {
  //base on iphone 7
  static double idealScreenWidth = 375.0;
  static double idealScreenHeight = 667.0;
  static double idealRatio = (idealScreenHeight / idealScreenWidth);

  static Size _screenSize = const Size(0, 0);
  static Size screenSize = _screenSize;
  static void setScreenSize(Size value) {
    _screenSize = value;
    _screenHeight = value.height;
    _screenWidth = value.width;
  }

  static double ratio = (_screenHeight / _screenWidth);
  static double scaleValue(double value) {
    return (ratio / idealRatio) * value;
  }

  static final double _heightRatio = (_screenHeight / idealScreenHeight);
  static double _screenHeight = 0;
  static double get screenHeight => _screenHeight;
  static double scaleValueH(double value) {
    return _heightRatio * value;
  }

  static double scaleValueDownH(double value) {
    return value / _heightRatio;
  }

  static final double _widthRatio = (_screenWidth / idealScreenWidth);
  static double _screenWidth = 0;
  static double get screenWidth => _screenWidth;
  static double scaleValueW(double value) {
    return _widthRatio * value;
  }
}
