import 'package:studiffy/core/base/base_prefernces.dart';
import 'package:studiffy/core/constant/constant.dart';

class RefreshTokenPreference extends BasePreference<String> {
  // SINGLETON ----------------------------------------------------------------

  static final RefreshTokenPreference _instance = RefreshTokenPreference._();

  static RefreshTokenPreference get shared => _instance;

  RefreshTokenPreference._();

  // END SINGLETON ------------------------------------------------------------

  @override
  String get key => refreshTokenPreferenceKey;
}
