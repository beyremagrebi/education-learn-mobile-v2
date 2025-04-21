import 'package:dio/dio.dart';
import 'package:studiffy/core/base/base_api_file.dart';

class CustomApiFile extends BaseApiFile {
  final FormData formData;

  const CustomApiFile({
    required this.formData,
  });
}
