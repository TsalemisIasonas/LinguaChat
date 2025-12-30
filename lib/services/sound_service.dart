import 'package:audioplayers/audioplayers.dart';

enum AppSound { click, error, intro }

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

  static const Map<AppSound, String> _paths = {
    AppSound.click: 'sounds/pop-sound.mp3',
    AppSound.error: 'sounds/error.mp3',
    AppSound.intro: 'sounds/intro.mp3',
  };

  Future<void> play(AppSound sound) async {
    if (!_enabled) return;

    final path = _paths[sound];
    if (path == null) return;
    await _player.play(AssetSource(path));
  }
}

extension AppSoundPlayer on AppSound {
  Future<void> play() {
    return SoundService().play(this);
  }
}
