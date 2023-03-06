import 'package:flutter/material.dart';
import 'package:flutter_assignment/ui/video_list/bloc/video_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'video_list_screen.dart';

class VideoListPage extends StatelessWidget {
  static String tag = '/video-list-screen';
  final bool isChacheVideoPlayer;
  const VideoListPage({super.key, required this.isChacheVideoPlayer});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (context) => VideoListBloc(),
        child: SafeArea(
            child: VideoListScreen(
          isChacheVideoPlayer: isChacheVideoPlayer,
        )),
      );
}
