import 'package:flutter/material.dart';
import 'package:studiffy/ui/auth/login/login_view.dart';
import 'package:studiffy/utils/app/session/session_manager.dart';
import 'package:studiffy/utils/app/session/token_manager.dart';
import 'package:studiffy/utils/navigator_utils.dart';

import '../core/base/base_view_model.dart';

class SplashScreenViewModel extends BaseViewModel {
  bool hasError = false;
  bool animationCompleted = false;

  SplashScreenViewModel(super.context);

  Future<void> initialize() async {
    try {
      await _getAppSettings();
    } catch (e) {
      hasError = true;
      update();
    }
  }

  void retry() {
    hasError = false;
    update();
    initialize();
  }

  void cancel() {
    hasError = true;
    update();
  }

  void onAnimationComplete() async {
    animationCompleted = true;
    if (!hasError) {
      try {
        await initialize();
      } catch (err) {
        hasError = true;
        update();
      }
    }
  }

  Future<void> _getAppSettings() async {
    try {
      _proceed();
    } catch (e, stackTrace) {
      debugPrint('Error in _getAppSettings: $e');
      debugPrint(stackTrace.toString());
    }
  }

  Future<void> _proceed() async {
    await TokenManager.initialize();
    await SessionManager.initialize().whenComplete(
      () {
        if (SessionManager.checkUserExist()) {
          navigateToMainScreen(context, SessionManager.user);
        } else {
          navigateToDeleteTree(context, const LoginView());
        }
      },
    );
  }
}
