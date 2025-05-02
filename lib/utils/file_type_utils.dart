import 'package:flutter/material.dart';

class FileTypeUtils {
  // Private constructor to prevent instantiation
  FileTypeUtils._();

  // File type colors
  static const Color pdfColor = Color(0xFFE53935); // Red
  static const Color presentationColor = Color(0xFFFF8F00); // Amber
  static const Color documentColor = Color(0xFF1976D2); // Blue
  static const Color spreadsheetColor = Color(0xFF388E3C); // Green
  static const Color archiveColor = Color(0xFF6D4C41); // Brown
  static const Color linkColor = Color(0xFF7B1FA2); // Purple
  static const Color videoColor = Color(0xFFD81B60); // Pink
  static const Color imageColor = Color(0xFF0097A7); // Teal
  static const Color defaultColor = Color(0xFF757575); // Grey

  static IconData getIconForFileName(String? fileName) {
    final name = fileName?.toLowerCase() ?? '';

    if (name.endsWith('.pdf')) return Icons.picture_as_pdf;
    if (name.endsWith('.ppt') || name.endsWith('.pptx')) return Icons.slideshow;
    if (name.endsWith('.doc') || name.endsWith('.docx')) return Icons.article;
    if (name.endsWith('.xls') || name.endsWith('.xlsx')) {
      return Icons.table_chart;
    }
    if (name.endsWith('.zip') || name.endsWith('.rar')) return Icons.folder_zip;
    if (name.startsWith('http')) return Icons.link;
    if (name.endsWith('.mp4') ||
        name.endsWith('.mov') ||
        name.endsWith('.avi')) {
      return Icons.video_file;
    }
    if (name.endsWith('.jpg') ||
        name.endsWith('.jpeg') ||
        name.endsWith('.png')) {
      return Icons.image;
    }

    return Icons.insert_drive_file; // Default icon
  }

  static String getSubtitleForFileName(String? fileName) {
    final name = fileName ?? '';

    if (name.startsWith('http')) return 'External Link';

    final ext = name.split('.').last.toUpperCase();
    return ext;
  }

  static String getFileTypeCategory(String? fileName) {
    final name = fileName?.toLowerCase() ?? '';

    if (name.endsWith('.pdf')) return 'PDF';
    if (name.endsWith('.ppt') || name.endsWith('.pptx')) return 'Presentation';
    if (name.endsWith('.doc') || name.endsWith('.docx')) return 'Document';
    if (name.endsWith('.xls') || name.endsWith('.xlsx')) return 'Spreadsheet';
    if (name.endsWith('.zip') || name.endsWith('.rar')) return 'Archive';
    if (name.startsWith('http')) return 'Link';
    if (name.endsWith('.mp4') ||
        name.endsWith('.mov') ||
        name.endsWith('.avi')) {
      return 'Video';
    }
    if (name.endsWith('.jpg') ||
        name.endsWith('.jpeg') ||
        name.endsWith('.png')) {
      return 'Image';
    }

    return 'File';
  }

  static Color getColorForFileType(String? fileName) {
    final name = fileName?.toLowerCase() ?? '';

    if (name.endsWith('.pdf')) return pdfColor;
    if (name.endsWith('.ppt') || name.endsWith('.pptx')) {
      return presentationColor;
    }
    if (name.endsWith('.doc') || name.endsWith('.docx')) return documentColor;
    if (name.endsWith('.xls') || name.endsWith('.xlsx')) {
      return spreadsheetColor;
    }
    if (name.endsWith('.zip') || name.endsWith('.rar')) return archiveColor;
    if (name.startsWith('http')) return linkColor;
    if (name.endsWith('.mp4') ||
        name.endsWith('.mov') ||
        name.endsWith('.avi')) {
      return videoColor;
    }
    if (name.endsWith('.jpg') ||
        name.endsWith('.jpeg') ||
        name.endsWith('.png')) {
      return imageColor;
    }

    return defaultColor;
  }

  static Color getColorForFileCategory(String category) {
    switch (category.toLowerCase()) {
      case 'pdf':
        return pdfColor;
      case 'presentation':
        return presentationColor;
      case 'document':
        return documentColor;
      case 'spreadsheet':
        return spreadsheetColor;
      case 'archive':
        return archiveColor;
      case 'link':
        return linkColor;
      case 'video':
        return videoColor;
      case 'image':
        return imageColor;
      default:
        return defaultColor;
    }
  }
}
