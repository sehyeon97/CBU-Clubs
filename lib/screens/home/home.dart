import 'package:club/screens/home/tabs/available_clubs_tab.dart';
import 'package:club/screens/home/tabs/users_clubs_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _selectedTab = 0;

  final tabs = const [
    AvailableClubs(),
    UsersClubs(),
  ];

  void _onBarItemTap(int tab) {
    setState(() {
      _selectedTab = tab;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home")),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: "Available Clubs",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: "My Clubs",
          ),
        ],
        currentIndex: _selectedTab,
        onTap: (value) {
          _onBarItemTap(value);
        },
      ),
      body: tabs[_selectedTab],
    );
  }
}
