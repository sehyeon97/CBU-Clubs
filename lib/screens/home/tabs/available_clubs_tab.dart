import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final _firebase = FirebaseFirestore.instance;
final String userID = FirebaseAuth.instance.currentUser!.uid;

class AvailableClubs extends StatefulWidget {
  const AvailableClubs({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AvailableClubsState();
  }
}

class _AvailableClubsState extends State<AvailableClubs> {
  @override
  void initState() {
    super.initState();
    _loadClubs();
  }

  Future<void> _loadClubs() async {
    final userData = await _firebase.collection('users').doc(userID).get();

    final List availableClubs = userData.data()!['available_clubs'];

    // user has no available clubs in database (new user)
    if (availableClubs.isEmpty) {
      final List<Map<String, String>> dataForFirestore = [];

      // populate app's club list with clubs in json file
      String response = await rootBundle.loadString('lib/data/output.json');
      final List data = await json.decode(response);

      for (final obj in data) {
        dataForFirestore.add({
          'name': obj['title'],
          'description': obj['description'],
          'president': obj['president'],
          'advisor': obj['advisor'],
        });
      }

      // add the app's club list to user's available clubs in firestore
      await _firebase.collection('users').doc(userID).update({
        'available_clubs': dataForFirestore,
      });
    }
  }

  void _removeClub(Map<String, dynamic> club) async {
    // Removing given club from user's available clubs in db
    final userData = await _firebase.collection('users').doc(userID).get();

    List availableClubs = userData.data()!['available_clubs'];
    availableClubs.removeWhere((element) => element['name'] == club['name']);

    await _firebase
        .collection('users')
        .doc(userID)
        .update({'available_clubs': availableClubs});

    // Add given club to user's joined clubs
    List joinedClubs = userData.data()!['joined_clubs'];
    joinedClubs.add({
      'name': club['name'],
      'description': club['description'],
      'president': club['president'],
      'advisor': club['advisor'],
    });

    await _firebase
        .collection('users')
        .doc(userID)
        .update({'joined_clubs': joinedClubs});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder(
        stream: _firebase.collection('users').doc(userID).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          Map<String, dynamic> userData = snapshot.data!.data()!;
          List<dynamic> availableClubs = userData['available_clubs'];

          return ListView.builder(
            itemCount: availableClubs.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ElevatedButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(availableClubs[index]['name']),
                                Text(availableClubs[index]['description']),
                                Text(availableClubs[index]['president']),
                                Text(availableClubs[index]['advisor']),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    _removeClub(availableClubs[index]);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Join now!"),
                                ),
                              ],
                            ),
                          );
                        });
                  },
                  child: Text(availableClubs[index]['name']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
