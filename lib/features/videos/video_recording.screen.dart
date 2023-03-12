import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tiktok_clone/constants/gaps.dart';
import 'package:tiktok_clone/constants/sizes.dart';

class VideoRecordingScreen extends StatefulWidget {
  const VideoRecordingScreen({Key? key}) : super(key: key);

  @override
  State<VideoRecordingScreen> createState() => _VideoRecordingScreenState();
}

class _VideoRecordingScreenState extends State<VideoRecordingScreen> {
  late CameraController _cameraController;

  bool _isGrantedPermissions = false;
  bool _isSelfieMode = false;
  int _currentFlashMode = 0;

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
      setState(() {
        _isGrantedPermissions = true;
        initCamera();
      });
    }
  }

  Future<void> initCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) return;
    _cameraController = CameraController(cameras[_isSelfieMode ? 1 : 0], ResolutionPreset.max);

    await _cameraController.initialize();
    _currentFlashMode = _flashModes.indexOf(_cameraController.value.flashMode);
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

  @override
  void initState() {
    super.initState();
    initPermissions();
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
                ],
              ),
      ),
    );
  }
}
