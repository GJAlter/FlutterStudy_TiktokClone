import 'package:shared_preferences/shared_preferences.dart';

class PlaybackConfigRepository {
  static const String muted = "muted";
  static const String autoPlay = "autoPlay";

  final SharedPreferences _preferences;

  PlaybackConfigRepository(this._preferences);

  Future<void> setMuted(bool value) async {
    _preferences.setBool(muted, value);
  }

  Future<void> setAutoPlay(bool value) async {
    _preferences.setBool(autoPlay, value);
  }

  bool isMuted() {
    return _preferences.getBool(muted) ?? false;
  }

  bool isAutoPlay() {
    return _preferences.getBool(autoPlay) ?? false;
  }
}
