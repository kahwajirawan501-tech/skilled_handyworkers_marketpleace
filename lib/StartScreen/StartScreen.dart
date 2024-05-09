import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AspectRatio(
        aspectRatio: 16 / 9, // تنسيق الفيديو
        child: VideoPlayer(//hi rory
          VideoPlayerController.asset('assets/video/start_video.mp4'), // استخدام ملف الفيديو من الموارد
        ),
      ),
    );
  }
}
