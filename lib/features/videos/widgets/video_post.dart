import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends StatefulWidget {
  final Function onVideoFinished;
  final int index;

  const VideoPost({Key? key, required this.onVideoFinished, required this.index}) : super(key: key);

  @override
  State<VideoPost> createState() => _VideoPostState();
}

class _VideoPostState extends State<VideoPost> with SingleTickerProviderStateMixin {
  final VideoPlayerController videoPlayerController = VideoPlayerController.asset("assets/videos/video4.mp4");
  final animationDuration = const Duration(milliseconds: 200);

  late final AnimationController animationController;

  bool isPaused = false;

  void onVideoChange() {
    if (!videoPlayerController.value.isInitialized) {
      return;
    }
    if (videoPlayerController.value.duration == videoPlayerController.value.position) {
      widget.onVideoFinished();
    }
  }

  void initVideoPlayer() async {
    await videoPlayerController.initialize();
    videoPlayerController.addListener(onVideoChange);
    setState(() {});
  }

  void initAnimationController() {
    animationController = AnimationController(
      vsync: this,
      lowerBound: 1.0,
      upperBound: 1.5,
      value: 1.5,
      duration: animationDuration,
    );
    animationController.addListener(() {
      setState(() {});
    });
  }

  void onVisibilityChanged(VisibilityInfo info) {
    if (info.visibleFraction == 1 && !videoPlayerController.value.isPlaying) {
      videoPlayerController.play();
    }
  }

  void onPauseTap() {
    if (videoPlayerController.value.isPlaying) {
      videoPlayerController.pause();
      animationController.reverse();
    } else {
      videoPlayerController.play();
      animationController.forward();
    }
    setState(() {
      isPaused = !isPaused;
    });
  }

  @override
  void initState() {
    super.initState();
    initVideoPlayer();
    initAnimationController();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.index.toString()),
      onVisibilityChanged: onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: videoPlayerController.value.isInitialized
                ? VideoPlayer(videoPlayerController)
                : Container(
                    color: Colors.black,
                  ),
          ),
          Positioned.fill(
            child: GestureDetector(
              onTap: onPauseTap,
            ),
          ),
          Positioned.fill(
            child: IgnorePointer(
              child: Center(
                child: Transform.scale(
                  scale: animationController.value,
                  child: AnimatedOpacity(
                    opacity: isPaused ? 1 : 0,
                    duration: animationDuration,
                    child: const FaIcon(
                      FontAwesomeIcons.play,
                      color: Colors.white,
                      size: Sizes.size60,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
