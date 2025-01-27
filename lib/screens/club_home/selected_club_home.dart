import 'package:club/models/club.dart';
import 'package:club/screens/club_home/tabs/leaderboard.dart';
import 'package:club/screens/club_home/tabs/meeting_time.dart';
import 'package:club/screens/home/home.dart';
import 'package:club/screens/club_home/tabs/announcements.dart';
import 'package:club/screens/club_home/tabs/events.dart';
import 'package:club/screens/club_home/tabs/group_chat.dart';
import 'package:club/widgets/settings/settings_dialog.dart';
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

  late final tabs = [
    Announcements(),
    Events(),
    Leaderboard(),
    GroupChat(),
    MeetingTime(
      clubName: widget.club.name,
    ),
  ];

  void onDrawerItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: const Icon(Icons.menu),
            );
          },
        ),
        title: Text(widget.club.name),
        centerTitle: true,
        actions: [
          IconButton(
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
              icon: const Icon(Icons.home)),
          const SizedBox(width: 10.0),
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
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(child: Text('Menu')),
            ListTile(
              title: const Text('Announcements'),
              onTap: () {
                onDrawerItemTap(0);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Events'),
              onTap: () {
                onDrawerItemTap(1);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Rankings'),
              onTap: () {
                onDrawerItemTap(2);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Chat'),
              onTap: () {
                onDrawerItemTap(3);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              title: const Text('Meeting Time'),
              onTap: () {
                onDrawerItemTap(4);
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ),
      body: tabs[_selectedIndex],
    );
  }
}
