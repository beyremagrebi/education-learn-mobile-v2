import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:studiffy/utils/app/session/token_manager.dart';

import '../../../utils/file_utils.dart';
import '../../base/base_api_file.dart';
import '../api_chunk_file.dart';
import '../api_multiple_file.dart';
import '../api_single_file.dart';
import '../custum_api_file.dart';

class ApiRequestBuilder {
  static Future<Map<String, String>> buildHeaders({
    required bool authIsRequired,
    bool isForChild = false,
  }) async {
    final headers = {
      'Content-Type': 'application/json; charset=utf-8',
    };

    if (authIsRequired) {
      if (isForChild) {
        // headers['Authorization'] =
        //     'Bearer ${ChildTokenManager.childaccessToken}';
      } else {
        // await TokenManager.initialize();
        headers['Authorization'] = 'Bearer ${TokenManager.accessToken}';
      } // TODO CHILD
    }

    return headers;
  }

  static Future<dynamic> buildRequestData({
    required bool isMultipart,
    Map<String, Object>? body,
    List<dynamic>? listBody,
    BaseApiFile? apiFile,
  }) async {
    if (isMultipart) {
      return await _buildMultipartData(body: body, apiFile: apiFile);
    }
    return jsonEncode(listBody ?? body ?? {});
  }

  static Future<Object?> _buildMultipartData({
    required Map<String, dynamic>? body,
    required BaseApiFile? apiFile,
  }) async {
    late FormData formData = FormData();

    if (apiFile != null) {
      if (apiFile is ApiSingleFile && apiFile.filePath != null) {
        formData.files.add(
          MapEntry(
            apiFile.name ?? 'file',
            await MultipartFile.fromFile(
              apiFile.filePath!,
              contentType: FileUtils.getMediaType(apiFile.filePath!),
            ),
          ),
        );
      } else if (apiFile is ApiMultipleFile) {
        for (String filePath in apiFile.filePathList ?? []) {
          formData.files.add(
            MapEntry(
              apiFile.name ?? 'file',
              await MultipartFile.fromFile(
                filePath,
                contentType: FileUtils.getMediaType(filePath),
              ),
            ),
          );
        }
      } else if (apiFile is ApiChunkFile) {
        formData.files.add(
          MapEntry(
            'chunk',
            MultipartFile.fromBytes(
              apiFile.fileBytes,
              filename: apiFile.filename ?? 'chunk.${apiFile.fileExtension}',
              contentType: MediaType('application', 'octet-stream'),
            ),
          ),
        );
      } else if (apiFile is CustomApiFile) {
        formData = apiFile.formData;
      }
    }

    body?.forEach((key, value) {
      if (value != null) {
        formData.fields.add(MapEntry(key, value.toString()));
      }
    });

    return formData;
  }
}
