import 'dart:convert';
import 'package:club/models/club.dart';
import 'package:flutter/services.dart';

class AllClubsFromWeb {
  final List<Club> _clubs = [];

  _populateClubs() async {
    String response = await rootBundle.loadString('lib/data/output.json');
    final List data = await json.decode(response);

    for (final obj in data) {
      _clubs.add(
        Club(
          name: obj["title"],
          description: obj["description"],
          president: obj["president"],
          advisor: obj["advisor"],
        ),
      );
    }
  }

  List<Club> getClubsFromWeb() {
    _populateClubs();
    return _clubs;
  }
}
