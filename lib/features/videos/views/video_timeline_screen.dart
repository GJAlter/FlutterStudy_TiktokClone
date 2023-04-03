import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/view_models/timeline_view_model.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_post.dart';

class VideoTimelineScreen extends ConsumerStatefulWidget {
  const VideoTimelineScreen({Key? key}) : super(key: key);

  @override
  VideoTimelineScreenState createState() => VideoTimelineScreenState();
}

class VideoTimelineScreenState extends ConsumerState<VideoTimelineScreen> {
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
    return ref.watch(timelineProvider).when(
        loading: () => Center(
              child: CircularProgressIndicator(),
            ),
        error: (error, stackTrace) => Center(
              child: Text("Could not load videos: $error"),
            ),
        data: (videos) => RefreshIndicator(
              displacement: 0,
              edgeOffset: 100,
              color: Colors.black,
              onRefresh: onRefresh,
              child: PageView.builder(
                scrollDirection: Axis.vertical,
                controller: pageController,
                onPageChanged: onPageChanged,
                itemCount: videos.length,
                itemBuilder: (context, index) => VideoPost(
                  onVideoFinished: onVideoFinished,
                  index: index,
                  description: videos[0].title,
                ),
              ),
            ));
  }
}
