import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SettingPage extends StatefulWidget {

  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  late VideoPlayerController _controller;
  Rx<Duration> videoTime = const Duration(seconds: 0).obs;
  Rx<Duration> currentPosition = const Duration(seconds: 0).obs;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network('https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        videoTime.value = _controller.value.duration;
        setState(() {});
      });
    _controller.addListener(() {
      currentPosition.value = _controller.value.position;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    print('ee');
  }

  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('gg');
    setState(() {  print(state); });
  }




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Video Demo',
      home: Scaffold(
        body: Obx(
          () {
            return Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Stack(
                    children: [
                      videoPlayer(),
                      videoPlayerControlPanel(),
                    ],
                  ),
                )
              ],
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Duration _duration = _controller.value.duration;
            print(_duration.inSeconds);
            setState(() {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            });
            print(_controller.position.toString());
          },
          child: Icon(
            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
          ),
        ),
      ),
    );
  }

  Widget videoPlayer(){
    return _controller.value.isInitialized
        ? AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    )
        : Container();
  }

  Widget videoPlayerControlPanel(){
    return Text(currentPosition.value.inSeconds.toString(),style: const TextStyle(color: Colors.white),);
  }


}