import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class UploadJsonToFS {
  static final fb = FirebaseFirestore.instance;

  static void upload() async {
    String response = await rootBundle.loadString('lib/data/output.json');
    final List data = await json.decode(response);

    for (final club in data) {
      await fb.collection('clubs').doc(club['title']).set(
        {
          'description': club['description'],
          'president': club['president'],
          'advisor': club['advisor'],
          'meeting_time': '',
          'announncements': {
            'message': '',
            'timestamp': DateTime.now(),
          },
          'messages': {
            'username': 'AI',
            'message': '',
            'timestamp': DateTime.now(),
          },
          'events': {
            'title': 'Event Name',
            'description': 'Event Description',
            'time': 'Event Time',
            'date_created': DateTime.now(),
          },
          'admins': <String>[],
          'members': <String>[],
          'notif_enabled_users': <String>[],
        },
      );
    }
  }
}
