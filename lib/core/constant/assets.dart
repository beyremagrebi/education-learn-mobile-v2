import 'package:flutter/material.dart';

class Assets {
  static const _imageDir = 'assets/images';
  static const _iconsDir = 'assets/icons';

  static const _backgroundsDir = '$_imageDir/backgrounds';
  static const _logoDir = '$_imageDir/logo';

  static const bgMain = '$_backgroundsDir/bg-main.svg';

  static const logoStudiffyLight = '$_logoDir/logo-light.png';
  static const logoStudiffyDark = '$_logoDir/logo-dark.png';
  static const logoPstcLight = '$_logoDir/pstc-light-logo.png';
  static const logoPstcDark = '$_logoDir/pstc-dark-logo.png';

  static String logoPstc(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? logoPstcLight : logoPstcDark;
  }

  static String logoStuddify(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark ? logoStudiffyDark : logoStudiffyLight;
  }

  static const _menuTabImages = '$_imageDir/menu_tab';
  static const menuBgPink = '$_menuTabImages/pink.png';
  static const menuBgPurple = '$_menuTabImages/purple.png';
  static const menuBgRose = '$_menuTabImages/rose.png';
  static const menuBgBlue = '$_menuTabImages/blue.png';
  static const menuBgTurquoise = '$_menuTabImages/turquoise.png';
  static const menuBgBlueAlt = '$_menuTabImages/blue_alt.png';

  static const _flagsDir = '$_imageDir/flags';
  static const tunisiaFlag = '$_flagsDir/tn.png';
  static const franceFlag = '$_flagsDir/fr.png';
  static const ukFlag = '$_flagsDir/gb.png';

  static const _facilitySelectionDir = '$_iconsDir/facility_selection';
  static const studentIcon = '$_facilitySelectionDir/student-icon.png';
  static const typeFaculty = '$_facilitySelectionDir/type-faculty.png';
  static const typeTc = '$_facilitySelectionDir/type-tc.png';

  static const defaultMaleAvatar = '$_imageDir/male.png';
  static const defaultFemaleAvatar = '$_imageDir/female.png';
}
