import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:studiffy/core/constant/assets.dart';
import 'package:studiffy/utils/widgets/background_image_safe_area.dart';

class PdfViewFile extends StatelessWidget {
  final String url;
  const PdfViewFile({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Viewer'),
      ),
      body: BackgroundImageSafeArea(
        svgAsset: Assets.bgMain,
        child: const PDF().cachedFromUrl(
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
          errorWidget: (error) => Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red[400],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Failed to load PDF',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    error.toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.refresh),
                    label: const Text('Try Again'),
                    onPressed: () {
                      // You might want to add logic to retry loading
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => PdfViewFile(url: url),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
