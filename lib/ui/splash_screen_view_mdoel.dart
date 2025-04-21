import 'package:flutter/material.dart';
import 'package:studiffy/ui/auth/login/login_view.dart';
import 'package:studiffy/utils/navigator_utils.dart';

import '../core/base/base_view_model.dart';

class SplashScreenViewModel extends BaseViewModel {
  bool hasError = false;
  bool animationCompleted = false;

  SplashScreenViewModel(super.context) {
    initialize();
  }

  Future<void> initialize() async {
    try {} catch (e) {
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
        await _getAppSettings();
      } catch (err) {
        hasError = true;
        update();
      }
    }
  }

  Future<void> _getAppSettings() async {
    try {
      navigateToDeleteTree(context, const LoginView());
    } catch (e, stackTrace) {
      debugPrint('Error in _getAppSettings: $e');
      debugPrint(stackTrace.toString());
    }
  }
}
