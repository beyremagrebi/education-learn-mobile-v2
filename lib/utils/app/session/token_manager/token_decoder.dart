import 'package:jwt_decode/jwt_decode.dart';

class TokenDecoder {
  static Map<String, dynamic> decode(String token) {
    return Jwt.parseJwt(token);
  }

  static DateTime? getExpiry(String token) {
    final decoded = decode(token);
    return decoded.containsKey('exp')
        ? DateTime.fromMillisecondsSinceEpoch(decoded['exp'] * 1000)
        : DateTime(2200);
  }

  static String? getUserId(String token) {
    final decoded = decode(token);
    return decoded['_id'];
  }

  // static Rules? getRules(String token) {
  //   final decoded = decode(token);
  //   return decoded.containsKey('rule') ? Rules.fromMap(decoded['rule']) : null;
  // }

  static bool hasUnpaidPurchase(String token) {
    final decoded = decode(token);
    return decoded.containsKey('purchases');
  }
}
