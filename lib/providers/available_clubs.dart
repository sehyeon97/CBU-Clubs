import 'package:club/data/test.dart';
import 'package:club/models/club.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClubNotifier extends StateNotifier<List<Club>> {
  ClubNotifier() : super(getClubsDetails());

  // at this point, the list is not alphabetical
  // need to change this in the future
  void addClub(Club club) {
    state = [...state, club];
  }

  void removeClub(Club club) {
    List<Club> temp = [];
    temp.addAll(state);
    temp.remove(club);
    state = temp;
  }
}

// This is a placeholder method for now
// and will be used when the web scraper or database supplies data
List<Club> getClubsDetails() {
  return test;
}

final availableClubsProvider =
    StateNotifierProvider<ClubNotifier, List<Club>>((ref) {
  return ClubNotifier();
});
