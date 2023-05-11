import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/features/authentication/repositories/authentication_repo.dart';
import 'package:tiktok_clone/features/user/view_models/users_view_model.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';
import 'package:tiktok_clone/features/videos/repositories/videos_repo.dart';

class UploadVideoViewModel extends AsyncNotifier<void> {
  late final VideosRepository _repository;

  @override
  FutureOr<void> build() {
    _repository = ref.read(videosRepo);
  }

  Future<void> uploadVideo(File video, BuildContext context) async {
    final user = ref.read(authRepo).user;
    final userProfile = ref.read(usersProvider).value;
    if (userProfile != null) {
      state = const AsyncValue.loading();
      state = await AsyncValue.guard(() async {
        final task = await _repository.uploadVideoFile(
          video,
          user!.uid,
        );
        if (task.metadata != null) {
          await _repository.saveVideo(VideoModel(
            id: "",
            title: "From Flutter",
            description: "Hello World!",
            fileUrl: await task.ref.getDownloadURL(),
            thumbnailUrl: "",
            uid: user.uid,
            creator: userProfile.name,
            likes: 0,
            comments: 0,
            createdAt: DateTime.now().millisecondsSinceEpoch,
          ));
          context.pop();
        }
      });
    }
  }
}

final uploadVideoProvider = AsyncNotifierProvider<UploadVideoViewModel, void>(() => UploadVideoViewModel());
