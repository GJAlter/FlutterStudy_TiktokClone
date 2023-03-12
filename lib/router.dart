import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/videos/video_recording.screen.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const VideoRecordingScreen(),
    )
  ],
);
