import 'package:flutter/widgets.dart';

class VideoConfigData extends InheritedWidget {
  final bool autoMuted;
  final void Function() toggleMuted;
  const VideoConfigData({
    super.key,
    required super.child,
    required this.autoMuted,
    required this.toggleMuted,
  });

  static VideoConfigData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<VideoConfigData>()!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}

class VideoConfig extends StatefulWidget {
  final Widget child;
  const VideoConfig({Key? key, required this.child}) : super(key: key);

  @override
  State<VideoConfig> createState() => _VideoConfigState();
}

class _VideoConfigState extends State<VideoConfig> {
  bool autoMute = false;

  void toggleMuted() {
    setState(() {
      autoMute = !autoMute;
    });
  }

  @override
  Widget build(BuildContext context) {
    return VideoConfigData(
      child: widget.child,
      autoMuted: autoMute,
      toggleMuted: toggleMuted,
    );
  }
}
