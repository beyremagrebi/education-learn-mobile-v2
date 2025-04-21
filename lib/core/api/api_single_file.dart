import 'package:studiffy/core/base/base_api_file.dart';

class ApiSingleFile extends BaseApiFile {
  final String? filePath;

  const ApiSingleFile({
    required super.name,
    required this.filePath,
  });
}
