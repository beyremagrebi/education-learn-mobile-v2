import 'package:studiffy/core/api/api_response.dart';
import 'package:studiffy/core/api/api_service.dart';
import 'package:studiffy/core/api/errors/dialod_exception.dart';
import 'package:studiffy/core/api/services/base_service.dart';
import 'package:studiffy/core/config/env.dart';
import 'package:studiffy/core/localization/loalisation.dart';
import 'package:studiffy/models/global/user/user.dart';

import '../../api_single_file.dart';

class UserService extends BaseService<User> {
  // SINGLETON ----------------------------------------------------------------

  static final UserService _instance = UserService._internal();

  static UserService get shared => _instance;

  UserService._internal();

  // END SINGLETON ------------------------------------------------------------

  @override
  String get apiUrl => baseUrl;

  @override
  User Function(dynamic map) get fromMapFunction => User.fromMap;

  @override
  Future<ApiResponse<User>> getById(String? id) async {
    if (id == null) throw DialogException(intl.userIdRequired);

    return await ApiService.call(
      url: '$apiUrl/users/by-id',
      queryParameters: {'_id': id},
      httpMethod: HttpMethod.get,
      dataKey: endpoints.getByIdDataKey,
    );
  }

  Future<ApiResponse<User>> updateUserProfileImage(
      {required User user, required String filePath}) async {
    return await ApiService.call(
      url: '$apiUrl/update-profile/${user.id!}',
      httpMethod: HttpMethod.patch,
      body: user.toMap(),
      dataKey: 'user',
      apiFile: ApiSingleFile(name: 'files', filePath: filePath),
    );
  }

  Future<ApiResponse<User>> updateUserProfile({
    required User user,
  }) async {
    return await ApiService.call(
      url: '$apiUrl/update-profile/${user.id!}',
      httpMethod: HttpMethod.patch,
      body: user.toMap(),
      dataKey: 'user',
    );
  }
}
