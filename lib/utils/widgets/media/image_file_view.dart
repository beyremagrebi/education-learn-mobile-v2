import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studiffy/core/constant/assets.dart';
import 'package:studiffy/core/style/dimensions.dart';

import 'package:studiffy/utils/custum_circular_progress.dart';
import 'package:studiffy/utils/view_models/media/image_file_viw_model.dart';
import 'package:studiffy/utils/widgets/background_image_safe_area.dart';

import 'common_image_widget.dart';

class ImageFileView extends StatelessWidget {
  final String imageFileMaterial;
  final List<String> listOfImages;
  final bool isFile;
  final bool isAsset;
  final int? initialPage;
  final String? folder;
  final String imagePath;

  const ImageFileView(
      {super.key,
      required this.imageFileMaterial,
      required this.listOfImages,
      required this.isFile,
      this.initialPage,
      this.isAsset = false,
      required this.folder,
      required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ImageFileViewModel(context),
      child: Consumer<ImageFileViewModel>(
        builder: (context, viewModel, _) {
          return Scaffold(
              appBar: AppBar(
                title: Text(imageFileMaterial),
              ),
              body: BackgroundImageSafeArea(
                svgAsset: Assets.bgMain,
                child: PageView(
                  controller:
                      PageController(initialPage: viewModel.currentImageIndex),
                  onPageChanged: viewModel.updateImageIndex,
                  children: (listOfImages.isEmpty
                          ? [imageFileMaterial]
                          : listOfImages)
                      .map((e) {
                    return InteractiveViewer(
                      minScale: 1,
                      maxScale: 5,
                      child: Container(
                        alignment: Alignment.center,
                        child: CommonImageWidget(
                            imagePath: isAsset
                                ? imagePath
                                : '$imagePath/$imageFileMaterial',
                            isFile: isFile,
                            isAsset: isAsset,
                            boxFit: BoxFit.contain,
                            imageBuilder: (context, imageProvider) => Image(
                                  image: ResizeImage(imageProvider,
                                      height: (Dimensions.dpr *
                                              Dimensions.screenHeight(context) *
                                              0.5)
                                          .round(),
                                      width: (Dimensions.dpr *
                                              Dimensions.screenWidth(context))
                                          .round()),
                                ),
                            errorWidget: (context, url, error) => const Center(
                                  child: Text('error to load image'),
                                ),
                            progressIndicatorBuilder:
                                (context, url, progress) =>
                                    const CustomCircularProgressIndicator()),
                      ),
                    );
                  }).toList(),
                ),
              ));
        },
      ),
    );
  }
}
