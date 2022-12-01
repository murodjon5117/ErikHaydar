import 'package:flutter/foundation.dart';
import 'package:video_player/video_player.dart';

class VideoQuality {
  final String quality;
  final String url;
  VideoPlayerController? _videoController;

  VideoPlayerController get videoController =>
      _videoController ??= VideoPlayerController.network(url);

  VideoQuality(this.quality, this.url);
}

class VideoSettings {
  final List<VideoQuality>? qualities;
  final VideoQuality defaultQuality;
  final bool autoPlay;

  VideoQuality? _quality;

  VideoQuality get currentQuality => _quality ?? defaultQuality;

  VideoQuality setVideoQuality(String quality) =>
      _quality = qualities!.firstWhere(
        (e) => e.quality == quality,
        orElse: () => defaultQuality,
      );

  VideoSettings({
    required this.qualities,
    String? defaultQuality,
    this.autoPlay = false,
  })  : assert(qualities!.isNotEmpty),
        this.defaultQuality = qualities!.firstWhere(
          (e) => e.quality == defaultQuality,
          orElse: () => qualities.first,
        );
}
