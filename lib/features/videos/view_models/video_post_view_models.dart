import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/authentication/repositories/authentication_repo.dart';
import 'package:tiktok_clone/features/videos/repositories/videos_repo.dart';

class VideoPostViewModel extends FamilyAsyncNotifier<void, String> {
  late final VideosRepository _repository;
  late final String _videoId;

  @override
  FutureOr<void> build(String videoId) {
    _repository = ref.watch(videosRepo);
    _videoId = videoId;
  }

  Future<void> likeVideo() async {
    final user = ref.read(authRepo).user;
    await _repository.likeVideo(_videoId, user!.uid);
  }
}

final videoPostProvider = AsyncNotifierProvider.family<VideoPostViewModel, void, String>(
  () => VideoPostViewModel(),
);
