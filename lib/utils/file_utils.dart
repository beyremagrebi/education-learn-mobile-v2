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

  static List<String> pdfExtensions = ['pdf'];

  static List<String> pptExtensions = [
    'ppt',
    'pptx',
    'pps',
    'ppsx',
    'pot',
    'potx',
    'odp'
  ];

  static List<String> wordExtensions = [
    'doc',
    'docx',
    'dot',
    'dotx',
    'odt',
    'rtf',
    'wpd'
  ];

  static List<String> excelExtensions = [
    'xls',
    'xlsx',
    'xlsm',
    'xlsb',
    'csv',
    'ods'
  ];

  static bool isImage(String filename) {
    return imageExtensions.contains(
      getExtension(filename.toLowerCase()),
    );
  }

  static bool isVideo(String filename) {
    return videoExtensions.contains(getExtension(filename.toLowerCase()));
  }

  static bool isPdf(String filename) {
    return pdfExtensions.contains(getExtension(filename.toLowerCase()));
  }

  static bool isPpt(String filename) {
    return pptExtensions.contains(getExtension(filename.toLowerCase()));
  }

  static bool isWord(String filename) {
    return wordExtensions.contains(getExtension(filename.toLowerCase()));
  }

  static bool isExcel(String filename) {
    return excelExtensions.contains(getExtension(filename.toLowerCase()));
  }

  static String getExtension(String fileName) {
    List<String> parts = fileName.split('.');
    if (parts.length > 1) {
      return parts.last;
    } else {
      return '';
    }
  }
}
