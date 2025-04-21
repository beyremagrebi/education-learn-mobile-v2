import 'package:shared_preferences/shared_preferences.dart';

class LocalizationPreference {
  static LocalizationPreference? _instance;

  LocalizationPreference._();

  static LocalizationPreference get instance =>
      _instance ??= LocalizationPreference._();

  static const savedLocalization = 'SAVED_LOCALIZATION';

  dynamic setLocalization(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(savedLocalization, value);
  }

  Future<String?> getLocalization() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(savedLocalization);
  }
}
