import 'package:flutter/material.dart';
import 'package:imovie_ui/imovie_ui.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayWidget extends StatefulWidget {
  final String videoId;
  const VideoPlayWidget({super.key, required this.videoId});

  @override
  State<VideoPlayWidget> createState() => _VideoPlayWidgetState();
}

class _VideoPlayWidgetState extends State<VideoPlayWidget> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      topActions: [
        const SizedBox(height: 100),
        IUIButtons.back(context),
      ],
      showVideoProgressIndicator: true,
      progressIndicatorColor: Colors.amber,
      progressColors: const ProgressBarColors(
        playedColor: Colors.amber,
        handleColor: Colors.amberAccent,
      ),
      onEnded: (_) => Navigator.pop(context),
    );
  }
}
