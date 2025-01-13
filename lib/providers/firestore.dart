import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:club/models/club.dart';


class Firestore {
  static final fb = FirebaseFirestore.instance;

  // Moved from available_clubs_tab.dart
  // rework
  static Future<void> loadClubs(String userID) async {
    final userData = await fb.collection('users').doc(userID).get();

    if (userData.data() == null) {}

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
      await fb.collection('users').doc(userID).update({
        'available_clubs': dataForFirestore,
      });
    }
  }

  // Moved from available_clubs_tab.dart
  // rework
  static void removeClub(Map<String, dynamic> club, String userID) async {
    // Removing given club from user's available clubs in db
    final userData = await fb.collection('users').doc(userID).get();

    List availableClubs = userData.data()!['available_clubs'];
    availableClubs.removeWhere((element) => element['name'] == club['name']);

    await fb
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

    await fb
        .collection('users')
        .doc(userID)
        .update({'joined_clubs': joinedClubs});
  }

  // Remove name from user/joined_clubs
  static void _removeClub(String clubName, String userID) async {
    final userData = await fb.collection('users').doc(userID).get();

    List joinedClubs = userData.data()!['joined_clubs'];
    joinedClubs.removeWhere((el) => el['name'] == clubName);
  }

  // Add name to user/joined_clubs
  static Future<void> _addClub(String clubName, String userID) async {
    final userData = await fb.collection('users').doc(userID).get();

    List joinedClubs = userData.data()!['joined_clubs'];
    joinedClubs.add(clubName);
  } 

  // Load available clubs
  static Future<List<dynamic>> _loadAvailableClubIDs(String userID) async {
    final userData = await fb.collection('users').doc(userID).get();
    final clubData = await fb.collection('clubs').get();

    List joinedClubs = userData.data()!['joined_clubs'];
    List allClubIds = List.empty();
    for (var doc in clubData.docs) {
      if (!joinedClubs.contains(doc.id)) {
        allClubIds.add(doc.id);
      }
    }
    return allClubIds;
  }

  // Load joined clubs
  static Future<List<dynamic>> _loadJoinedClubIDs(String userID) async {
    final userData = await fb.collection('users').doc(userID).get();

    return userData.data()!['joined_clubs'];
  }
}