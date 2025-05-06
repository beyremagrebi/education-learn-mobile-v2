import 'package:studiffy/core/api/api_response.dart';
import 'package:studiffy/core/api/api_service.dart';
import 'package:studiffy/core/api/services/base_service.dart';
import 'package:studiffy/core/config/env.dart';
import 'package:studiffy/models/global/login_info.dart';

import '../../../../models/global/user/user.dart';

class AuthService extends BaseService<User> {
  // SINGLETON ----------------------------------------------------------------

  static final AuthService _instance = AuthService._internal();

  static AuthService get shared => _instance;

  AuthService._internal();

  @override
  String get apiUrl => baseUrl;

  @override
  User Function(Map<String, dynamic> json) get fromMapFunction => User.fromMap;

  Future<ApiResponse<LoginInfo>> login({
    required String email,
    required String password,
  }) async {
    return await ApiService.call<LoginInfo>(
      url: '$apiUrl/login-desktop-vite',
      httpMethod: HttpMethod.post,
      body: {
        'email': email.toLowerCase().replaceAll(' ', ''),
        'password': password,
        'forMobile': true
      },
      dataKey: 'payload',
      authIsRequired: false,
    );
  }

  Future<ApiResponse> logout() async {
    return await ApiService.call(
      url: '$apiUrl/logout',
      httpMethod: HttpMethod.delete,
      authIsRequired: true,
    );
  }

  Future<ApiResponse<LoginInfo>> checkIsFirstLogin({
    required String email,
  }) async {
    return await ApiService.call<LoginInfo>(
      url: '$apiUrl/check-is-first-login',
      httpMethod: HttpMethod.post,
      body: {
        'email': email.toLowerCase().replaceAll(' ', ''),
      },
      authIsRequired: false,
    );
  }
}
