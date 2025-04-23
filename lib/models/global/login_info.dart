import 'package:studiffy/core/api/utils/from_json.dart';
import 'package:studiffy/core/base/base_model.dart';

class LoginInfo extends BaseModel {
  final String? accessToken;
  final String? refreshToken;
  final String? email;
  final int? otp;
  final bool? userExist;
  final bool? hasPassword;
  final bool? isFristLogin;
  final bool staySignedIn;

  const LoginInfo({
    super.id,
    this.accessToken,
    this.refreshToken,
    this.otp,
    this.email,
    this.userExist,
    this.isFristLogin,
    this.hasPassword,
    this.staySignedIn = false,
  });

  factory LoginInfo.fromMap(map) {
    return LoginInfo(
      accessToken: FromJson.string(map['accessToken']),
      refreshToken: FromJson.string(map['refreshToken']),
      email: FromJson.string(map['email']),
      otp: FromJson.integer(map['otp']),
      userExist: FromJson.boolean(map['userExist']),
      isFristLogin: FromJson.boolean(map['isFristLogin']),
      hasPassword: FromJson.boolean(map['hasPassword']),
    );
  }

  @override
  Map<String, Object> toMap() {
    throw UnimplementedError();
  }
}
