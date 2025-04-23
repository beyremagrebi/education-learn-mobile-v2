import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:studiffy/core/api/services/global/auth_service.dart';
import 'package:studiffy/core/base/base_view_model.dart';
import 'package:studiffy/core/localization/loalisation.dart';
import 'package:studiffy/models/global/login_info.dart';
import 'package:studiffy/utils/app/session/session_manager.dart';

import '../../../core/localization/flutter_localization.dart';
import '../../../utils/alert_utils.dart';

class LoginViewMdoel extends BaseViewModel {
  LoginViewMdoel(super.context);

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool hidePassword = true;
  bool? isFirstLogin;
  bool? userExist;
  String? messageError;
  bool? rememberMe = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void changeRemmeber(bool? value) {
    rememberMe = value;
    update();
  }

  Future<bool> inputControl() async {
    if (emailController.text.trim().isEmpty) {
      await AlertUtils.show(
        title: intl.genericError,
        description: intl.pleaseEnterYourEmail,
        dialogType: DialogType.error,
      );
      return false;
    }

    if (passwordController.text.trim().isEmpty) {
      await AlertUtils.show(
        title: intl.genericError,
        description: intl.pleaseEnterYourPassword,
        dialogType: DialogType.error,
      );
      return false;
    }

    return true;
  }

  Future<void> signIn() async {
    try {
      await makeApiCall(
        fromMapFunction: LoginInfo.fromMap,
        apiCall: AuthService.shared.login(
          email: emailController.text.trim(),
          password: passwordController.text,
        ),
        onSuccess: (loginIno) {
          SessionManager.login(loginIno);
        },
      );
    } catch (err) {
      AlertUtils.show(
        title: intl.genericError,
        description: intl.genericError,
        dialogType: DialogType.error,
      );
    }
  }

  void togglePasswordVisibility() {
    hidePassword = !hidePassword;
    update();
  }

  Future<void> checkIsFirstLogin() async {
    FocusScope.of(mainContext).unfocus();

    if (emailController.text.trim().isEmpty) {
      await AlertUtils.show(
        title: intl.genericError,
        description: intl.pleaseEnterYourEmail,
        dialogType: DialogType.error,
      );
      return;
    }

    await makeApiCall(
      fromMapFunction: LoginInfo.fromMap,
      apiCall: AuthService.shared.checkIsFirstLogin(
        email: emailController.text.trim(),
      ),
      onSuccess: (loginInfo) {
        if (loginInfo?.userExist != null && loginInfo?.hasPassword != null) {
          if (loginInfo?.userExist == false) {
            messageError = intl.emailInvalid;
          }
          userExist = loginInfo?.userExist;
          update();
        } else {
          AlertUtils.show(
            title: intl.genericError,
            description: intl.invalidUserDetails,
            dialogType: DialogType.error,
          );
        }
      },
      onError: (message) {
        messageError = message;
        update();
      },
    );
  }
}
