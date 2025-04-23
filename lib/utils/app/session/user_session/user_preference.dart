import 'package:studiffy/core/base/base_prefernces.dart';
import 'package:studiffy/core/constant/constant.dart';

class UserPreference extends BasePreference<String> {
  // SINGLETON ----------------------------------------------------------------

  static final UserPreference _instance = UserPreference._();

  static UserPreference get shared => _instance;

  UserPreference._();

  // END SINGLETON ------------------------------------------------------------

  @override
  String get key => userSessionPreferenceKey;
}
