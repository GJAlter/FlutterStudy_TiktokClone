import 'package:flutter/widgets.dart';
import 'package:tiktok_clone/features/videos/models/playback_config_model.dart';
import 'package:tiktok_clone/features/videos/repositories/playback_config_repo.dart';

class PlaybackConfigViewModel extends ChangeNotifier {
  final PlaybackConfigRepository _repository;

  late final PlaybackConfigModel _model = PlaybackConfigModel(
    isMuted: _repository.isMuted(),
    isAutoPlay: _repository.isAutoPlay(),
  );

  PlaybackConfigViewModel(this._repository);

  bool get isMuted => _model.isMuted;
  bool get isAutoPlay => _model.isAutoPlay;

  void setMuted(bool value) {
    _repository.setMuted(value);
    _model.isMuted = value;
    notifyListeners();
  }

  void setAutoPlay(bool value) {
    _repository.setAutoPlay(value);
    _model.isAutoPlay = value;
    notifyListeners();
  }
}
