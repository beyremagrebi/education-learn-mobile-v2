import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:provider/provider.dart';
import 'package:studiffy/core/api/errors/dialod_exception.dart';
import 'package:studiffy/core/api/services/global/user_service.dart';
import 'package:studiffy/core/localization/flutter_localization.dart';
import 'package:studiffy/core/localization/loalisation.dart';
import 'package:studiffy/models/global/user/user.dart';
import 'package:studiffy/models/global/user/user_role.dart';
import 'package:studiffy/ui/splash_screen_view.dart';
import 'package:studiffy/utils/alert_utils.dart';
import 'package:studiffy/utils/app/session/sessions_manager/session_role_manager.dart';
import 'package:studiffy/utils/app/session/token_manager.dart';
import 'package:studiffy/utils/app/session/user_session/payment_preference.dart';
import 'package:studiffy/utils/app/session/user_session/user_preference.dart';
import 'package:studiffy/utils/navigator_utils.dart';
import 'package:studiffy/utils/widgets/loading/loading_screen_view.dart';

import '../../../../models/global/login_info.dart';
import '../../../view_models/profile_view_model.dart';
import 'session_facility_manager.dart';

class SessionUserManager {
  static User? _user;

  static User get user =>
      _user != null ? _user! : throw DialogException(intl.sessionUserNull);

  static late bool isUnpaid;

  static Future<void> initializeUser() async {
    final userId = await UserPreference.shared.load();
    final bool? isUnpaidStorage = await PaymentPreference.shared.load();
    if (isUnpaidStorage != null && isUnpaidStorage == true) {
      isUnpaid = false;
    }

    if (userId != null) {
      final jsonResponse = await UserService.shared.getById(userId);
      if (jsonResponse.status) {
        _user = jsonResponse.resolveSingle(User.fromMap);
      } else {
        throw DialogException(intl.userNotFound(userId));
      }
    }

    if (_user != null && mainContext.mounted) {
      mainContext.read<ProfileViewModel>().updateUser(_user!);
    }
  }

  static Future<void> login(LoginInfo? loginInfo) async {
    if (loginInfo?.accessToken != null && loginInfo?.refreshToken != null) {
      final userId = await TokenManager.saveTokenAndGetUserId(
        loginInfo!.accessToken!,
        loginInfo.refreshToken!,
      );
      final userJson = await UserService.shared.getById(userId);
      if (userJson.data != null) {
        final user = User.fromMap(userJson.data);
        await saveUser(user);

        if (mainContext.mounted) {
          navigateToMainScreen(mainContext, user);
        }
      }
    }
  }

  static Future<void> saveUser(User user) async {
    final success = await UserPreference.shared.save(user.id!);
    if (success) {
      _user = user;
    } else {
      throw DialogException(intl.userCouldNotBeSaved);
    }

    if (_user?.facility?.id != null) {
      await SessionFacilityManager.saveFacility(user.facility?.id);
      await handleUserRole(user);
    }

    if (mainContext.mounted) {
      mainContext.read<ProfileViewModel>().updateUser(user);
    }
  }

  static Future<void> handleUserRole(User user) async {
    switch (user.role) {
      case UserRole.student:
        await handleStudent(user);
        break;
      default:
        break;
    }
  }

  static Future<void> handleStudent(User user) async {
    final classValue = await SessionRoleManager.handleStudent(user);
    _user?.classe = classValue;
  }

  static bool checkUserExist() {
    return _user != null;
  }

  static Future<void> resetUser({bool resetSwappableAccounts = true}) async {
    _user = null;
    await UserPreference.shared.reset();
  }

  static Future<void> logout({String? errorAlertText}) async {
    if (mainContext.mounted) {
      navigateToDeleteTree(mainContext, const LoadingScreenView());
    }

    await Future.delayed(const Duration(milliseconds: 500));

    globalProvidersState.reset();

    if (mainContext.mounted) {
      if (errorAlertText != null) {
        AlertUtils.showSingleAction(
          title: intl.genericError,
          description: errorAlertText,
          dialogType: DialogType.error,
          action: () => navigateToDeleteTree(
            mainContext,
            const SplashScreenView(),
          ),
        );
      } else {
        navigateToDeleteTree(mainContext, const SplashScreenView());
      }

      mainContext.read<ProfileViewModel>().clearUser();
    }
  }

  static T valueByRole<T>({
    required T companyAdmin,
    required T superAdmin,
    required T collaborator,
    required T instructor,
    required T student,
    required T responsible,
  }) {
    switch (user.role) {
      case UserRole.companyAdmin:
        return companyAdmin;
      case UserRole.student:
        return student;
      case UserRole.collaborator:
        return collaborator;
      case UserRole.instructor:
        return instructor;
      case UserRole.responsible:
      case UserRole.superAdmin:
        return superAdmin;
      default:
        throw DialogException(
          "Role '${_user?.role?.name}' not implemented yet.",
        );
    }
  }

  static T functionByRole<T>({
    required T Function() companyAdmin,
    required T Function() superAdmin,
    required T Function() collaborator,
    required T Function() instructor,
    required T Function() student,
    required T Function() responsible,
  }) {
    switch (_user?.role) {
      case UserRole.companyAdmin:
        return companyAdmin.call();
      case UserRole.student:
        return student.call();
      case UserRole.collaborator:
        return collaborator.call();
      case UserRole.instructor:
        return instructor.call();
      case UserRole.responsible:
      case UserRole.superAdmin:
        return superAdmin.call();
      default:
        throw DialogException(
          "Action for '${_user?.role?.name}' not implemented yet.",
        );
    }
  }
}
