import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewScreen extends StatefulWidget {
  final XFile video;
  final bool isFromGallery;
  const VideoPreviewScreen({Key? key, required this.video, required this.isFromGallery}) : super(key: key);

  @override
  State<VideoPreviewScreen> createState() => _VideoPreviewScreenState();
}

class _VideoPreviewScreenState extends State<VideoPreviewScreen> {
  late final VideoPlayerController _videoPlayerController;

  bool _isSaved = false;

  Future<void> _initVideo() async {
    _videoPlayerController = VideoPlayerController.file(
      File(widget.video.path),
    );

    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(true);
    await _videoPlayerController.play();
    setState(() {});
  }

  Future<void> _saveVideo() async {
    if (_isSaved) return;

    await GallerySaver.saveVideo(
      widget.video.path,
      albumName: "TiktokClone",
    );

    setState(() {
      _isSaved = true;
    });
  }

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Video Preview"),
        actions: [
          if (!widget.isFromGallery)
            IconButton(
              onPressed: _saveVideo,
              icon: FaIcon(
                _isSaved ? FontAwesomeIcons.check : FontAwesomeIcons.download,
              ),
            ),
        ],
      ),
      body: _videoPlayerController.value.isInitialized ? VideoPlayer(_videoPlayerController) : null,
    );
  }
}
