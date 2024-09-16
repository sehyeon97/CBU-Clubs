import 'package:club/models/club.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserClubsNotifier extends StateNotifier<List<Club>> {
  UserClubsNotifier() : super([]);

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

final userClubsProvider =
    StateNotifierProvider<UserClubsNotifier, List<Club>>((ref) {
  return UserClubsNotifier();
});
