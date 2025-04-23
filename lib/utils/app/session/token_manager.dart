import 'package:studiffy/utils/app/session/token_manager/token_service.dart';

class TokenManager {
  static Future<void> initialize() => TokenService.initialize();

  static Future<String?> saveTokenAndGetUserId(String token, String refToken) =>
      TokenService.saveTokenAndGetUserId(token, refToken);

  // static Future<void> refresh() => TokenService.refresh();

  static Future<void> reset() => TokenService.reset();

  static String? get accessToken => TokenService.accessToken;
  static String? get refreshToken => TokenService.refreshToken;
  static DateTime? get expiryDate => TokenService.expiryDate;
}
