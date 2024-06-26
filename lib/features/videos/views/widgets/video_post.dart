import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/models/video_model.dart';
import 'package:tiktok_clone/features/videos/view_models/palyback_config_vm.dart';
import 'package:tiktok_clone/features/videos/view_models/video_post_view_models.dart';
import 'package:tiktok_clone/features/videos/views/video_comment_screen.dart';
import 'package:tiktok_clone/features/videos/views/widgets/video_button.dart';
import 'package:tiktok_clone/generated/l10n.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPost extends ConsumerStatefulWidget {
  final Function onVideoFinished;
  final int index;
  final String description;
  final VideoModel video;

  const VideoPost({
    Key? key,
    required this.onVideoFinished,
    required this.index,
    required this.description,
    required this.video,
  }) : super(key: key);

  @override
  VideoPostState createState() => VideoPostState();
}

class VideoPostState extends ConsumerState<VideoPost> with SingleTickerProviderStateMixin {
  final VideoPlayerController videoPlayerController = VideoPlayerController.asset("assets/videos/video4.mp4");
  final animationDuration = const Duration(milliseconds: 200);

  late final AnimationController animationController;

  bool isPaused = false;
  bool isSeeMore = false;
  bool isDisposed = false;
  bool _isMuted = false;

  void onVideoChange() {
    if (!videoPlayerController.value.isInitialized) {
      return;
    }
    if (videoPlayerController.value.duration == videoPlayerController.value.position) {
      widget.onVideoFinished();
    }
  }

  void _onLikeTap() {
    ref.read(videoPostProvider(widget.video.id).notifier).likeVideo();
  }

  void initVideoPlayer() async {
    await videoPlayerController.initialize();
    await videoPlayerController.setLooping(true);
    if (kIsWeb) {
      await videoPlayerController.setVolume(0);
    }
    if (ref.read(playbackConfigProvider).isMuted) {
      _isMuted = true;
      await videoPlayerController.setVolume(0);
    }
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
  }

  void onVisibilityChanged(VisibilityInfo info) {
    if (!mounted) return;
    if (info.visibleFraction == 1 && !isPaused && !videoPlayerController.value.isPlaying) {
      if (ref.read(playbackConfigProvider).isAutoPlay) {
        videoPlayerController.play();
      }
    }

    if (videoPlayerController.value.isPlaying && info.visibleFraction == 0 && !isDisposed) {
      onPauseTap();
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

  void onCommentTap() async {
    if (videoPlayerController.value.isPlaying) {
      onPauseTap();
    }
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => const VideoCommentScreen(),
    );

    onPauseTap();
  }

  void onMuteTap() {
    if (_isMuted) {
      videoPlayerController.setVolume(1);
    } else {
      videoPlayerController.setVolume(0);
    }
    setState(() {
      _isMuted = !_isMuted;
    });
  }

  void _onPlaybackConfigChanged() {
    if (!mounted) return;
    if (false) {
      videoPlayerController.setVolume(1);
    } else {
      videoPlayerController.setVolume(0);
    }
  }

  @override
  void initState() {
    super.initState();
    initVideoPlayer();
    initAnimationController();
  }

  @override
  void dispose() {
    isDisposed = true;
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isTextOverflow(String text) {
      if (text.length > 20) {
        return true;
      }
      return false;
    }

    String splitDescription(String text, int line) {
      int textSize = 20;

      if (text.length < textSize) {
        if (line == 0) {
          return text;
        } else {
          return "";
        }
      }

      if (line == 0) {
        return text.substring(0, textSize);
      } else {
        return text.substring(textSize, text.length);
      }
    }

    return VisibilityDetector(
      key: Key(widget.index.toString()),
      onVisibilityChanged: onVisibilityChanged,
      child: Stack(
        children: [
          Positioned.fill(
            child: videoPlayerController.value.isInitialized
                ? VideoPlayer(videoPlayerController)
                : Image.network(
                    widget.video.thumbnailUrl,
                    fit: BoxFit.cover,
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
                child: AnimatedBuilder(
                  animation: animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: animationController.value,
                      child: child,
                    );
                  },
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
          Positioned(
            bottom: 15,
            left: 15,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "@${widget.video.creator}",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: Sizes.size20,
                  ),
                ),
                Gaps.v10,
                Container(
                  child: Text(
                    splitDescription(widget.video.description, 0),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: Sizes.size16,
                    ),
                  ),
                ),
                isTextOverflow(widget.description)
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              splitDescription(widget.description, 1),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: Sizes.size16,
                              ),
                              overflow: isSeeMore ? null : TextOverflow.ellipsis,
                            ),
                          ),
                          Gaps.h28,
                          GestureDetector(
                            onTap: () {
                              isSeeMore = !isSeeMore;
                              setState(() {});
                            },
                            child: Text(
                              isSeeMore ? "닫기" : "더보기",
                              style: const TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 10,
            child: Column(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: Colors.black,
                  foregroundImage: NetworkImage("https://firebasestorage.googleapis.com/v0/b/tiktok-clone-jun.appspot.com/o/"
                      "avatars%2F${widget.video.uid}?alt=media&token=b4cdfab6-62ac-476a-8048-c2f34f535c91"),
                  child: Text(widget.video.creator),
                ),
                Gaps.v24,
                GestureDetector(
                  onTap: _onLikeTap,
                  child: VideoButton(
                    icon: FontAwesomeIcons.solidHeart,
                    text: S.of(context).likeCount(widget.video.likes),
                  ),
                ),
                Gaps.v24,
                VideoButton(
                  icon: FontAwesomeIcons.solidComment,
                  text: S.of(context).commentCount(widget.video.comments),
                  onTap: onCommentTap,
                ),
                Gaps.v24,
                const VideoButton(
                  icon: FontAwesomeIcons.share,
                  text: "Share",
                ),
              ],
            ),
          ),
          Positioned(
            top: Sizes.size48,
            left: Sizes.size20,
            child: GestureDetector(
              onTap: onMuteTap,
              child: FaIcon(
                _isMuted ? FontAwesomeIcons.volumeOff : FontAwesomeIcons.volumeHigh,
                color: Colors.white,
                size: Sizes.size24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
