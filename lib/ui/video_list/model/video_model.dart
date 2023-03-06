class VideoModel {
  late String contentId;

  late String caption;

  late String thumbnail;

  late String url;

  late int views;

  late int likes;

  late String createdAt;

  VideoModel fromJson(Map<String, dynamic> json) {
    VideoModel videoModel = VideoModel();
    videoModel.contentId = json['contentId'];
    videoModel.caption = json['caption'];
    videoModel.thumbnail = json['thumbnail'];
    videoModel.url = json['url'];
    videoModel.views = json['views'];
    videoModel.likes = json['likes'];
    videoModel.createdAt = json['createdAt'];

    return videoModel;
  }

  Map<String, dynamic> toJson() => {
        "contentId": contentId,
        "caption": caption,
        "thumbnail": thumbnail,
        "url": url,
        "views": views,
        "likes": likes,
        "createdAt": createdAt,
      };
}
