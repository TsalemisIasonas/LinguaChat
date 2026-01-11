import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:lingua_chat/models/user.dart';
import 'package:lingua_chat/repositories/user_repository.dart';
import 'package:lingua_chat/services/location.dart';
import 'package:lingua_chat/services/sound_service.dart';

class LeaderboardWidget extends StatefulWidget {
  const LeaderboardWidget({super.key});

  @override
  State<LeaderboardWidget> createState() => _LeaderboardWidgetState();
}

class _LeaderboardWidgetState extends State<LeaderboardWidget> {
  @override
  void initState() {
    super.initState();
    _loadCity();
  }

  Future<void> _loadCity() async {
    final city = await LocationService().getCity();

    if (!mounted) return;

    setState(() {
      currentUser.locationCity = city;
      UserRepository().addOrUpdateUser(currentUser);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (currentUser.locationCity == null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.location_off, size: 40),
            const SizedBox(height: 12),
            const Text(
              'Please enable location to view your leaderboard',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                AppSound.click.play();
                Geolocator.openLocationSettings();
              },
              child: const Text('Open settings'),
            ),
          ],
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: StreamBuilder(
        stream: UserRepository().streamCityLeaderboard(
          currentUser.locationCity,
        ),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(
                semanticsLabel: 'Loading Leaderboard',
              ),
            );
          }

          final usersList = snapshot.data!;

          return ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Top learners in ${currentUser.locationCity}',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),

              ...List.generate(usersList.length, (index) {
                final user = usersList[index];
                final rank = index + 1;

                if (currentUser.email == user.email) {
                  currentUser.rank = rank;
                }

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      Text(
                        rank.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 16),

                      CircleAvatar(
                        radius: 26,
                        backgroundImage: user.profilePicturePath != null
                            ? AssetImage(user.profilePicturePath!)
                            : null,
                        child: user.profilePicturePath == null
                            ? const Icon(Icons.person)
                            : null,
                      ),

                      const SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.username,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              'Score: ${user.score}',
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
