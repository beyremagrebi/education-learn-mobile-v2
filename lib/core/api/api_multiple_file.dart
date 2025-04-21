import '../base/base_api_file.dart';

class ApiMultipleFile extends BaseApiFile {
  final List<String>? filePathList;
  final int? maxCount;

  const ApiMultipleFile({
    required super.name,
    required this.filePathList,
    this.maxCount,
  });
}
