import 'package:flutter/material.dart';
import 'package:studiffy/core/config/env.dart';
import 'package:studiffy/core/constant/assets.dart';
import 'package:studiffy/core/localization/loalisation.dart';
import 'package:studiffy/utils/widgets/async_widgets/error_widget.dart';
import 'package:studiffy/utils/widgets/background_image_safe_area.dart';
import 'package:studiffy/utils/widgets/media/doc/docx_view_file.dart';
import 'package:studiffy/utils/widgets/media/image_file_view.dart';
import 'package:studiffy/utils/widgets/media/pdf/pdf_view_file.dart';
import 'package:studiffy/utils/widgets/media/video/video_player_view.dart';

import '../../file_utils.dart';

class MaterialViewFile extends StatelessWidget {
  final String? fileName;
  final String? displayName;

  const MaterialViewFile({
    super.key,
    required this.displayName,
    this.fileName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(displayName ?? intl.undefined),
      ),
      body: BackgroundImageSafeArea(
        svgAsset: Assets.bgMain,
        child: _buildFileViewType(),
      ),
    );
  }

  Widget _buildFileViewType() {
    if (fileName == null) return _buildUnsupportedFileViewer();
    final extension = FileUtils.getExtension(fileName!);
    if (FileUtils.imageExtensions.contains(extension)) {
      return _buildImageViewer();
    } else if (FileUtils.videoExtensions.contains(extension)) {
      return _buildVideoViewer();
    } else if (FileUtils.pdfExtensions.contains(extension)) {
      return _buildPdfViewer();
    } else if (FileUtils.pptExtensions.contains(extension)) {
      return _buildPptViewer();
    } else if (FileUtils.wordExtensions.contains(extension)) {
      return _buildWordViewer();
    } else if (FileUtils.excelExtensions.contains(extension)) {
      return _buildExcelViewer();
    } else {
      return _buildUnsupportedFileViewer();
    }
  }

  Widget _buildImageViewer() {
    return ImageFileView(
      imageFileMaterial: fileName!,
      listOfImages: const [],
      isFile: false,
      folder: null,
      imagePath: fileUrl,
    );
  }

  Widget _buildVideoViewer() {
    return VideoPlayerView(url: '$videofileUrl/$fileName');
  }

  Widget _buildPdfViewer() {
    return PdfViewFile(url: '$fileUrl/lesson/$fileName');
  }

  Widget _buildPptViewer() {
    return DocxViewFile(url: '$fileUrl/lesson/$fileName');
  }

  Widget _buildWordViewer() {
    return DocxViewFile(url: '$fileUrl/lesson/$fileName');
  }

  Widget _buildExcelViewer() {
    return DocxViewFile(url: '$fileUrl/lesson/$fileName');
  }

  Widget _buildUnsupportedFileViewer() {
    return const ErrorDisplayWidget(
      message: 'Unsupported file type',
      title: 'Error',
    );
  }
}
