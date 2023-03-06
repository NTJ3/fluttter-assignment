import 'package:flutter/material.dart';
import 'package:flutter_assignment/core/constants/index.dart';
import 'package:flutter_assignment/ui/video_list/screens/video_list_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(ScreenTitle.kHomeScreen),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const VideoListPage(
                              isChacheVideoPlayer: false,
                            )));
              },
              child: const Text(ButtonStrings.kGoToVideoPlayer)),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const VideoListPage(
                              isChacheVideoPlayer: true,
                            )));
              },
              child: const Text(ButtonStrings.kGoToCacheVideoPlayer))
        ],
      )),
    );
  }
}
