import 'package:flutter/material.dart';
import 'package:tiktok_clone/features/videos/widgets/video_post.dart';

class VideoTimelineScreen extends StatefulWidget {
  const VideoTimelineScreen({Key? key}) : super(key: key);

  @override
  State<VideoTimelineScreen> createState() => _VideoTimelineScreenState();
}

class _VideoTimelineScreenState extends State<VideoTimelineScreen> {
  final PageController pageController = PageController();
  final Duration scrollDuration = const Duration(milliseconds: 250);
  final Curve scrollCurve = Curves.linear;

  List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.teal,
    Colors.yellow,
  ];

  void onPageChanged(int page) {
    pageController.animateToPage(page, duration: scrollDuration, curve: scrollCurve);
    if (page == colors.length - 1) {
      colors.addAll([
        Colors.blue,
        Colors.red,
        Colors.teal,
        Colors.yellow,
      ]);
      setState(() {});
    }
  }

  void onVideoFinished() {
    return;
    // pageController.nextPage(duration: scrollDuration, curve: scrollCurve);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  Future<void> onRefresh() {
    return Future.delayed(
      const Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      displacement: 0,
      edgeOffset: 100,
      color: Colors.black,
      onRefresh: onRefresh,
      child: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: pageController,
        onPageChanged: onPageChanged,
        itemCount: colors.length,
        itemBuilder: (context, index) => VideoPost(
          onVideoFinished: onVideoFinished,
          index: index,
          description: "가나다라마바사아자차카타파하 가나다라마바사아자차카타파하 가나다라마바사아자차카타파하 가나다라마바사아자차카타파하",
        ),
      ),
    );
  }
}
