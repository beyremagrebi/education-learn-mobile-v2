import 'dart:async';

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:studiffy/core/base/base_view_model.dart';

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
          placeholder: Center(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black,
              child: const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 16),
                    Text(
                      'Loading video...',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          errorBuilder: (context, errorMessage) {
            _hasError = true;
            _errorMessage = errorMessage;
            update();
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 42),
                  const SizedBox(height: 8),
                  Text('Video error: $errorMessage',
                      style: const TextStyle(color: Colors.white)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _retryInitialization(url),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          },
        ),
        betterPlayerDataSource: dataSource,
      );

      // Optimize event handling
      _betterPlayerController.addEventsListener((event) {
        if (event.betterPlayerEventType == BetterPlayerEventType.exception) {
          _hasError = true;
          _errorMessage = event.parameters?["error"] ?? event.toString();
          update();
        } else if (event.betterPlayerEventType ==
            BetterPlayerEventType.initialized) {
          // Preload next frames for smoother playback
        }
      });

      // Use a timeout to prevent hanging on initialization
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

  Future<void> _retryInitialization(String url) async {
    _hasError = false;
    _errorMessage = '';
    update();
    await _initializeController(url);
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
