import 'package:club/algorithms/sort_club.dart';
import 'package:club/models/club.dart';
import 'package:test/test.dart';

void main() {
  test(
    'Adding element into the middle of a long list',
    () {
      List<Club> clubs = <Club>[
        const Club(
          name: "ABCD",
          description: "Not important",
          president: "someone",
          advisor: "hmm",
        ),
        const Club(
          name: "HIJK",
          description: "Not important",
          president: "someone",
          advisor: "hmm",
        ),
        const Club(
          name: "LMNO",
          description: "Not important",
          president: "someone",
          advisor: "hmm",
        ),
        const Club(
          name: "PQ",
          description: "Not important",
          president: "someone",
          advisor: "hmm",
        ),
        const Club(
          name: "PT",
          description: "Not important",
          president: "someone",
          advisor: "hmm",
        ),
        const Club(
          name: "XYZ",
          description: "Not important",
          president: "someone",
          advisor: "hmm",
        ),
      ];

      Club clubToAdd = const Club(
        name: "name",
        description: "hello",
        president: "World",
        advisor: "hmm",
      );

      ClubSort newSortedClubs = ClubSort(clubs: clubs, clubToAdd: clubToAdd);
      List<Club> clubList = newSortedClubs.getSortedClubs();

      expect(clubList[3].name, clubToAdd.name);
    },
  );

  test('Adding an element to list of 1 length', () {
    List<Club> clubs = [
      const Club(
        name: "club",
        description: "something",
        president: "matter",
        advisor: "atom",
      )
    ];

    Club clubToAdd = const Club(
      name: "abc",
      description: "description",
      president: "president",
      advisor: "advisor",
    );

    ClubSort sortedClubs = ClubSort(clubs: clubs, clubToAdd: clubToAdd);
    List<Club> clubList = sortedClubs.getSortedClubs();

    expect(clubList[0].name, clubToAdd.name);
  });

  test(
    'Adding element to END of list when list has 2+ items',
    () {
      List<Club> clubs = [
        const Club(
          name: "club",
          description: "something",
          president: "matter",
          advisor: "atom",
        ),
        const Club(
          name: "Fantasy",
          description: "description",
          president: "president",
          advisor: "advisor",
        ),
      ];

      Club clubToAdd = const Club(
        name: "pie",
        description: "description",
        president: "president",
        advisor: "advisor",
      );

      ClubSort sortedClubs = ClubSort(clubs: clubs, clubToAdd: clubToAdd);
      List<Club> clubList = sortedClubs.getSortedClubs();

      expect(clubList[2].name, clubToAdd.name);
    },
  );

  test(
    'Adding element to START of list when list has 2+ items',
    () {
      List<Club> clubs = [
        const Club(
          name: "club",
          description: "something",
          president: "matter",
          advisor: "atom",
        ),
        const Club(
          name: "Fantasy",
          description: "description",
          president: "president",
          advisor: "advisor",
        ),
      ];

      Club clubToAdd = const Club(
        name: "ABC",
        description: "description",
        president: "president",
        advisor: "advisor",
      );

      ClubSort sortedClubs = ClubSort(clubs: clubs, clubToAdd: clubToAdd);
      List<Club> clubList = sortedClubs.getSortedClubs();

      expect(clubList[0].name, clubToAdd.name);
    },
  );

  test(
    'Adding element to START + 1 of list when list has 4+ items',
    () {
      List<Club> clubs = [
        const Club(
          name: "club",
          description: "something",
          president: "matter",
          advisor: "atom",
        ),
        const Club(
          name: "Fantasy",
          description: "description",
          president: "president",
          advisor: "advisor",
        ),
        const Club(
          name: "Goo",
          description: "description",
          president: "president",
          advisor: "advisor",
        ),
        const Club(
          name: "Poo",
          description: "description",
          president: "president",
          advisor: "advisor",
        ),
      ];

      Club clubToAdd = const Club(
        name: "ddos",
        description: "description",
        president: "president",
        advisor: "advisor",
      );

      ClubSort sortedClubs = ClubSort(clubs: clubs, clubToAdd: clubToAdd);
      List<Club> clubList = sortedClubs.getSortedClubs();

      expect(clubList[1].name, clubToAdd.name);
    },
  );

  test(
    'Adding element to END - 1 of list when list has 4+ items',
    () {
      List<Club> clubs = [
        const Club(
          name: "club",
          description: "something",
          president: "matter",
          advisor: "atom",
        ),
        const Club(
          name: "Fantasy",
          description: "description",
          president: "president",
          advisor: "advisor",
        ),
        const Club(
          name: "Same",
          description: "description",
          president: "president",
          advisor: "advisor",
        ),
        const Club(
          name: "Zoo",
          description: "description",
          president: "president",
          advisor: "advisor",
        ),
      ];

      Club clubToAdd = const Club(
        name: "Yelp",
        description: "description",
        president: "president",
        advisor: "advisor",
      );

      ClubSort sortedClubs = ClubSort(clubs: clubs, clubToAdd: clubToAdd);
      List<Club> clubList = sortedClubs.getSortedClubs();

      expect(clubList[3].name, clubToAdd.name);
    },
  );

  test(
    'Adding a club that differs by one ending letter correctly ',
    () {
      List<Club> clubs = <Club>[
        const Club(
          name: "ABCD",
          description: "Not important",
          president: "someone",
          advisor: "hmm",
        ),
        const Club(
          name: "HIJK",
          description: "Not important",
          president: "someone",
          advisor: "hmm",
        ),
        const Club(
          name: "LMNO",
          description: "Not important",
          president: "someone",
          advisor: "hmm",
        ),
        const Club(
          name: "PQ",
          description: "Not important",
          president: "someone",
          advisor: "hmm",
        ),
        const Club(
          name: "PTwasOr is something idk",
          description: "Not important",
          president: "someone",
          advisor: "hmm",
        ),
        const Club(
          name: "XYZ",
          description: "Not important",
          president: "someone",
          advisor: "hmm",
        ),
      ];

      Club clubToAdd = const Club(
        name: "PTwasOr is something idc",
        description: "hello",
        president: "World",
        advisor: "hmm",
      );

      Club anotherClubToAdd = const Club(
        name: "PTwasOr is something idz",
        description: "hello",
        president: "World",
        advisor: "hmm",
      );

      ClubSort newSortedClubs = ClubSort(clubs: clubs, clubToAdd: clubToAdd);
      List<Club> clubList = newSortedClubs.getSortedClubs();

      ClubSort anotherSortedClubs =
          ClubSort(clubs: clubs, clubToAdd: anotherClubToAdd);
      List<Club> anotherClubList = anotherSortedClubs.getSortedClubs();

      expect(clubList[4].name, clubToAdd.name);
      expect(anotherClubList[6].name, anotherClubToAdd.name);
    },
  );
}
