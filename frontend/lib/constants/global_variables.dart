import 'package:flutter/material.dart';

class GlobalVariables {
  // Base Variables
  static double screenWidth = 0;
  static double screenHeight = 0;

  //Define Colors
  //Color black and white has been defined
  static const Color defaultColor = Color(0xFFFAFAFA);
  static const Color darkGrey = Color(0xFF808089);
  static const Color lightGrey = Color(0xFFF2F4F5);
  static const Color darkGreen = Color(0xFF198155);
  static const Color green = Color(0xFF23C16B);
  static const Color lightGreen = Color(0xFFDAEFDE);
  static const Color skinColor = Color(0xFFFCD9BB);
  static const Color darkRed = Color(0xFFBF1D28);
  static const Color lightRed = Color(0xFFFFDBDE);
  static const Color darkYellow = Color(0xFFCC8100);
  static const Color yellow = Color(0xFFFFC400);
  static const Color lightYellow = Color(0xFFFFF5C7);
  static const Color darkBlue = Color(0xFF0D5BB5);
  static const Color lightBlue = Color(0xFFDBEEFF);

  //Define Scales
  static void init(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;
  }

  //Define Font Sizes
  static const double fontSize_16 = 16;
  static const double fontSize_24 = 24;
  static const double fontSize_32 = 32;
  static const double fontSize_36 = 36;
  static const double fontSize_48 = 48;

  // Images
  static const String welcomeImage_01 = "assets/images/Welcome_01.png";
  static const String welcomeImage_02 = "assets/images/Welcome_02.png";
  static const String welcomeImage_03 = "assets/images/Welcome_03.png";
}
