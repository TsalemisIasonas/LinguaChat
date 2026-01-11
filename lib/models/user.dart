import 'package:lingua_chat/constants/types.dart';

/// This object contains the information about the current user logged in.
LinguaUser currentUser = LinguaUser(
  email: '',
  username: '',
  level: UserLevel.beginner,
  language: Language.english,
  streak: 0,
  profilePicturePath: null,
  locationCity: null,
  score: 0,
  totalMessages: 0,
  messagesWithCorrections: 0,
  lessonsStarted: 0,
);

/// The model of the data contained in the database about the user.
class LinguaUser {
  String email;
  String username;

  UserLevel level;
  Language language;

  String? profilePicturePath;

  String? locationCity;
  int streak;
  int score;
  int totalMessages;
  int messagesWithCorrections;
  int lessonsStarted;

  LinguaUser({
    required this.email,
    required this.username,
    required this.level,
    required this.language,
    required this.streak,
    required this.score,
    required this.totalMessages,
    required this.messagesWithCorrections,
    required this.lessonsStarted,

    this.profilePicturePath,
    this.locationCity,
  });
  
  /// Calculate accuracy percentage
  double get accuracyPercentage {
    if (totalMessages == 0) return 0.0;
    return ((totalMessages/2 - messagesWithCorrections) / (totalMessages/2) * 100);
  }

  /// Convert a User object into a Map for Firestore (writing data)
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'username': username,
      'level': level.name,
      'language': language.label,
      'streak': streak,
      'profilePicturePath': profilePicturePath,
      'locationCity': locationCity,
      'score': score,
      'totalMessages': totalMessages,
      'messagesWithCorrections': messagesWithCorrections,
      'lessonsStarted': lessonsStarted,
    };
  }

  /// Create a User object from a Map from Firestore (reading data)
  factory LinguaUser.fromFirestore(Map<String, dynamic> firestoreData) {
    return LinguaUser(
      email: firestoreData['email'],
      username: firestoreData['username'],
      level: UserLevel.values.byName(firestoreData['level']),
      language: Language.fromString(firestoreData['language']),
      streak: firestoreData['streak'],
      profilePicturePath: firestoreData['profilePicturePath'] as String?,
      locationCity: firestoreData['locationCity'],
      score: firestoreData['score'],
      totalMessages: firestoreData['totalMessages'] ?? 0,
      messagesWithCorrections: firestoreData['messagesWithCorrections'] ?? 0,
      lessonsStarted: firestoreData['lessonsStarted'] ?? 0,
    );
  }
}
