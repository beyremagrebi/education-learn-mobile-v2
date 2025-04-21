import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension LocalizedStrings on AppLocalizations {
  String get(String key) {
    switch (key) {
      case 'scheduleMenu':
        return scheduleMenu;
      case 'settingsMenu':
        return settingsMenu;
      case 'classMenu':
        return classMenu;
      default:
        return key;
    }
  }
}
