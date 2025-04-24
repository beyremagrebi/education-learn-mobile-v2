import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:studiffy/core/config/env.dart';
import 'package:studiffy/core/constant/assets.dart';
import 'package:studiffy/utils/app/session/token_manager.dart';
import 'package:studiffy/utils/navigator_utils.dart';

import '../../../core/style/dimensions.dart';
import '../../../core/style/themes/app_colors.dart';
import 'image_file_view.dart';

class ApiImageWidget extends StatelessWidget {
  final String? imageFilename;
  final String? baseUrl;
  final double height;
  final double width;
  final BorderRadius borderRadius;
  final double iconSize;
  final Color backgroundColor;
  final Color? foregroundColor;
  final BoxFit? fit;
  final bool isProfilePicture;
  final bool hasImageViewer;
  final bool isAsset;
  final bool? isMen;
  final String? placeholderAssetPath;
  final EdgeInsets? placeholderPadding;

  const ApiImageWidget({
    super.key,
    required this.imageFilename,
    this.baseUrl,
    this.isAsset = false,
    this.height = 80.0,
    this.width = 80.0,
    this.borderRadius = Dimensions.smallBorderRadius,
    this.iconSize = 60,
    this.backgroundColor = lightDisabledColor,
    this.foregroundColor,
    this.placeholderPadding,
    this.fit,
    this.isProfilePicture = false,
    this.hasImageViewer = false,
    this.placeholderAssetPath,
    this.isMen,
  });

  @override
  Widget build(BuildContext context) {
    if (imageFilename == null ||
        imageFilename == 'default-avatar-icon.jpg' ||
        imageFilename == 'default-enterprise-icon.jpg') {
      // Image is considered null
      return _buildPlaceholderImage(context: context);
    } else {
      // Image is not null
      return isAsset
          ? _buildAssetImage(context)
          : _buildCachedNetworkImage(context);
    }
  }

  Widget _buildAssetImage(BuildContext context) {
    return _buildImage(context, AssetImage(imageFilename!));
  }

  Widget _buildCachedNetworkImage(BuildContext context) {
    final imageUrl = '${baseUrl ?? fileUrl}/$imageFilename';

    final memCacheHeight = (width * Dimensions.dpr).round();
    final memCacheWidth = (height * Dimensions.dpr).round();
    return CachedNetworkImage(
      key: Key(imageUrl),
      cacheKey: imageUrl,
      imageUrl: imageUrl,
      httpHeaders: {
        'Authorization': 'Bearer ${TokenManager.accessToken}',
      },
      imageBuilder: (context, imageProvider) => _buildImage(
        context,
        ResizeImage(imageProvider,
            height: memCacheHeight, width: memCacheWidth),
      ),
      progressIndicatorBuilder: (context, url, progress) =>
          _buildPlaceholderImage(isLoading: true, context: context),
      errorWidget: (context, url, error) =>
          _buildPlaceholderImage(context: context),
    );
  }

  Widget _buildImage(BuildContext context, ImageProvider imageProvider) {
    return InkWell(
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      onTap: hasImageViewer
          ? () => _showImageViewer(context, imageProvider)
          : null,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: isProfilePicture ? null : borderRadius,
            shape: isProfilePicture ? BoxShape.circle : BoxShape.rectangle),
        child: Image(
          image: imageProvider,
          fit: fit,
          height: height,
          width: width,
        ),
      ),
    );
  }

  Widget _buildPlaceholderImage(
      {bool isLoading = false, required BuildContext context}) {
    String finalPlaceholderPath =
        placeholderAssetPath ?? _getDefaultPlaceholderPath();
    final memCacheHeight = (width * Dimensions.dpr).round();
    final memCacheWidth = (height * Dimensions.dpr).round();
    return Container(
      height: height,
      width: width,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: isProfilePicture ? null : borderRadius,
        shape: isProfilePicture ? BoxShape.circle : BoxShape.rectangle,
      ),
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          isProfilePicture
              ? Image.asset(
                  finalPlaceholderPath,
                  fit: fit,
                  cacheHeight: memCacheHeight,
                  cacheWidth: memCacheWidth,
                )
              : isLoading
                  ? SpinKitDualRing(
                      color: Theme.of(context).colorScheme.primary)
                  : Image.asset(
                      finalPlaceholderPath,
                      fit: fit,
                      cacheHeight: memCacheHeight,
                      cacheWidth: memCacheWidth,
                    ),
          if (isLoading && isProfilePicture)
            CircularProgressIndicator(
              backgroundColor: Colors.grey.shade300,
            ),
        ],
      ),
    );
  }

  String _getDefaultPlaceholderPath() {
    if (isMen ?? false) {
      return Assets.defaultMaleAvatar;
    } else {
      return Assets.defaultFemaleAvatar;
    }
  }

  void _showImageViewer(BuildContext context, ImageProvider imageProvider) {
    navigateTo(
      context,
      ImageFileView(
        folder: null,
        imageFileMaterial: imageFilename ?? '',
        imagePath: fileUrl,
        isFile: false,
        listOfImages: const [],
        initialPage: 1,
      ),
    );
  }
}
