import 'dart:convert';
import 'package:club/models/club.dart';
import 'package:flutter/services.dart';

class AllClubsFromWeb {
  List<Club> clubs = [];

  _populateClubs() async {
    String response = await rootBundle.loadString('lib/data/output.json');
    final List data = await json.decode(response);

    for (final obj in data) {
      clubs.add(
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
    return clubs;
  }
}
