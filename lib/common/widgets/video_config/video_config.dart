import 'package:flutter/widgets.dart';

class VideoConfig extends ChangeNotifier {
  bool autoMute = true;

  void setAutoMute(bool value) {
    autoMute = value;
    notifyListeners();
  }
}

final videoConfig = VideoConfig();
