import 'dart:convert';

import 'package:club/models/club.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AvailableClubs extends StatefulWidget {
  const AvailableClubs({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AvailableClubsState();
  }
}

class _AvailableClubsState extends State<AvailableClubs> {
  late Future<List<Club>> _clubs;

  @override
  void initState() {
    super.initState();
    // todo: this method runs once, when the app starts.
    // todo: if the user has available list data in database,
    // todo: this should fetch from database, otherwise it should fetch from
    // todo: the json which is _loadClubsFromJson()
    _clubs = _loadClubsFromJson();
  }

  Future<List<Club>> _loadClubsFromJson() async {
    String response = await rootBundle.loadString('lib/data/output.json');
    final List data = await json.decode(response);
    final List<Club> loadedClubs = [];

    for (final obj in data) {
      loadedClubs.add(
        Club(
          name: obj["title"],
          description: obj["description"],
          president: obj["president"],
          advisor: obj["advisor"],
        ),
      );
    }

    return loadedClubs;
  }

  void _removeClub(Club club) {
    setState(() {
      // todo: Remove this club from user's available clubs list in firebase
      // todo: Add this club to user's joined club list
      // todo: Set _clubs to fetch database for updated available clubs list
      // Delete this comment later: Whenever setState() is called, the
      // build method is called. Since the FutureBuilder runs off _clubs,
      // by fetching updated data in database and setting _clubs to it,
      // it should display the new available list for user
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
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(snapshot.data![index].name),
                                Text(snapshot.data![index].description),
                                Text(snapshot.data![index].president),
                                Text(snapshot.data![index].advisor),
                                const SizedBox(height: 20),
                                ElevatedButton(
                                  onPressed: () {
                                    _removeClub(snapshot.data![index]);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Join now!"),
                                ),
                              ],
                            ),
                          );
                        });
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
