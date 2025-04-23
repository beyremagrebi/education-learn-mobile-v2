import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:studiffy/core/style/themes/app_theme.dart';

import '../core/localization/flutter_localization.dart';
import '../core/style/themes/app_colors.dart';

class AlertUtils {
  static BuildContext getMainContext() => mainContext;

  static Future<void> show({
    BuildContext? context,
    required String title,
    required String description,
    required DialogType dialogType,
  }) async {
    AwesomeDialog(
      context: context ?? getMainContext(),
      dialogType: dialogType,
      animType: AnimType.scale,
      title: title,
      desc: description,
      barrierColor: AppTheme.islight ? barrierColorLight : barrierColorDark,
      btnOkOnPress: () {},
      btnOkColor: _getColor(dialogType),
    ).show();
  }

  static Future<void> showSingleAction({
    BuildContext? context,
    required String title,
    required String description,
    required DialogType dialogType,
    required VoidCallback? action,
  }) async {
    AwesomeDialog(
      context: context ?? getMainContext(),
      dialogType: dialogType,
      animType: AnimType.scale,
      title: title,
      desc: description,
      btnOkOnPress: () {
        if (action != null) action();
      },
      btnOkColor: _getColor(dialogType),
    ).show();
  }

  static Color _getColor(DialogType dialogType) {
    switch (dialogType) {
      case DialogType.success:
        return successColor;
      case DialogType.info:
      case DialogType.infoReverse:
      case DialogType.question:
        return informationColor;
      case DialogType.warning:
        return warningColor;
      case DialogType.error:
        return dangerColor;
      case DialogType.noHeader:
        return Colors.grey;
    }
  }
}
