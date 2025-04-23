import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:studiffy/utils/app/session/session_manager.dart';

String baseUrl = dotenv.get("BASE_URL");
String fileUrl =
    '$baseUrl/enterprise-${SessionManager.user.enterprise}/storage';

final bool enableScreenShot =
    dotenv.getBool('ENABLE_SCREENSHOTS', fallback: false);
