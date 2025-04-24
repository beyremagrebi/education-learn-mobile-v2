import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:path_provider/path_provider.dart';
import 'package:studiffy/core/api/services/global/auth_service.dart';
import 'package:studiffy/core/localization/loalisation.dart';
import 'package:studiffy/models/global/login_info.dart';
import 'package:studiffy/models/global/user/user.dart';
import 'package:studiffy/utils/alert_utils.dart';
import 'package:studiffy/utils/app/session/sessions_manager/session_facility_manager.dart';
import 'package:studiffy/utils/app/session/sessions_manager/session_user_manager.dart';
import 'package:studiffy/utils/app/session/token_manager.dart';

import '../../../models/global/facility.dart';

class SessionManager {
  static User get user => SessionUserManager.user;
  static Facility get facility => SessionFacilityManager.facility;
  static void login(LoginInfo? loginInfo) {
    SessionUserManager.login(loginInfo);
  }

  // Initializes user and facility
  static Future<void> initialize() async {
    await SessionUserManager.initializeUser();
    await SessionFacilityManager.initializeFacility();
  }

  static bool checkUserExist() {
    return SessionUserManager.checkUserExist();
  }

  static Future<void> reset({bool resetSwappableAccounts = true}) async {
    await SessionUserManager.resetUser();
    await SessionFacilityManager.resetFacility();
    await clearHiveCache();
    await TokenManager.reset();
  }

  static Future<void> logout({String? errorAlertText}) async {
    await AuthService.shared.logout();
    await reset();
    await SessionUserManager.logout(errorAlertText: errorAlertText);
  }

  static Future<void> saveUser(User user) async {
    await SessionUserManager.saveUser(user);
  }

  static Future<void> clearHiveCache() async {
    final dir = await getTemporaryDirectory();
    final cacheStore = HiveCacheStore(dir.path);
    await cacheStore.clean();
    try {
      await cacheStore.close();
    } catch (e) {
      AlertUtils.show(
          title: intl.genericError,
          description: '$e',
          dialogType: DialogType.error);
    }
  }
}
