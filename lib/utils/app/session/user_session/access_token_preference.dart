import 'package:studiffy/core/base/base_prefernces.dart';
import 'package:studiffy/core/constant/constant.dart';

class AccessTokenPreference extends BasePreference<String> {
  // SINGLETON ----------------------------------------------------------------

  static final AccessTokenPreference _instance = AccessTokenPreference._();

  static AccessTokenPreference get shared => _instance;

  AccessTokenPreference._();

  // END SINGLETON ------------------------------------------------------------

  @override
  String get key => accessTokenPreferenceKey;
}
