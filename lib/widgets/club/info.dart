import 'package:club/models/club.dart';
import 'package:club/providers/available_clubs.dart';
import 'package:club/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ClubInfo extends ConsumerWidget {
  const ClubInfo({
    super.key,
    required this.club,
  });

  final Club club;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final availableClubs = ref.read(availableClubsProvider.notifier);
    final usersClubs = ref.read(userProvider.notifier);

    Future<void> addClub(Club club) async {
      final CollectionReference userRef = FirebaseFirestore.instance.collection('users');
      //await userRef.doc('Nathan DeVries').collection('clubs').add(club.toMap());
      CollectionReference clubs = FirebaseFirestore.instance.collection('clubs');
    
      try {
        await clubs.add(club.toMap());
      } catch (e) {
        print("Failed to add club: $e");
      }
    }

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
                addClub(club);
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
