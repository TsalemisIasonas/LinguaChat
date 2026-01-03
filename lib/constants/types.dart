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

/// All the available languages you can learn in the app
enum Languages { greek, english, german, french, italian }

//codes for text to speech
enum TTSLanguageCode {
  greek('el-GR'),
  english('en-US'),
  german('de-DE'),
  french('fr-FR'),
  italian('it-IT');

  final String code;
  const TTSLanguageCode(this.code);
}
