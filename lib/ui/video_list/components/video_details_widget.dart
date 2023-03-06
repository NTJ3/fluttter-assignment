import 'package:flutter/material.dart';
import 'package:flutter_assignment/ui/video_list/model/video_model.dart';

class VideoDetails extends StatelessWidget {
  final VideoModel videoModel;
  const VideoDetails({super.key, required this.videoModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.3),
      padding: const EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            videoModel.caption,
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 6),
          Text(
            videoModel.createdAt,
            style: Theme.of(context)
                .textTheme
                .caption
                ?.copyWith(color: Colors.white),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              IconTextWidget(
                videoModel: videoModel,
                icon: Icons.thumb_up_alt_outlined,
              ),
              const SizedBox(width: 10),
              IconTextWidget(
                videoModel: videoModel,
                icon: Icons.remove_red_eye_outlined,
              )
            ],
          ),
          const SizedBox(height: 10)
        ],
      ),
    );
  }
}

class IconTextWidget extends StatelessWidget {
  const IconTextWidget({
    Key? key,
    required this.videoModel,
    required this.icon,
  }) : super(key: key);

  final VideoModel videoModel;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: Colors.white,
        ),
        const SizedBox(width: 4),
        Text(videoModel.views.toString(),
            style: const TextStyle(
              color: Colors.white,
            )),
      ],
    );
  }
}
