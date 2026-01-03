import 'package:audioplayers/audioplayers.dart';

enum AppSound {
  click('sounds/click.mp3'),
  error('sounds/error.mp3'),
  intro('sounds/intro.mp3'),
  switchSound('sounds/switch.mp3');

  final String path;
  const AppSound(this.path);
}

class SoundService {
  SoundService._internal();

  static final SoundService _instance = SoundService._internal();
  factory SoundService() => _instance;

  final AudioPlayer _player = AudioPlayer();

  bool _enabled = true;

  void setEnabled(bool value) {
    _enabled = value;
  }

  bool get isEnabled => _enabled;

  Future<void> play(AppSound sound) async {
    if (!_enabled) return;

    await _player.play(AssetSource(sound.path));
  }
}

extension AppSoundPlayer on AppSound {
  Future<void> play() {
    return SoundService().play(this);
  }
}
