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
  late final CameraController _cameraController;

  bool _isGrantedPermissions = false;

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
    _cameraController = CameraController(cameras[1], ResolutionPreset.ultraHigh);

    await _cameraController.initialize();
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
              ],
            ),
    ));
  }
}
