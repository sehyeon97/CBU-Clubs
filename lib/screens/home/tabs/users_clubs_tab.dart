import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:club/models/club.dart';
import 'package:club/screens/club_home/selected_club_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final _firebase = FirebaseFirestore.instance;
final String userID = FirebaseAuth.instance.currentUser!.uid;

class UsersClubs extends StatefulWidget {
  const UsersClubs({super.key});

  @override
  State<StatefulWidget> createState() {
    return _UsersClubsState();
  }
}

class _UsersClubsState extends State<UsersClubs> {
  void _removeClub(Map<String, dynamic> club) async {
    // Remove given club from user's joined clubs in db
    final userData = await _firebase.collection('users').doc(userID).get();
    List joinedClubs = userData.data()!['joined_clubs'];
    joinedClubs.removeWhere(((element) => element['name'] == club['name']));

    await _firebase
        .collection('users')
        .doc(userID)
        .update({'joined_clubs': joinedClubs});

    // Add given club to user's available clubs
    List availableClubs = userData.data()!['available_clubs'];
    availableClubs.add({
      'name': club['name'],
      'description': club['description'],
      'president': club['president'],
      'advisor': club['advisor'],
    });

    await _firebase
        .collection('users')
        .doc(userID)
        .update({'available_clubs': availableClubs});
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
          List<dynamic> joinedClubs = userData['joined_clubs'];

          if (joinedClubs.isEmpty) {
            return const Center(
                child: Text('You haven\'t joined any clubs :('));
          }

          return ListView.builder(
            itemCount: joinedClubs.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ElevatedButton(
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return AlertDialog(
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Center(
                                  child: Text(
                                      "Leave ${joinedClubs[index]['name']} Club?")),
                              const SizedBox(height: 16.0),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      _removeClub(joinedClubs[index]);
                                      Navigator.of(dialogContext).pop();
                                    },
                                    child: const Text("Yes"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(dialogContext).pop();
                                    },
                                    child: const Text("No"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          // todo: below code is a temporary solution
                          // todo: Need to change this to point to a club
                          // todo: in clubs collection in firestore
                          return ClubHome(
                            club: Club(
                              name: joinedClubs[index]['name'],
                              description: joinedClubs[index]['description'],
                              president: joinedClubs[index]['president'],
                              advisor: joinedClubs[index]['advisor'],
                            ),
                          );
                        },
                      ),
                    );
                  },
                  child: Text(joinedClubs[index]['name']),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
