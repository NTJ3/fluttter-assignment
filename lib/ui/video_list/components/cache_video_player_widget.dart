import 'package:flutter/material.dart';
import 'package:flutter_assignment/ui/video_list/components/video_details_widget.dart';
import 'package:flutter_assignment/ui/video_list/model/video_model.dart';
import 'package:cached_video_player/cached_video_player.dart';
import 'dart:ui' as ui;

class CacheVideoPlayerWidget extends StatelessWidget {
  final CachedVideoPlayerController controller;
  final VideoModel videoModel;
  final VoidCallback onPlayPauseVideo;
  const CacheVideoPlayerWidget(
      {super.key,
      required this.controller,
      required this.videoModel,
      required this.onPlayPauseVideo});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        AnimatedOpacity(
          opacity: controller.value.isInitialized ? 0.0 : 1.0,
          duration: const Duration(microseconds: 1500),
          child: Stack(
            children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    videoModel.thumbnail,
                    fit: BoxFit.cover,
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ClipRRect(
                  // make sure we apply clip it properly
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.grey.withOpacity(0.1),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        AnimatedOpacity(
          opacity: controller.value.isInitialized ? 1.0 : 0.0,
          duration: const Duration(microseconds: 1500),
          child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: CachedVideoPlayer(controller)),
          ),
        ),

        // PLAY PAUSE BUTTON
        PlayPauseWidget(
            onPlayPauseVideo: onPlayPauseVideo, controller: controller),

        // VIDEO DETAILS
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: VideoDetails(
            videoModel: videoModel,
          ),
        ),
      ],
    );
  }
}

class PlayPauseWidget extends StatelessWidget {
  const PlayPauseWidget({
    Key? key,
    required this.onPlayPauseVideo,
    required this.controller,
  }) : super(key: key);

  final VoidCallback onPlayPauseVideo;
  final CachedVideoPlayerController controller;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        alignment: Alignment.center,
        height: 80.0,
        width: 80.0,
        child: GestureDetector(
          onTap: () {
            onPlayPauseVideo();
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: 60.0,
            width: 60.0,
            child: AnimatedOpacity(
              opacity: controller.value.isPlaying ? 0.0 : 1.0,
              duration: const Duration(milliseconds: 200),
              child: CircleAvatar(
                  backgroundColor: Colors.white.withOpacity(0.5),
                  radius: 30.0,
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 40.0,
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
