import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:studiffy/core/localization/loalisation.dart';

import '../../../../core/api/api_service.dart';
import '../../../../core/api/errors/dialod_exception.dart';
import '../../../../core/config/env.dart';
import '../../../alert_utils.dart';
import '../session_manager.dart';
import '../sessions_manager/session_user_manager.dart';
import '../user_session/access_token_preference.dart';
import '../user_session/payment_preference.dart';
import '../user_session/refresh_token_preference.dart';
import 'token_decoder.dart';
import 'token_storage.dart';

class TokenService {
  static String? accessToken;
  static String? refreshToken;
  static DateTime? expiryDate;

  static Future<void> initialize() async {
    accessToken = await TokenStorage.loadAccessToken();
    refreshToken = await TokenStorage.loadRefreshToken();

    if (accessToken != null) {
      log(accessToken.toString());

      expiryDate = TokenDecoder.getExpiry(accessToken!);
      _checkPayment(accessToken!);
    }
  }

  static Future<String?> saveTokenAndGetUserId(
      String token, String refToken) async {
    try {
      await TokenStorage.saveTokens(token, refToken);
      accessToken = token;
      refreshToken = refToken;
      expiryDate = TokenDecoder.getExpiry(token);

      final userId = TokenDecoder.getUserId(token);
      if (userId == null) throw Exception(intl.tokenNoUserId);
      return userId;
    } catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }

  static Future<void> reset() async {
    accessToken = null;
    refreshToken = null;
    expiryDate = null;
    await TokenStorage.reset();
  }

  static Future<void> refresh() async {
    try {
      if (refreshToken == null) throw DialogException('Refresh token is null');

      final response = await ApiService.call(
        httpMethod: HttpMethod.post,
        url: '$baseUrl/refresh-token',
        body: {'refreshToken': refreshToken!},
        authIsRequired: false,
      );

      if (response.statusCode != 200) {
        await SessionManager.logout(errorAlertText: intl.errorTokenExpired);
        return;
      }

      final data = response.data as Map;
      if (data.containsKey('accessToken')) {
        accessToken = data['accessToken'];
        await AccessTokenPreference.shared.save(accessToken!);
        await _checkPayment(accessToken!);
      }

      if (data.containsKey('refreshToken')) {
        refreshToken = data['refreshToken'];
        await RefreshTokenPreference.shared.save(refreshToken!);
      }
    } catch (e) {
      await SessionManager.logout(errorAlertText: intl.errorTokenExpired);
      debugPrint(e.toString());
    }
  }

  static Future<void> _checkPayment(String token) async {
    try {
      if (TokenDecoder.hasUnpaidPurchase(token)) {
        AlertUtils.show(
          title: 'unpaid',
          description: 'should Paid',
          dialogType: DialogType.warning,
        );
        await PaymentPreference.shared.save(true);
        SessionUserManager.isUnpaid = true;
      } else {
        await PaymentPreference.shared.save(false);
        SessionUserManager.isUnpaid = false;
      }
    } catch (e) {
      AlertUtils.show(
        title: intl.genericError,
        description: e.toString(),
        dialogType: DialogType.error,
      );
    }
  }
}
