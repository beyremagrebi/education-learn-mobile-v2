import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

late AppLocalizations intl;

class Localization {
  static const localeArabic = Locale('ar', '');
  static const localeEnglish = Locale('en', '');
  static const localeFrench = Locale('fr', '');

  static const supportedLocales = [localeArabic, localeEnglish, localeFrench];
}
