import 'package:club/models/club.dart';
import 'package:club/models/user.dart';
import 'package:club/providers/user_provider.dart';
import 'package:club/widgets/club/club_home/selected_club_home.dart';
import 'package:club/widgets/club/info.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomElevatedButton extends ConsumerWidget {
  const CustomElevatedButton({
    super.key,
    required this.club,
  });

  final Club club;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final User user = ref.watch(userProvider);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext contxt) {
              return !user.userClubs.contains(club)
                  ? ClubInfo(club: club)
                  : ClubHome(club: club);
            }),
          );
        },
        child: Text(club.name),
      ),
    );
  }
}
