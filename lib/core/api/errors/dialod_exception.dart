import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/scheduler.dart';

import '../../../utils/alert_utils.dart';

class DialogException implements Exception {
  final String message;

  DialogException(this.message) {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await AlertUtils.show(
        title: 'Error', // You can use your localization here
        description: message,
        dialogType: DialogType.error,
      );
    });
  }

  @override
  String toString() => message;
}
