import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../core/style/dimensions.dart';
import '../../../core/style/themes/app_colors.dart';

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
    return SizedBox(
      key: Key(imageFilename!),
      height: height,
      width: width,
      child: _buildImage(context, AssetImage(imageFilename!)),
    );
  }

  Widget _buildCachedNetworkImage(BuildContext context) {
    // final imageUrl = '${baseUrl ?? filesUrl}/$imageFilename';
    return CachedNetworkImage(
      imageUrl: '',

      // key: Key(imageUrl),
      // height: height,
      // width: width,
      // cacheKey: imageUrl,
      // imageUrl: imageUrl,
      // httpHeaders: {
      //   'Authorization': 'Bearer ${TokenManager.accessToken}',
      // },
      // imageBuilder: (context, imageProvider) => _buildImage(
      //   context,
      //   imageProvider,
      // ),
      // progressIndicatorBuilder: (context, url, progress) =>
      //     _buildPlaceholderImage(isLoading: true),
      // errorWidget: (context, url, error) => _buildPlaceholderImage(),
    );
  }

  Widget _buildImage(BuildContext context, ImageProvider imageProvider) {
    return InkWell(
      overlayColor: const WidgetStatePropertyAll(Colors.transparent),
      onTap: hasImageViewer
          ? () => _showImageViewer(context, imageProvider)
          : null,
      child: isProfilePicture
          ? CircleAvatar(backgroundImage: imageProvider)
          : Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: borderRadius,
              ),
              child: Image(image: imageProvider, fit: fit),
            ),
    );
  }

  Widget _buildPlaceholderImage(
      {bool isLoading = false, required BuildContext context}) {
    String finalPlaceholderPath =
        placeholderAssetPath ?? _getDefaultPlaceholderPath();

    return Container(
      padding: placeholderPadding ?? Dimensions.paddingSmall,
      height: height,
      width: width,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: isMen == true
            ? Colors.blue
            : isMen == false
                ? Colors.pink.shade300
                : backgroundColor,
        borderRadius: isProfilePicture ? null : borderRadius,
        shape: isProfilePicture ? BoxShape.circle : BoxShape.rectangle,
      ),
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: [
          isProfilePicture
              ? Image.asset(finalPlaceholderPath, fit: fit)
              : isLoading
                  ? SpinKitDualRing(
                      color: Theme.of(context).colorScheme.primary)
                  : Image.asset(finalPlaceholderPath, fit: fit),
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
      return 'Assets.defaultMaleAvatar'; // Todo
    } else {
      return 'Assets.defaultFemaleAvatar';
    }
  }

  void _showImageViewer(BuildContext context, ImageProvider imageProvider) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('image'),
            backgroundColor: darkColor.withOpacity(0.5),
            foregroundColor: lightColor,
          ),
          extendBodyBehindAppBar: true,
          // body: PhotoView(imageProvider: imageProvider),
        ),
      ),
    );
  }
}
