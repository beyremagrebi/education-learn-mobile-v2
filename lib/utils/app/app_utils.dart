import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:no_screenshot/no_screenshot.dart';
import 'package:studiffy/core/config/env.dart';

class AppUtils {
  static final _noScreenshot = NoScreenshot.instance;
  static Future<void> executePreLaunch() async {
    try {
      WidgetsFlutterBinding.ensureInitialized();
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      debugInvertOversizedImages = true;
      await dotenv.load(fileName: ".env");
      await _disableScreenshot();
    } catch (err) {
      debugPrint(err.toString());
    }
  }

  static Future<void> _disableScreenshot() async {
    try {
      if (enableScreenShot) {
        await _noScreenshot.screenshotOn();
      } else {
        await _noScreenshot.screenshotOff();
      }
      debugPrint('ENABLE SCREEN SHOT => $enableScreenShot');
    } catch (e) {
      debugPrint('Error in _disableScreenshot: $e');
    }
  }
}
