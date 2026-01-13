/// Enum used in order to indicate to existing app screens
enum AppScreen {
  profile,
  home,
  scoreboard,
  login,
  register,
  chat,
  talk,
  settings,
}

/// All the available user experience level on learning a language
enum UserLevel { beginner, intermediate, advanced }

/// Represents the languages available in the app, along with associated
/// metadata such as the display label and Text-to-Speech (TTS) code.
///
/// Each enum value contains:
/// - [label]: the human-readable name of the language.
/// - [ttsCode]: the language code
enum Language {
  chinese(label: 'Chinese', ttsCode: 'zh-CN'),
  dutch(label: 'Dutch', ttsCode: 'nl-NL'),
  english(label: 'English', ttsCode: 'en-US'),
  french(label: 'French', ttsCode: 'fr-FR'),
  german(label: 'German', ttsCode: 'de-DE'),
  hindi(label: 'Hindi', ttsCode: 'hi-IN'),
  italian(label: 'Italian', ttsCode: 'it-IT'),
  japanese(label: 'Japanese', ttsCode: 'ja-JP'),
  korean(label: 'Korean', ttsCode: 'ko-KR'),
  portuguese(label: 'Portuguese', ttsCode: 'pt-BR'),
  russian(label: 'Russian', ttsCode: 'ru-RU'),
  spanish(label: 'Spanish', ttsCode: 'es-ES'),
  turkish(label: 'Turkish', ttsCode: 'tr-TR'),
  vietnamese(label: 'Vietnamese', ttsCode: 'vi-VN');

  final String label;
  final String ttsCode;

  const Language({required this.label, required this.ttsCode});

  static Language fromString(String label) {
    return Language.values.firstWhere(
      (l) => l.label == label,
      orElse: () => Language.english, // safe default
    );
  }
}
