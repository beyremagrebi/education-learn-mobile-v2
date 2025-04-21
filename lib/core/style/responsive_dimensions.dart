import 'package:flutter/cupertino.dart';

class ResponsiveDimensions {
  static late double screenWidth;
  static late double screenHeight;

  static double horizontalS = screenWidth / 170;
  static double horizontalM = screenWidth / 85;
  static double horizontalL = screenWidth / 55;
  static double horizontalXL = screenWidth / 40;
  static double horizontalXXL = screenWidth / 30;
  static double horizontalXXXL = screenWidth / 25;

  static double verticalS = screenWidth / 80;
  static double verticalM = screenWidth / 40;
  static double verticalL = screenWidth / 25;
  static double verticalXL = screenWidth / 20;
  static double verticalXXL = screenWidth / 15;
  static double verticalXXXL = screenWidth / 10;

  // ------------------------------- Height --------------------------------- //

  // Top bar height
  static SizedBox topBarHeight(BuildContext context) => SizedBox(
        height: MediaQuery.of(context).padding.top,
      );

  // Bottom bar height
  static SizedBox bottomBarHeight(BuildContext context) => SizedBox(
        height: MediaQuery.of(context).padding.bottom + 70,
      );

  // Height
  static final heightS = SizedBox(height: verticalS);
  static final heightM = SizedBox(height: verticalM);
  static final heightL = SizedBox(height: verticalL);
  static final heightXL = SizedBox(height: verticalXL);
  static final heightXXL = SizedBox(height: verticalXXL);
  static final heightXXXL = SizedBox(height: verticalXXXL);

  // Width
  static final widthS = SizedBox(width: horizontalS);
  static final widthM = SizedBox(width: horizontalM);
  static final widthL = SizedBox(width: horizontalL);
  static final widthXL = SizedBox(width: horizontalXL);
  static final widthXXL = SizedBox(width: horizontalXXL);
  static final widthXXXL = SizedBox(width: horizontalXXXL);
}
