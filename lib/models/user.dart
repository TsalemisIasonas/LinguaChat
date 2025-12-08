import 'package:lingua_chat/constants/types.dart';

/// This object contains the information about the current user logged in.
LinguaUser currentUser = LinguaUser(
  email: '',
  username: '',
  level: UserLevel.beginner,
  language: Languages.english,
  streak: 0,
  profilePicturePath: null,
  locationCity: null,
  score: 0,
);

/// The model of the data contained in the database about the user.
class LinguaUser {
  String email;
  String username;

  UserLevel level;
  Languages language;

  String? profilePicturePath;

  String? locationCity;
  int streak;
  int score;

  LinguaUser({
    required this.email,
    required this.username,
    required this.level,
    required this.language,
    required this.streak,
    required this.score,

    this.profilePicturePath,
    this.locationCity,
  });

  /// Convert a User object into a Map for Firestore (writing data)
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': username,
      'level': level.name,
      'language': language.name,
      'streak': streak,
      'profilePicturePath': profilePicturePath,
      'locationCity': locationCity,
      'score': score,
    };
  }

  /// Create a User object from a Map from Firestore (reading data)
  factory LinguaUser.fromFirestore(Map<String, dynamic> firestoreData) {
    return LinguaUser(
      email: firestoreData['email'],
      username: firestoreData['username'],
      level: UserLevel.values.byName(firestoreData['level']),
      language: Languages.values.byName(firestoreData['language']),
      streak: firestoreData['streak'],
      profilePicturePath: firestoreData['profilePicturePath'] as String?,
      locationCity: firestoreData['locationCity'],
      score: firestoreData['score'],
    );
  }
}
