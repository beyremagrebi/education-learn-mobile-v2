import 'package:studiffy/utils/app/session/user_session/access_token_preference.dart';
import 'package:studiffy/utils/app/session/user_session/refresh_token_preference.dart';

class TokenStorage {
  static Future<void> saveTokens(
      String accessToken, String refreshToken) async {
    await AccessTokenPreference.shared.save(accessToken);
    await RefreshTokenPreference.shared.save(refreshToken);
  }

  static Future<String?> loadAccessToken() async =>
      await AccessTokenPreference.shared.load();

  static Future<String?> loadRefreshToken() async =>
      await RefreshTokenPreference.shared.load();

  static Future<void> reset() async {
    await AccessTokenPreference.shared.reset();
    await RefreshTokenPreference.shared.reset();
  }
}
