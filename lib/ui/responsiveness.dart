import 'package:flutter/material.dart';

class Responsiveness {
  static late BuildContext context;
  static late double width;
  static late double height;
  static init(BuildContext rContext, double rWidth, double rHeight) {
    context = rContext;
    width = rWidth;
    height = rHeight;
  }
}

bool isSmallScreen() {
  return Responsiveness.width < 600;
}

bool isMediumScreen() {
  return Responsiveness.width >= 600 && Responsiveness.width < 840;
}

bool isLargeScreen() {
  return Responsiveness.width >= 840;
}

bool isExtraLargeScreen() {
  return Responsiveness.width >= 1200;
}

double getResponsiveWidth(double width) {
  return (Responsiveness.width * width) / 390;
}

double getResponsiveHeight(double height) {
  return (Responsiveness.height * height) / 844;
}
