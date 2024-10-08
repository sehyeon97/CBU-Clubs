import 'package:club/algorithms/sort_club.dart';
import 'package:club/data/retrieve_json.dart';
import 'package:club/models/club.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClubNotifier extends StateNotifier<List<Club>> {
  ClubNotifier() : super(AllClubsFromWeb().getClubsFromWeb());

  void addClub(Club club) {
    if (state.isEmpty) {
      state = [...state, club];
    } else {
      List<Club> temp = [];
      temp.addAll(state);
      ClubSort clubSort = ClubSort(clubs: temp, clubToAdd: club);
      state = clubSort.getSortedClubs();
    }
  }

  void removeClub(Club club) {
    List<Club> temp = [];
    temp.addAll(state);
    temp.remove(club);
    state = temp;
  }
}

final availableClubsProvider =
    StateNotifierProvider<ClubNotifier, List<Club>>((ref) {
  return ClubNotifier();
});
