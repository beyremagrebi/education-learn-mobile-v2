import 'package:studiffy/core/api/services/global/auth_service.dart';
import 'package:studiffy/models/global/login_info.dart';
import 'package:studiffy/models/global/user/user.dart';
import 'package:studiffy/utils/app/session/sessions_manager/session_user_manager.dart';
import 'package:studiffy/utils/app/session/token_manager.dart';

class SessionManager {
  static User get user => SessionUserManager.user;
  static void login(LoginInfo? loginInfo) {
    SessionUserManager.login(loginInfo);
  }

  // Initializes user and facility
  static Future<void> initialize() async {
    await SessionUserManager.initializeUser();
  }

  static bool checkUserExist() {
    return SessionUserManager.checkUserExist();
  }

  static Future<void> reset({bool resetSwappableAccounts = true}) async {
    await SessionUserManager.resetUser();

    await TokenManager.reset();
  }

  static Future<void> logout({String? errorAlertText}) async {
    await AuthService.shared.logout();
    await SessionUserManager.logout(errorAlertText: errorAlertText);
    await reset();
  }

  static Future<void> saveUser(User user) async {
    await SessionUserManager.saveUser(user);
  }
}
