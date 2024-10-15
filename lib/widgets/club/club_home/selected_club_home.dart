import 'package:club/models/club.dart';
import 'package:club/screens/home/home.dart';
import 'package:club/widgets/club/club_home/tabs/announcements.dart';
import 'package:club/widgets/club/club_home/tabs/events.dart';
import 'package:club/widgets/club/club_home/tabs/group_chat.dart';
import 'package:club/widgets/club/settings/settings_dialog.dart';
import 'package:flutter/material.dart';

class ClubHome extends StatefulWidget {
  const ClubHome({
    super.key,
    required this.club,
  });

  final Club club;

  @override
  State<ClubHome> createState() => _ClubHomeState();
}

class _ClubHomeState extends State<ClubHome> {
  int _selectedIndex = 0;

  final tabs = const [
    Announcements(),
    Events(),
    GroupChat(),
  ];

  void onBarItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const HomeScreen();
                },
              ),
            );
          },
        ),
        title: Text(widget.club.name),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Settings(club: widget.club);
                  });
            },
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.announcement),
            label: "Announcements",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.event),
            label: "Events",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: "Chat",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (value) {
          onBarItemTap(value);
        },
      ),
    );
  }
}
