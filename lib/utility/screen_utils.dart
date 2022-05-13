import 'package:flutter/material.dart';

class ScreenUtils {
  MediaQueryData query;

  ScreenUtils(this.query);

  /// Returns the width of the screen based on the [percentage] passed
  double wp(percentage) {
    double result = (percentage * query.size.width) / 100;
    return result;
  }

  /// Returns the height of the screen based on the [percentage] passed
  double hp(percentage) {
    double result = (percentage * query.size.height) / 100;
    return result;
  }

  bool isDeviceTablet() {
    var shortestSide = query.size.shortestSide;
//  600 here is a common breakpoint for a typical 7-inch tablet.
    return shortestSide > 600;
  }
}
