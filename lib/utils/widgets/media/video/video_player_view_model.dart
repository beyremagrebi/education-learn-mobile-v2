import 'dart:async';

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:studiffy/core/base/base_view_model.dart';
import 'package:studiffy/utils/widgets/async_widgets/error_widget.dart';

class VideoPlayerViewModel extends BaseViewModel {
  late BetterPlayerController _betterPlayerController;
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;
  bool _hasError = false;
  bool get hasError => _hasError;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  VideoPlayerViewModel(super.context, {required String videoUrl}) {
    _initializeController(videoUrl);
  }

  BetterPlayerController get controller => _betterPlayerController;
  Widget get playerWidget => BetterPlayer(controller: _betterPlayerController);

  Future<void> _initializeController(String url) async {
    try {
      // Optimize cache configuration for better performance
      final dataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        url,
        cacheConfiguration: const BetterPlayerCacheConfiguration(
          useCache: true,
          maxCacheSize: 200 * 1024 * 1024,
          maxCacheFileSize: 20 * 1024 * 1024,
          preCacheSize: 3 * 1024 * 1024,
        ),
        bufferingConfiguration: const BetterPlayerBufferingConfiguration(
          minBufferMs: 5000,
          maxBufferMs: 15000,
          bufferForPlaybackMs: 2500,
          bufferForPlaybackAfterRebufferMs: 5000,
        ),
      );

      _betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(
          autoPlay: true,
          looping: true,
          aspectRatio: 16 / 9,
          fit: BoxFit.contain,
          controlsConfiguration: const BetterPlayerControlsConfiguration(
            showControls: true,
            enableProgressText: false,
            enableProgressBar: true,
            enablePlayPause: true,
            enableFullscreen: true,
          ),
          errorBuilder: (context, errorMessage) {
            return const ErrorDisplayWidget(
              message: 'Error Loading video',
              title: 'Error',
            );
          },
        ),
        betterPlayerDataSource: dataSource,
      );
      await _betterPlayerController.setupDataSource(dataSource).timeout(
          const Duration(seconds: 15),
          onTimeout: () => throw TimeoutException('Video loading timed out'));

      _isInitialized = true;
      update();
    } catch (e) {
      _hasError = true;
      _errorMessage = e.toString();
      update();
      debugPrint('Video initialization error: $e');
    }
  }

  Future<void> togglePlayPause() async {
    if (!_isInitialized) return;

    if (_betterPlayerController.isPlaying() ?? false) {
      await _betterPlayerController.pause();
    } else {
      await _betterPlayerController.play();
    }
    update();
  }

  @override
  void dispose() {
    _betterPlayerController.removeEventsListener((event) {});
    _betterPlayerController.dispose();
    _isInitialized = false;
    super.dispose();
  }
}
