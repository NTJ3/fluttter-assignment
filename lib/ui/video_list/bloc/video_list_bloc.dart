import 'dart:async';
import 'dart:convert';

import 'package:flutter_assignment/core/index.dart';
import 'package:flutter_assignment/ui/video_list/model/video_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

import 'video_list.dart';

class VideoListBloc extends Bloc<VideoListEvent, VideoListState> {
  VideoListBloc() : super(VideoListInitial());

  VideoListState get initialState => VideoListInitial();

  @override
  Stream<VideoListState> mapEventToState(VideoListEvent event) async* {
    if (event is FetchVideos) {
      yield VideoListLoading();
      try {
        var url = Uri.parse(APIs.kFetchVideos);
        var response = await http.get(url);

        log.info('Response status: ${response.statusCode}');
        log.info('Response body: ${jsonEncode(response.body)}');

        if (response.statusCode == 200) {
          List<dynamic> data = jsonDecode(response.body)["data"];
          List<VideoModel> list =
              data.map((e) => VideoModel().fromJson(e)).toList();
          yield VideoListSuccess(videoList: list);
        }
      } catch (error) {
        log.severe(error.toString(), error);
        yield const VideoListFailure(error: MessageString.kSomethingWentWrong);
        yield VideoListInitial();
      }
    }
  }
}
