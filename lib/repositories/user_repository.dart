import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:lingua_chat/constants/types.dart';
import 'package:lingua_chat/models/user.dart';

/// The main entry point for database functionality.
class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Function to create or update a user in the database from a LinguaUser object.
  Future<void> addOrUpdateUser(LinguaUser user) async {
    final userDocRef = _db.collection('users').doc(user.email);

    try {
      await userDocRef.set(user.toJson());
    } catch (e) {
      print("Error adding user: $e");
    }
  }

  /// Retrieves User data from the database in a LinguaUser object.
  Future<LinguaUser> getUser(String email) async {
    try {
      DocumentSnapshot doc = await _db.collection('users').doc(email).get();

      if (doc.exists && doc.data() != null) {
        return LinguaUser.fromFirestore(doc.data() as Map<String, dynamic>);
      } else {
        throw Exception;
      }
    } catch (e) {
      print("Error getting user: $e");
      throw Exception;
    }
  }

  /// Function meant to be used to create a user who registers for the first time.
  /// It constructs a user with default values for the app in the Database.
  void createDefaultUser(String newUserEmail) {
    LinguaUser newUser = LinguaUser(
      email: newUserEmail,
      username: newUserEmail.split('@').first, // get username
      level: UserLevel.beginner,
      language: Language.english,
      streak: 0,
      score: 0,
    );

    addOrUpdateUser(newUser);

    currentUser = newUser;
  }

  Stream<List<LinguaUser>> streamCityLeaderboard(String? city) {
    return FirebaseFirestore.instance
        .collection('users')
        .where('locationCity', isEqualTo: city)
        .orderBy('score', descending: true)
        .snapshots()
        .map((snap) {
          return snap.docs.map((doc) {
            return LinguaUser.fromFirestore(doc.data());
          }).toList();
        });
  }
}
