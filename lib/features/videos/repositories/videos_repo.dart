import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';

class VideosRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  UploadTask uploadVideoFile(File video, String userId) {
    final fileRef = _storage.ref().child("/videos/$userId/${DateTime.now().millisecondsSinceEpoch}");

    return fileRef.putFile(video);
  }

  Future<void> saveVideo(VideoModel data) async {
    await _db.collection("videos").add(data.toJson());
  }

  Future<QuerySnapshot<Map<String, dynamic>>> fetchVideos() {
    return _db
        .collection("videos")
        .orderBy(
          "createdAt",
          descending: true,
        )
        .get();
  }
}

final videosRepo = Provider((ref) => VideosRepository());
