import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import '../../async_widgets/error_widget.dart';

class PdfViewFile extends StatelessWidget {
  final String url;
  const PdfViewFile({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return const PDF().cachedFromUrl(
      url,
      maxNrOfCacheObjects: 100,
      placeholder: (progress) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            const Text(
              'Loading PDF...',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              '$progress%',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
      errorWidget: (error) => const Center(
        child: ErrorDisplayWidget(
          message: 'Error Loding file',
          title: 'Error',
        ),
      ),
    );
  }
}
