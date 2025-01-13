import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:club/providers/firestore.dart';
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
    Firestore.loadClubs(userID);
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
                                    Firestore.removeClub(
                                        availableClubs[index], userID);
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
