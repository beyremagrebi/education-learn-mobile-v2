import 'package:flutter/material.dart';
import 'package:no_screenshot/no_screenshot.dart';

class AppUtils {
  static final _noScreenshot = NoScreenshot.instance;
  static Future<void> executePreLaunch() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      await _disableScreenshot();
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  static Future<void> _disableScreenshot() async {
    bool result = await _noScreenshot.screenshotOn();
    debugPrint('Screenshot Off: $result');
  }
}
