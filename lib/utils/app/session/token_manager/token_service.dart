import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:studiffy/core/localization/loalisation.dart';

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
      // _checkPayment(accessToken!);
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

  // static Future<void> _checkPayment(String token) async {
  //   try {
  //     if (TokenDecoder.hasUnpaidPurchase(token)) {
  //       AlertUtils.show(
  //         title: 'unpaid',
  //         description: 'should Paid',
  //         dialogType: DialogType.warning,
  //       );
  //       await PaymentPreference.shared.save(true);
  //       SessionUserManager.isUnpaid = true;
  //     } else {
  //       await PaymentPreference.shared.save(false);
  //       SessionUserManager.isUnpaid = false;
  //     }
  //   } catch (e) {
  //     AlertUtils.show(
  //       title: intl.genericError,
  //       description: e.toString(),
  //       dialogType: DialogType.error,
  //     );
  //   }
  // }
}
