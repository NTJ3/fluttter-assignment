import 'package:equatable/equatable.dart';

abstract class VideoListEvent extends Equatable {
  const VideoListEvent();
}

class FetchVideos extends VideoListEvent {
  const FetchVideos();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'FetchVideos ';
}
