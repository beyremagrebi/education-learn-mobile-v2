import 'package:dio/dio.dart';

import '../../../utils/app/session/session_manager.dart';
import '../../base/base_api_file.dart';
import '../../base/base_model.dart';
import '../api_response.dart';
import '../api_service.dart';
import '../errors/dialod_exception.dart';
import 'ap_endpoint.dart';

abstract class BaseService<Model extends BaseModel> {
  String get scholarshipConfigId =>
      SessionManager.facility.scholarshipConfigId?.id ?? '';
  String get childScholarshipConfigId => 'helllo';

  String get institution => SessionManager.facility.type.endpoint;

  /// The base url of the api
  String get apiUrl;

  /// This function is used to convert the json data to the model
  Model Function(Map<String, dynamic> json) get fromMapFunction;

  ApiEndpoints get endpoints => const ApiEndpoints();

  Future<ApiResponse<List<Model>>> getAll() async {
    return await ApiService.call<List<Model>>(
      url: apiUrl + endpoints.getAll,
      httpMethod: HttpMethod.get,
      dataKey: endpoints.getAllDataKey,
    );
  }

  Future<ApiResponse<Model>> getById(String? id) async {
    if (id == null) throw DialogException('User id is required');

    return await ApiService.call(
      url: '$apiUrl${endpoints.getById}/$id',
      httpMethod: HttpMethod.get,
      dataKey: endpoints.getByIdDataKey,
    );
  }

  Future<ApiResponse<Model>> add(Model model) async {
    return await ApiService.call(
      url: apiUrl + endpoints.add,
      httpMethod: HttpMethod.post,
      body: model.toMap(),
      dataKey: endpoints.addDataKey,
    );
  }

  Future<ApiResponse<Model>> addWithFiles(
    Model model, {
    BaseApiFile? file,
    ProgressCallback? onSendProgress,
  }) async {
    return await ApiService.call(
      url: apiUrl + endpoints.add,
      httpMethod: HttpMethod.post,
      body: model.toMap(),
      dataKey: endpoints.addDataKey,
      isMultipart: true,
      apiFile: file,
      onSendProgress: onSendProgress,
    );
  }

  Future<ApiResponse<Model>> update(Model model) async {
    return await ApiService.call(
      url: '$apiUrl${endpoints.update}/${model.id}',
      httpMethod: HttpMethod.patch,
      body: model.toMap(),
      dataKey: endpoints.updateDataKey,
    );
  }

  Future<ApiResponse<Model>> updateWithFiles(
    Model model, {
    BaseApiFile? file,
    ProgressCallback? onSendProgress,
  }) async {
    return await ApiService.call(
      url: '$apiUrl${endpoints.update}/${model.id}',
      httpMethod: HttpMethod.patch,
      body: model.toMap(),
      dataKey: endpoints.updateDataKey,
      isMultipart: true,
      apiFile: file,
      onSendProgress: onSendProgress,
    );
  }

  Future<ApiResponse<Model>> delete(String? id) async {
    if (id == null) throw DialogException('Provided id cannot be null');

    return await ApiService.call<Model>(
      url: '$apiUrl${endpoints.delete}/$id',
      httpMethod: HttpMethod.delete,
    );
  }
}
