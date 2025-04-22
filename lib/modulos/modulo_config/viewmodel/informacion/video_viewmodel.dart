import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoViewModel extends ChangeNotifier {
  late VideoPlayerController _controller;
  bool _isPlaying = false;

  VideoPlayerController get controller => _controller;
  bool get isPlaying => _isPlaying;

  VideoViewModel(String videoPath) {
    _controller = VideoPlayerController.asset(videoPath)
      ..initialize().then((_) {
        notifyListeners();   
      });
  }

  void togglePlayPause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
      _isPlaying = false;
    } else {
      _controller.play();
      _isPlaying = true;
    }
    notifyListeners();   
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
