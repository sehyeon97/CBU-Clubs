import 'package:club/models/club.dart';
import 'package:club/providers/available_clubs.dart';
import 'package:club/providers/users_clubs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClubInfo extends ConsumerWidget {
  const ClubInfo({
    super.key,
    required this.club,
  });

  final Club club;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final availableClubs = ref.read(availableClubsProvider.notifier);
    final usersClubs = ref.read(userClubsProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(club.name),
      ),
      body: Column(
        children: [
          Text(club.description),
          Text(club.president),
          Text(club.advisor),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                usersClubs.addClub(club);
                availableClubs.removeClub(club);
                Navigator.of(context).pop();
              },
              child: const Text("Join Now"))
        ],
      ),
    );
  }
}
