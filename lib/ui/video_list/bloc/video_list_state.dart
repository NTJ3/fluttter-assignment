import 'package:equatable/equatable.dart';
import 'package:flutter_assignment/ui/video_list/model/video_model.dart';

abstract class VideoListState extends Equatable {
  const VideoListState();

  @override
  List<Object> get props => [];
}

class VideoListInitial extends VideoListState {}

class VideoListLoading extends VideoListState {}

class VideoListSuccess extends VideoListState {
  final List<VideoModel> videoList;

  const VideoListSuccess({required this.videoList});

  @override
  List<Object> get props => [videoList];

  @override
  String toString() => 'VideoListSuccess { videoList: $videoList }';
}

class VideoListFailure extends VideoListState {
  final String error;

  const VideoListFailure({required this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'VideoListFailure { error: $error }';
}
