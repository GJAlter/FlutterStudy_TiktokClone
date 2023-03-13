import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';
import 'package:tiktok_clone/features/videos/video_preview_screen.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({Key? key}) : super(key: key);

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen> with TickerProviderStateMixin, WidgetsBindingObserver {
  late final AnimationController _recordingButtonAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 100),
  );
  late final AnimationController _recordingProgressAnimationController = AnimationController(
    vsync: this,
    duration: const Duration(seconds: 10),
    lowerBound: 0.0,
    upperBound: 1.0,
  );
  late final Animation<double> _recordingButtonAnimation = Tween(begin: 1.0, end: 1.3).animate(_recordingButtonAnimationController);
  late final double _maxZoomLevel, _minZoomLevel;

  late CameraController _cameraController;

  bool _isGrantedPermissions = false;
  bool _isSelfieMode = false;
  int _currentFlashMode = 0;
  double _dragStartPosition = 0.0;
  double _currentZoomLevel = 1.0, _tempZoomLevel = 0.0;

  final List<FlashMode> _flashModes = [
    FlashMode.off,
    FlashMode.always,
    FlashMode.auto,
    FlashMode.torch,
  ];

  final List<IconData> _flashModeIcons = [
    Icons.flash_off_rounded,
    Icons.flash_on_rounded,
    Icons.flash_auto_rounded,
    Icons.flashlight_on_rounded,
  ];

  Future<void> initPermissions() async {
    final cameraPermission = await Permission.camera.request();
    final micPermission = await Permission.microphone.request();
    final cameraDenied = cameraPermission.isDenied || cameraPermission.isPermanentlyDenied;
    final micDenied = micPermission.isDenied || micPermission.isPermanentlyDenied;

    if (!cameraDenied && !micDenied) {
      await initCamera();
      setState(() {
        _isGrantedPermissions = true;
      });
    }
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return;
    _cameraController = CameraController(cameras[_isSelfieMode ? 1 : 0], ResolutionPreset.max);

    await _cameraController.initialize();
    await _cameraController.prepareForVideoRecording();
    _currentFlashMode = _flashModes.indexOf(_cameraController.value.flashMode);
    _maxZoomLevel = await _cameraController.getMaxZoomLevel();
    _minZoomLevel = await _cameraController.getMinZoomLevel();

    setState(() {});
  }

  Future<void> _changeCameraMode() async {
    _isSelfieMode = !_isSelfieMode;
    await initCamera();
  }

  Future<void> _changeFlashMode() async {
    if (_currentFlashMode == _flashModes.length - 1) {
      _currentFlashMode = 0;
    } else {
      _currentFlashMode++;
    }
    await _cameraController.setFlashMode(_flashModes[_currentFlashMode]);
    setState(() {});
  }

  Future<void> _startRecording(TapDownDetails _) async {
    if (_cameraController.value.isRecordingVideo) return;

    return;

    await _cameraController.startVideoRecording();
    _recordingButtonAnimationController.forward();
    _recordingProgressAnimationController.forward();
  }

  Future<void> _stopRecording() async {
    if (!_cameraController.value.isRecordingVideo) return;

    _recordingButtonAnimationController.reverse();
    _recordingProgressAnimationController.reset();

    final video = await _cameraController.stopVideoRecording();

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isFromGallery: false,
        ),
      ),
    );
  }

  Future<void> _onSelectVideo() async {
    final video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (video == null) return;

    if (!mounted) return;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VideoPreviewScreen(
          video: video,
          isFromGallery: true,
        ),
      ),
    );
  }

  void zoom(DragUpdateDetails details) {
    if (_dragStartPosition == 0.0) {
      _dragStartPosition = details.globalPosition.dx;
    }
    final currentPosition = details.globalPosition.dx;
    final displayWidth = MediaQuery.of(context).size.width - 60;
    if ((_dragStartPosition - currentPosition).abs() <= 10) return;
    if (currentPosition > MediaQuery.of(context).size.width - 40) return;

    if (_dragStartPosition < currentPosition) {
      final movableRange = displayWidth - _dragStartPosition + 10;
      final movableLevel = (movableRange / 10).floor();
      final zoomPer10 = (_maxZoomLevel - _currentZoomLevel) / movableLevel;
      final newZoomLevel = ((currentPosition - _dragStartPosition + 10) / 10).floor() * zoomPer10;
      if (newZoomLevel <= _maxZoomLevel) {
        _cameraController.setZoomLevel(newZoomLevel);
        _tempZoomLevel = newZoomLevel;
      }
    }
  }

  void resetDragPosition(DragEndDetails _) {
    _dragStartPosition = 0.0;
    _currentZoomLevel = _tempZoomLevel;
    _tempZoomLevel = 0.0;
  }

  @override
  void initState() {
    super.initState();
    initPermissions();
    WidgetsBinding.instance.addObserver(this);
    _recordingProgressAnimationController.addListener(() {
      setState(() {});
    });
    _recordingProgressAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _stopRecording();
      }
    });
  }

  @override
  void dispose() {
    _recordingButtonAnimationController.dispose();
    _recordingProgressAnimationController.dispose();
    _cameraController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_isGrantedPermissions) return;
    if (state == AppLifecycleState.inactive && _cameraController.value.isInitialized) {
      _cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      initCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: !_isGrantedPermissions || !_cameraController.value.isInitialized
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    "Initializing...",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Sizes.size20,
                    ),
                  ),
                  Gaps.v20,
                  CircularProgressIndicator.adaptive(),
                ],
              )
            : Stack(
                alignment: Alignment.center,
                children: [
                  CameraPreview(_cameraController),
                  Positioned(
                    top: Sizes.size28,
                    right: 0,
                    child: Column(
                      children: [
                        IconButton(
                          color: Colors.white,
                          onPressed: _changeCameraMode,
                          icon: const Icon(
                            Icons.cameraswitch,
                          ),
                        ),
                        Gaps.v10,
                        IconButton(
                          color: _flashModes[_currentFlashMode] == FlashMode.off ? Colors.white : Colors.amber.shade200,
                          onPressed: _changeFlashMode,
                          icon: Icon(
                            _flashModeIcons[_currentFlashMode],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: Sizes.size40,
                    width: MediaQuery.of(context).size.width,
                    child: ScaleTransition(
                      scale: _recordingButtonAnimation,
                      child: Row(
                        children: [
                          const Spacer(),
                          GestureDetector(
                            onTapDown: _startRecording,
                            onPanUpdate: zoom,
                            onPanEnd: resetDragPosition,
                            onTapUp: (details) => _stopRecording(),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: Sizes.size72 + Sizes.size10,
                                  height: Sizes.size72 + Sizes.size10,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: Sizes.size4,
                                    value: _recordingProgressAnimationController.value,
                                  ),
                                ),
                                Container(
                                  width: Sizes.size72,
                                  height: Sizes.size72,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.red.shade400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Container(
                              alignment: Alignment.center,
                              child: IconButton(
                                onPressed: _onSelectVideo,
                                icon: FaIcon(
                                  FontAwesomeIcons.image,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
