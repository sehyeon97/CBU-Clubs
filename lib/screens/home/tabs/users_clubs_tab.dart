import 'package:club/models/club.dart';
import 'package:club/widgets/club/club_home/selected_club_home.dart';
import 'package:flutter/material.dart';

class UsersClubs extends StatefulWidget {
  const UsersClubs({super.key});

  @override
  State<StatefulWidget> createState() {
    return _UsersClubsState();
  }
}

class _UsersClubsState extends State<UsersClubs> {
  late Future<List<Club>> _clubs;

  @override
  void initState() {
    super.initState();
    _clubs = _loadClubs();
  }

  Future<List<Club>> _loadClubs() async {
    List<Club> _loadedClubs = [];
    // todo: fetch user's joined clubs list from database here.
    // todo: iterate through and add each club to _loadedClubs
    // todo: should be similar to loadClubsFromJson() in available_clubs_tab.dart
    return _loadedClubs;
  }

  void _removeClub(Club club) {
    setState(() {
      // todo: Remove club from user's joined club list
      // todo: Add to user's available club list
      // todo: fetch the updated user's joined club list and
      // todo: set that to _clubs
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder(
        future: _clubs,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ElevatedButton(
                  onLongPress: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext dialogContext) {
                        return AlertDialog(
                          content: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Center(child: Text("Leave Club?")),
                              const SizedBox(height: 16.0),
                              Row(
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      _removeClub(snapshot.data![index]);
                                      Navigator.of(dialogContext).pop();
                                    },
                                    child: const Text("Yes"),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(dialogContext).pop();
                                    },
                                    child: const Text("No"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ClubHome(club: snapshot.data![index]);
                        },
                      ),
                    );
                  },
                  child: Text(snapshot.data![index].name),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
