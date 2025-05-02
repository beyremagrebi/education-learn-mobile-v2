import 'package:flutter/material.dart';
import 'package:studiffy/core/api/utils/from_json.dart';
import 'package:studiffy/core/base/base_model.dart';

import '../../utils/file_type_utils.dart';

class StudyMaterial extends BaseModel {
  String? displayName;
  String? fileName;
  int? fileSize;

  StudyMaterial({
    this.displayName,
    this.fileName,
    this.fileSize,
    super.id,
  });
  StudyMaterial.fromId(String? id) : super(id: id);

  factory StudyMaterial.fromMap(map) {
    if (map is String) return StudyMaterial.fromId(map);
    return StudyMaterial(
      id: '',
      displayName: FromJson.string(map['displayName']),
      fileName: FromJson.string(map['fileName']),
    );
  }

  IconData get icon => FileTypeUtils.getIconForFileName(fileName);

  String get fileType => FileTypeUtils.getFileTypeCategory(fileName);

  String get formattedFileSize {
    if (fileSize == null) return 'Taille inconnue';
    if (fileSize! < 1024) return '$fileSize B';
    if (fileSize! < 1024 * 1024) {
      return '${(fileSize! / 1024).toStringAsFixed(1)} KB';
    }
    return '${(fileSize! / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  String get subtitle {
    final type = FileTypeUtils.getSubtitleForFileName(fileName);
    return '$type - $formattedFileSize';
  }

  @override
  Map<String, Object> toMap() {
    // TODO: implement toMap
    throw UnimplementedError();
  }
}
