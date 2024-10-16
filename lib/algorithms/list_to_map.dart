import 'package:club/models/club.dart';

// temporary solution to fix updating lists in firestore
List<Map<String, String>> convertClubsToMap(List<Club> clubs) {
  List<Map<String, String>> map = [];

  for (Club club in clubs) {
    map.add({
      'name': club.name,
      'description': club.description,
      'president': club.president,
      'advisor': club.advisor,
    });
  }

  return map;
}
