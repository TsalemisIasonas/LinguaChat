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
  english(label: 'English', ttsCode: 'en-US'),
  french(label: 'French', ttsCode: 'fr-FR'),
  german(label: 'German', ttsCode: 'de-DE'),
  greek(label: 'Greek', ttsCode: 'el-GR'),
  italian(label: 'Italian', ttsCode: 'it-IT');

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
