import 'package:studiffy/core/base/base_api_file.dart';

class ApiChunkFile extends BaseApiFile {
  final String? filename;
  final String fileExtension;
  final List<int> fileBytes;
  final int chunkIndex;

  const ApiChunkFile({
    this.filename,
    required this.fileExtension,
    required this.fileBytes,
    required this.chunkIndex,
  });
}
