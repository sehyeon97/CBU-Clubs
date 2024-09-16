import 'package:club/models/club.dart';
import 'package:club/widgets/club/info.dart';
import 'package:club/widgets/club/selected_club_home.dart';
import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.club,
    required this.tab,
  });

  final Club club;
  final int tab;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext contxt) {
            return tab == 0 ? ClubInfo(club: club) : const ClubHome();
          }),
        );
      },
      child: Text(club.name),
    );
  }
}
