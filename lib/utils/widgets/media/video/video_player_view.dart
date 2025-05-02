import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studiffy/core/constant/assets.dart';
import 'package:studiffy/utils/widgets/background_image_safe_area.dart';
import 'package:studiffy/utils/widgets/media/video/video_player_view_model.dart';

class VideoPlayerView extends StatelessWidget {
  final String url;
  const VideoPlayerView({super.key, required this.url});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => VideoPlayerViewModel(context, videoUrl: url),
      child: Consumer<VideoPlayerViewModel>(
        builder: (context, viewModel, child) => Scaffold(
          appBar: AppBar(
            title: const Text('video name'),
          ),
          body: BackgroundImageSafeArea(
              svgAsset: Assets.bgMain, child: viewModel.playerWidget),
        ),
      ),
    );
  }
}
