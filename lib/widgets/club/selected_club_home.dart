import 'package:club/models/club.dart';
import 'package:flutter/material.dart';

class ClubHome extends StatelessWidget {
  const ClubHome({
    super.key,
    required this.club,
  });

  final Club club;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(club.name),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(itemBuilder: (context, index) {}),
      ),
    );
  }
}
