import 'package:flutter/material.dart';
import 'package:studiffy/core/base/base_view_model.dart';

import '../../../../../utils/app/preferences/localization_preferences.dart';

class LanguageViewModel extends BaseViewModel {
  Locale? locale;

  LanguageViewModel(super.context) {
    loadLocale().onError(
      (error, stackTrace) {
        locale = const Locale('fr');
        update();
      },
    );
  }

  Future<void> loadLocale() async {
    locale = Locale(
      await LocalizationPreference.instance.getLocalization() ?? 'fr',
    );
    update();
  }

  Future<void> setLocale(Locale newLocale) async {
    locale = newLocale;
    await LocalizationPreference.instance.setLocalization(
      newLocale.languageCode,
    );
    update();
  }

  Future<void> toggleLanguage() async {
    switch (locale!.languageCode) {
      case 'fr':
        await setLocale(const Locale('en'));
        break;
      case 'en':
        await setLocale(const Locale('ar'));
        break;
      default:
        await setLocale(const Locale('fr'));
        break;
    }
    update();
  }
}
