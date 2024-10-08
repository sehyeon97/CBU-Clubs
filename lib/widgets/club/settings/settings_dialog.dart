import 'package:club/models/club.dart';
import 'package:club/providers/available_clubs.dart';
import 'package:club/providers/user_provider.dart';
import 'package:club/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Settings extends ConsumerWidget {
  const Settings({
    super.key,
    required this.club,
  });

  // todo: change to user-specific club
  final Club club;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final availableClubs = ref.read(availableClubsProvider.notifier);
    final usersClubs = ref.read(userProvider.notifier);

    return AlertDialog(
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person),
          ),
          const Text("Profile"),
          const SizedBox(height: 20),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.leaderboard),
          ),
          const Text("Leaderboard"),
          const SizedBox(height: 20),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
          ),
          const Text("Notifications"),
          const SizedBox(height: 20),
          IconButton(
            onPressed: () {
              availableClubs.addClub(club);
              usersClubs.removeClub(club);
              Navigator.of(context)
                ..pop()
                ..pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const HomeScreen();
                  },
                ),
              );
            },
            icon: const Icon(Icons.door_sliding),
          ),
          const Text("Leave Club"),
        ],
      ),
    );
  }
}
