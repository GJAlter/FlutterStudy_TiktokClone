import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tiktok_clone/features/videos/models/playback_config_model.dart';
import 'package:tiktok_clone/features/videos/repositories/playback_config_repo.dart';

class PlaybackConfigViewModel extends Notifier<PlaybackConfigModel> {
  final PlaybackConfigRepository _repository;

  PlaybackConfigViewModel(this._repository);

  void setMuted(bool value) {
    _repository.setMuted(value);
    state = PlaybackConfigModel(
      isMuted: value,
      isAutoPlay: state.isAutoPlay,
    );
  }

  void setAutoPlay(bool value) {
    _repository.setAutoPlay(value);
    state = PlaybackConfigModel(
      isMuted: state.isMuted,
      isAutoPlay: value,
    );
  }

  @override
  PlaybackConfigModel build() {
    return PlaybackConfigModel(
      isMuted: _repository.isMuted(),
      isAutoPlay: _repository.isAutoPlay(),
    );
  }
}

final playbackConfigProvider = NotifierProvider<PlaybackConfigViewModel, PlaybackConfigModel>(
  () => throw UnimplementedError(),
);
