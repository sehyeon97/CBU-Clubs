import 'package:club/models/club.dart';

// The purpose of this class is to find the correct position to insert
// the new Club so that the entire list stays sorted
// The class assumes that the given list is sorted
// The limitation is you need an instance of this class each time you have
// a club to add
class ClubSort {
  ClubSort({
    required this.clubs,
    required this.clubToAdd,
  });

  List<Club> clubs;
  Club clubToAdd;

  int _binarySearch() {
    int low = 0;
    int high = clubs.length - 1;
    int mid = low + (high - low) ~/ 2;
    String clubToAddName = clubToAdd.name.toLowerCase();

    while (low <= high) {
      String curr = clubs[mid].name.toLowerCase();
      int currVal = curr.compareTo(clubToAddName);

      if (currVal < 0) {
        low = mid + 1;
      } else if (currVal > 0) {
        high = mid - 1;
      }

      mid = low + (high - low) ~/ 2;
    }

    return mid;
  }

  // Every element that comes after this index needs to move right once
  void _sort(int index) {
    if (index <= 0) {
      clubs = [clubToAdd, ...clubs];
      return;
    }

    if (index >= clubs.length) {
      clubs = [...clubs, clubToAdd];
      return;
    }

    // append the last club on list to the end of list
    // so that there are two of the same
    clubs.add(clubs[clubs.length - 1]);

    // overwrite current club with previous club until target index is reached
    for (int i = clubs.length - 1; i > index; i--) {
      clubs[i] = clubs[i - 1];
    }

    // overwrite target index with clubToAdd
    clubs[index] = clubToAdd;
  }

  List<Club> getSortedClubs() {
    _sort(_binarySearch());
    return clubs;
  }
}
