import 'package:club/models/club.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ClubHome extends StatelessWidget {
  const ClubHome({
    super.key,
    required this.club,
  });

  final Club club;

  @override
  Widget build(BuildContext context) {
    Future<void> removeClub(Club club) async {
      DocumentReference document = FirebaseFirestore.instance.collection('clubs').doc(club.name);

      try {
        await document.delete();
      } catch (e) {
        print("Failed to delete club: $e");
      }
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(club.name),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        // child: ListView.builder(itemBuilder: (context, index) {}),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                removeClub(club);
                Navigator.of(context).pop();
              },
              child: const Text("Remove Club"),
            )
          ]
        )
      ),
    );
  }
}
