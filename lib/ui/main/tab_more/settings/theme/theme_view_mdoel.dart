import 'package:flutter/material.dart';
import 'package:studiffy/core/base/base_view_model.dart';
import 'package:studiffy/utils/app/preferences/theme_preferences.dart';

class ThemeViewModel extends BaseViewModel {
  ThemeMode themeMode;

  ThemeViewModel(super.context, this.themeMode);

  void setTheme(ThemeMode? mode) async {
    if (mode != null) {
      themeMode = mode;
      await ThemePreference.shared.save(mode);
      notifyListeners();
    }
  }
}
