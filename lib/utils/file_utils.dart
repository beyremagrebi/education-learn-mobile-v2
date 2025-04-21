import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';

import '../core/api/errors/api_exception.dart';

class FileUtils {
  static MediaType getMediaType(String filePath) {
    String? mimeType = lookupMimeType(filePath);
    if (mimeType == null) {
      throw ApiException(message: 'File type invalid');
    }

    return MediaType.parse(mimeType);
  }

  static List<String> imageExtensions = [
    'png',
    'jpg',
    'jpeg',
    'gif',
    'webp',
    'bmp',
    'wbmp',
    'pbm',
    'pgm',
    'ppm',
    'tga',
    'ico',
    'cur',
  ];
  static List<String> videoExtensions = [
    'mp4',
    'avi',
    'mov',
    'wmv',
    'flv',
    'mkv',
    'webm',
    'mpeg',
    'mpg',
    'm4v',
    '3gp',
    '3g2',
    'mxf',
    'ogv',
    'asf',
    'vob',
  ];

  static bool isImage(String filename) {
    return imageExtensions.contains(
      getExtension(filename.toLowerCase()),
    );
  }

  static bool isVideo(String filename) {
    return videoExtensions.contains(getExtension(filename.toLowerCase()));
  }

  static String getExtension(String fileName) {
    List<String> parts = fileName.split('.');
    if (parts.length > 1) {
      return parts.last;
    } else {
      return ''; // No extension found
    }
  }
}
