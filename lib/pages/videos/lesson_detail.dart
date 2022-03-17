import 'package:e_learning/globals_methods.dart';
import 'package:e_learning/globals_variables.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LessonDetail extends StatefulWidget {

  const LessonDetail({Key? key}) : super(key: key);

  @override
  _LessonDetailState createState() => _LessonDetailState();
}

class _LessonDetailState extends State<LessonDetail> {

  late VideoPlayerController _controller;
  String videoUrl = 'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4';
  Rx<Duration> videoTime = const Duration(seconds: 0).obs;
  Rx<Duration> currentPosition = const Duration(seconds: 0).obs;
  Rx<bool> isFullScreen = false.obs;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(videoUrl,)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        videoTime.value = _controller.value.duration;
        _controller.play();
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
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () {
          return Column(
            children: [
              topPadding(context),
              Container(
                margin: const EdgeInsets.all(10),
                child: Stack(
                  children: [
                    StandardVideoPlayer(controller: _controller),
                    videoPlayerControlPanel(),
                  ],
                ),
              ),
              Text(currentPosition.value.inSeconds.toString()+' / '+videoTime.string.split('.')[0]),
              ElevatedButton(onPressed: () {
                push(context, FullScreenMode(controller: _controller));
                // onClickFullScreen();
              }, child: Text('Full Screen')),
              ElevatedButton(onPressed: () {
                _controller.play();
              }, child: Text('Start')),
              ElevatedButton(onPressed: () {
                _controller.pause();
              }, child: Text('Pause')),
            ],
          );
        },
      ),
    );
  }
  //
  // void onClickFullScreen(){
  //   showDialog(context: context, builder: (BuildContext context){
  //     return Container(
  //       width: double.infinity,
  //       height: double.infinity,
  //       child: RotatedBox(
  //           quarterTurns: 1,
  //           child: videoPlayer()
  //       ),
  //     );
  //   });
  // }



  Widget videoPlayerControlPanel(){
    return Text(currentPosition.value.inSeconds.toString(),style: const TextStyle(color: Colors.white),);
  }

}


class StandardVideoPlayer extends StatelessWidget {

  final VideoPlayerController controller;
  const StandardVideoPlayer({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: controller.value.isInitialized ?
      AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: VideoPlayer(controller,),
      )
          : Container(),
    );
  }
}


class FullScreenMode extends StatelessWidget {

  final VideoPlayerController controller;
  const FullScreenMode({Key? key, required this.controller}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    return WillPopScope(
      onWillPop: () async{
        SystemChrome.setEnabledSystemUIMode(
          SystemUiMode.manual,
          overlays: [
            SystemUiOverlay.top,SystemUiOverlay.bottom
          ]
        );
        pop(context);
        return false;
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: RotatedBox(
            quarterTurns: 1,
            child: StandardVideoPlayer(controller: controller,)
        ),
      ),
    );
  }
}
