import 'package:flutter/cupertino.dart';
import 'package:studiffy/core/localization/flutter_localization.dart';

class Dimensions {
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;
  static final dpr = MediaQuery.of(mainContext).devicePixelRatio;

  /// Small size
  static const double s = 5;

  /// Medium size
  static const double m = 10;

  /// Large size
  static const double l = 15;

  /// Extra large size
  static const double xl = 20;

  /// Extra extra large size
  static const double xxl = 25;

  /// Huge size
  static const double xxxl = 35;

  static const double respectPaddingBottom = 50;

  // ------------------------------- Height --------------------------------- //

  // Top bar height
  static int get appBarHeight => 56;

  // Top bar height
  static SizedBox topBarHeight(BuildContext context) => SizedBox(
        height: MediaQuery.of(context).padding.top,
      );

  // Bottom bar height
  static SizedBox bottomBarHeight(BuildContext context) => SizedBox(
        height: MediaQuery.of(context).padding.bottom + 70,
      );

  /// SizedBox with height of 5
  static const heightSmall = SizedBox(height: s);

  /// SizedBox with height of 10
  static const heightMedium = SizedBox(height: m);

  /// SizedBox with height of 15
  static const heightLarge = SizedBox(height: l);

  /// SizedBox with height of 20
  static const heightExtraLarge = SizedBox(height: xl);

  /// SizedBox with height of 30
  static const heightXXL = SizedBox(height: xxl);

  /// SizedBox with height of 35
  static const heightHuge = SizedBox(height: xxxl);

  // ------------------------------- Width ---------------------------------- //

  /// SizedBox with width of 5
  static const widthSmall = SizedBox(width: s);

  /// SizedBox with width of 10
  static const widthMedium = SizedBox(width: m);

  /// SizedBox with width of 15
  static const widthLarge = SizedBox(width: l);

  /// SizedBox with width of 20
  static const widthExtraLarge = SizedBox(width: xl);

  /// SizedBox with width of 30
  static const widthXXL = SizedBox(width: xxl);

  /// SizedBox with width of 35
  static const widthHuge = SizedBox(width: xxxl);

  // ------------------------------- Padding -------------------------------- //

  /// EdgeInsets.all(5)
  static const paddingSmall = EdgeInsets.all(s);

  /// EdgeInsets.all(10)
  static const paddingMedium = EdgeInsets.all(m);

  /// EdgeInsets.all(15)
  static const paddingLarge = EdgeInsets.all(l);

  /// EdgeInsets.all(20)
  static const paddingExtraLarge = EdgeInsets.all(xl);

  /// EdgeInsets.all(35)
  static const paddingHuge = EdgeInsets.all(xxxl);

  static const paddingSmallHorizontal = EdgeInsets.symmetric(
    horizontal: s,
  );
  static const paddingMediumHorizontal = EdgeInsets.symmetric(
    horizontal: m,
  );
  static const paddingLargeHorizontal = EdgeInsets.symmetric(
    horizontal: l,
  );
  static const paddingExtraLargeHorizontal = EdgeInsets.symmetric(
    horizontal: xl,
  );
  static const paddingHugeHorizontal = EdgeInsets.symmetric(
    horizontal: xxxl,
  );

  static const paddingSmallVertical = EdgeInsets.symmetric(
    vertical: s,
  );
  static const paddingMediumVertical = EdgeInsets.symmetric(
    vertical: m,
  );
  static const paddingLargeVertical = EdgeInsets.symmetric(
    vertical: l,
  );
  static const paddingExtraLargeVertical = EdgeInsets.symmetric(
    vertical: xl,
  );
  static const paddingHugeVertical = EdgeInsets.symmetric(
    vertical: xxxl,
  );

  static const smallRadius = Radius.circular(s);
  static const mediumRadius = Radius.circular(m);
  static const largeRadius = Radius.circular(l);
  static const extraLargeRadius = Radius.circular(xl);
  static const xxlRadius = Radius.circular(xxl);
  static const hugeRadius = Radius.circular(xxxl);

  static const BorderRadius smallBorderRadius = BorderRadius.all(
    smallRadius,
  );
  static const BorderRadius mediumBorderRadius = BorderRadius.all(
    mediumRadius,
  );
  static const BorderRadius largeBorderRadius = BorderRadius.all(
    largeRadius,
  );
  static const BorderRadius extraLargeBorderRadius = BorderRadius.all(
    extraLargeRadius,
  );
  static const BorderRadius xxlBorderRadius = BorderRadius.all(
    xxlRadius,
  );
  static const BorderRadius hugeBorderRadius = BorderRadius.all(
    hugeRadius,
  );

  static const smallRoundedShape = RoundedRectangleBorder(
    borderRadius: smallBorderRadius,
  );
  static const mediumRoundedShape = RoundedRectangleBorder(
    borderRadius: mediumBorderRadius,
  );
  static const largeRoundedShape = RoundedRectangleBorder(
    borderRadius: largeBorderRadius,
  );
  static const extraLargeRoundedShape = RoundedRectangleBorder(
    borderRadius: extraLargeBorderRadius,
  );
  static const hugeRoundedShape = RoundedRectangleBorder(
    borderRadius: hugeBorderRadius,
  );

  static const iconSizeSmall = 20.0;
  static const iconSizeMedium = 25.0;
  static const iconSizeLarge = 40.0;
  static const iconSizeExtraLarge = 70.0;
  static const iconSizeHuge = 100.0;
}
