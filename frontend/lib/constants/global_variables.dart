import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

String uri = 'http://192.168.2.115:3000';

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
  static const Color pureWhite = Color(0xFFFFFFFF);
  static const Color pinputColor = Color(0xFF545454);
  static const Color black = Color(0xFF000000);
  static const Color blackTextColor = Color(0xFF27272A);

  static int productId = -1;
  static String productName = '';
  static String productURL = '';
  static double productPrice = 0;
  static String paymentMethod = '';

  // Define Scales
  static void init(BuildContext context) async {
    // Sizes
    Size screenSize = MediaQuery.of(context).size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;
  }

  static double standardButtonWidth = screenWidth * (4 / 7);
  static double subStandardButtonWidth = screenWidth * (4 / 7) / 1.5;
  static double standardButtonHeight = screenHeight * (1 / 15);
  static double standardIconSize = 32;

  // Images
  static const String welcomeImage_01 = "assets/images/Welcome_01.png";
  static const String welcomeImage_02 = "assets/images/Welcome_02.png";
  static const String welcomeImage_03 = "assets/images/Welcome_03.png";

  //Define Font Sizes
  static const double fontSize_12 = 12;
  static const double fontSize_14 = 14;
  static const double fontSize_16 = 16;
  static const double fontSize_18 = 18;
  static const double fontSize_19 = 19;
  static const double fontSize_24 = 24;
  static const double fontSize_28 = 28;
  static const double fontSize_32 = 32;
  static const double fontSize_36 = 36;
  static const double fontSize_48 = 48;

  //Create list color for chart
  static const List<Color> chartColors = [
    Color(0xFF4CAF50),
    Color(0xFF2196F3),
    Color(0xFFFFC107),
    Color(0xFFFF5733),
    Color(0xFFC70039),
    Color(0xFF900C3F),
    Color(0xFF581845),
    Color(0xFFF44336),
    Color(0xFFE91E63),
    Color(0xFF9C27B0),
    Color(0xFF673AB7),
    Color(0xFF3F51B5),
    Color(0xFF00BCD4),
    Color(0xFF009688),
    Color(0xFF8BC34A),
    Color(0xFFCDDC39),
    Color(0xFFFFEB3B),
    Color(0xFFFF9800),
    Color(0xFFFF5722),
    Color(0xFF795548),
    Color(0xFF9E9E9E),
    Color(0xFF607D8B),
    Color(0xFFD32F2F),
    Color(0xFFC2185B),
    Color(0xFF7B1FA2),
    Color(0xFF512DA8),
    Color(0xFF303F9F),
    Color(0xFF1976D2),
    Color(0xFF0288D1),
    Color(0xFF0097A7),
    Color(0xFF00796B),
    Color(0xFF388E3C),
    Color(0xFF689F38),
    Color(0xFFAFB42B),
    Color(0xFFFBC02D),
    Color(0xFFFFA000),
    Color(0xFFF57C00),
    Color(0xFFE64A19),
    Color(0xFF5D4037),
    Color(0xFF616161),
    Color(0xFF455A64),
    Color(0xFFE53935),
    Color(0xFFD81B60),
    Color(0xFF8E24AA),
    Color(0xFF5E35B1),
    Color(0xFF3949AB),
    Color(0xFF1E88E5),
    Color(0xFF039BE5),
    Color(0xFF00ACC1),
    Color(0xFF00897B),
    Color(0xFF43A047),
    Color(0xFF7CB342),
    Color(0xFFC0CA33),
    Color(0xFFFDD835),
    Color(0xFFFFB300),
    Color(0xFFFB8C00),
    Color(0xFFF4511E),
    Color(0xFF6D4C41),
    Color(0xFF757575),
    Color(0xFF546E7A),
    Color(0xFFD32F2F),
    Color(0xFFC2185B),
    Color(0xFF7B1FA2),
    Color(0xFF512DA8),
    Color(0xFF303F9F),
    Color(0xFF1976D2),
    Color(0xFF0288D1),
    Color(0xFF0097A7),
    Color(0xFF00796B),
    Color(0xFF388E3C),
    Color(0xFF689F38),
    Color(0xFFAFB42B),
    Color(0xFFFBC02D),
    Color(0xFFFFA000),
    Color(0xFFF57C00),
    Color(0xFFE64A19),
    Color(0xFF5D4037),
    Color(0xFF616161),
    Color(0xFF455A64)
  ];

  //Custom container
  static Widget customContainer({Widget? child}) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12.0,
        left: 16.0,
        right: 16.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        child: Container(
          margin: const EdgeInsets.only(
            top: 12.0,
            left: 16.0,
            right: 16.0,
            bottom: 12,
          ),
          child: child,
        ),
      ),
    );
  }

  // Custom button
  static Widget customButton({
    VoidCallback? onTap,
    required String buttonText,
    required Color borderColor,
    required Color fillColor,
    required Color textColor,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: fillColor,
        border: Border.all(
          width: 1,
          color: borderColor,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Container(
              width: double.infinity,
              child: Text(
                buttonText,
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  color: textColor,
                  textStyle: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
