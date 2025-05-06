import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:studiffy/utils/app/session/session_manager.dart';

String baseUrl = kDebugMode ? dotenv.get('LOCAL_URL') : dotenv.get('PROD_URL');
String fileUrl =
    '$baseUrl/enterprise-${SessionManager.user.enterprise}/storage';
String videofileUrl =
    '$baseUrl/desktop-app/video/${SessionManager.user.enterprise}';

final bool enableScreenShot =
    dotenv.getBool('ENABLE_SCREENSHOTS', fallback: false);
