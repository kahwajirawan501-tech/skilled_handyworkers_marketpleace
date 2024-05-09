import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("data",style: TextStyle(fontSize: 600),),
      // child: AspectRatio(
      //   aspectRatio: 16 / 9, // تنسيق الفيديو
      //   child: VideoPlayer(
      //     VideoPlayerController.asset('assets/video/start_video.mp4'), // استخدام ملف الفيديو من الموارد
      // ),
      //),
    );
  }
}
