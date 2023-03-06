import 'package:cached_video_player/cached_video_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_assignment/core/index.dart';
import 'package:flutter_assignment/ui/video_list/components/cache_video_player_widget.dart';
import 'package:flutter_assignment/ui/video_list/components/video_player_widget.dart';
import 'package:flutter_assignment/ui/video_list/bloc/video_list.dart';
import 'package:flutter_assignment/ui/video_list/model/video_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

class VideoListScreen extends StatefulWidget {
  final bool isChacheVideoPlayer;
  const VideoListScreen({super.key, required this.isChacheVideoPlayer});

  @override
  State<VideoListScreen> createState() => _VideoListScreenState();
}

class _VideoListScreenState extends State<VideoListScreen> {
  final PageController _pageViewController = PageController(initialPage: 0);
  late VideoPlayerController? _videoPlayercontroller;
  late CachedVideoPlayerController? _cachedVideoPlayerController;
  late VideoListBloc _videoListBloc;

  @override
  void initState() {
    super.initState();
    _videoListBloc = BlocProvider.of<VideoListBloc>(context);
    _videoListBloc.add(const FetchVideos());
  }

  _onPageChanged(int index, List<VideoModel> list) {
    if (widget.isChacheVideoPlayer) {
      _cachedVideoPlayerController?.pause();
    } else {
      _videoPlayercontroller?.pause();
    }
    initVideoPlayer(list[index].url);
    setState(() {});
  }

  void _videoListBlocListner(context, state) {
    if (state is VideoListFailure) {
      showToast(state.error, context, isError: true);
    } else if (state is VideoListSuccess) {
      initVideoPlayer(state.videoList.first.url);
    }
  }

  void initVideoPlayer(String videoUrl) {
    if (widget.isChacheVideoPlayer) {
      _cachedVideoPlayerController =
          CachedVideoPlayerController.network(videoUrl)
            ..initialize().then((value) {
              _cachedVideoPlayerController?.play();
              setState(() {});
            }).onError((error, stackTrace) {
              if (error is PlatformException) {
                error = error.message;
              }
              showToast(error.toString(), context, isError: true);
            });
      return;
    }
    _videoPlayercontroller = VideoPlayerController.network(videoUrl)
      ..initialize().then((_) {
        _videoPlayercontroller?.play();
        _videoPlayercontroller?.setLooping(true);
        setState(() {});
      }).onError((error, stackTrace) {
        if (error is PlatformException) {
          error = error.message;
        }
        showToast(error.toString(), context, isError: true);
      });
  }

  _playPaushVideo() async {
    if (_videoPlayercontroller!.value.isBuffering) {
      return;
    } else {
      if (_videoPlayercontroller!.value.isPlaying) {
        await _videoPlayercontroller?.pause();
      } else {
        _videoPlayercontroller?.play();
      }
    }
    setState(() {});
  }

  _playPaushCacheVideo() async {
    if (_cachedVideoPlayerController!.value.isBuffering) {
      return;
    } else {
      if (_cachedVideoPlayerController!.value.isPlaying) {
        await _cachedVideoPlayerController?.pause();
      } else {
        _cachedVideoPlayerController?.play();
      }
    }
    setState(() {});
  }

  @override
  void dispose() {
    if (widget.isChacheVideoPlayer) {
      _cachedVideoPlayerController?.pause();
      _cachedVideoPlayerController?.dispose();
    } else {
      _videoPlayercontroller?.pause();
      _videoPlayercontroller?.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(widget.isChacheVideoPlayer
            ? ScreenTitle.kCacheVideoPlayer
            : ScreenTitle.kVideoPlayer),
        backgroundColor: Colors.black.withOpacity(0.2),
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocConsumer<VideoListBloc, VideoListState>(
        listener: _videoListBlocListner,
        builder: _buildVideoList,
      ),
    );
  }

  Widget _buildVideoList(context, state) {
    if (state is VideoListLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is VideoListSuccess) {
      return PageView(
        controller: _pageViewController,
        scrollDirection: Axis.vertical,
        onPageChanged: (index) => _onPageChanged(index, state.videoList),
        children: state.videoList
            .asMap()
            .map(
              (i, element) => MapEntry(
                i,
                widget.isChacheVideoPlayer
                    ? CacheVideoPlayerWidget(
                        controller: _cachedVideoPlayerController!,
                        onPlayPauseVideo: () => _playPaushCacheVideo(),
                        videoModel: element,
                      )
                    : VideoPlayerWidget(
                        controller: _videoPlayercontroller!,
                        videoModel: element,
                        onPlayPauseVideo: () => _playPaushVideo(),
                      ),
              ),
            )
            .values
            .toList(),
      );
    }
    return Container();
  }
}
