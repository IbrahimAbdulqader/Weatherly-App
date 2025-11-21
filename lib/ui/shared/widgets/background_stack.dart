import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';

class BackgroundStack extends StatefulWidget {
  const BackgroundStack({
    super.key,
    required this.index,
    required this.videoPath,
    required this.child,
  });
  final int index;
  final String videoPath;
  final Widget child;

  @override
  State<BackgroundStack> createState() => _BackgroundStackState();
}

ScrollController backgroundScrollController = ScrollController();

class _BackgroundStackState extends State<BackgroundStack> {
  late VideoPlayerController videoPlayerController;

  @override
  void initState() {
    super.initState();
    playVideo();
  }

  void playVideo() {
    videoPlayerController =
        VideoPlayerController.asset(widget.videoPath)
          ..setLooping(true)
          ..initialize().then((_) {
            videoPlayerController.play();
            if (mounted) setState(() {});
          });
  }

  @override
  void didUpdateWidget(covariant BackgroundStack oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.videoPath != widget.videoPath) {
      updateVideo(widget.videoPath);
    }
  }

  Future<void> updateVideo(String newPath) async {
    if (videoPlayerController.dataSource == newPath) return;

    final oldController = videoPlayerController;
    final newController = VideoPlayerController.asset(newPath)
      ..setLooping(true);

    await newController.initialize();
    await newController.play();

    setState(() {
      videoPlayerController = newController;
    });
    await Future.delayed(const Duration(milliseconds: 300));
    await oldController.dispose();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  String currentScreen = 'home';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: 0,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1.16,
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: SizedBox(
                  key: ValueKey(videoPlayerController.dataSource),
                  width: 1080.w,
                  height: 2800.h,
                  child: VideoPlayer(videoPlayerController),
                ),
              ),
            ),
          ),
        ),
        Container(
          width: double.infinity,
          height: 130.h,
          decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 50.r)],
          ),
        ),
        widget.child,
      ],
    );
  }
}
