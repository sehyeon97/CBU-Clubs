import 'package:club/algorithms/sort_club.dart';
import 'package:club/models/club.dart';
import 'package:club/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProvider extends StateNotifier<User> {
  UserProvider()
      : super(
          User(
            name: 'Test Subject',
            userClubs: [],
          ),
        );

  void addClub(Club club) {
    if (state.userClubs.isEmpty) {
      state.userClubs = [...state.userClubs, club];
    } else {
      List<Club> temp = [];
      temp.addAll(state.userClubs);
      ClubSort clubSort = ClubSort(clubs: temp, clubToAdd: club);
      state.userClubs = clubSort.getSortedClubs();
    }
  }

  void removeClub(Club club) {
    List<Club> temp = [];
    temp.addAll(state.userClubs);
    temp.remove(club);
    state.userClubs = temp;
  }

  bool containsClub(Club club) {
    return state.userClubs.contains(club);
  }
}

final userProvider = StateNotifierProvider<UserProvider, User>((ref) {
  return UserProvider();
});
