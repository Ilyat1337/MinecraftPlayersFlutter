import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart' as VP;

class VideoPlayer extends StatefulWidget {
  final String videoUrl;
  const VideoPlayer({Key key, @required this.videoUrl}) : super(key: key);

  @override
  VideoPlayerState createState() => VideoPlayerState();
}

class VideoPlayerState extends State<VideoPlayer> {
  VP.VideoPlayerController _controller;
  ChewieController _chewieController;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    _controller = VP.VideoPlayerController.network(widget.videoUrl);
    _initializeVideoPlayerFuture = _controller.initialize();
    _chewieController = ChewieController(videoPlayerController: _controller);

    setState(() {});
  }

  @override
  void dispose() {
    _controller.dispose();
    _chewieController.dispose();

    super.dispose();
  }

  void pauseVideo() {
    _chewieController.pause();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
            return AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: Chewie(
                controller: _chewieController,
              ),
            );
          //);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      }
    );
  }
}
