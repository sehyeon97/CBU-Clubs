import 'package:club/models/club.dart';
import 'package:club/providers/users_clubs.dart';
import 'package:club/widgets/lazy_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UsersClubs extends ConsumerWidget {
  const UsersClubs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Club> usersClubs = ref.watch(userClubsProvider);

    return Center(
      child: CustomListView(
        list: usersClubs,
        tab: 1,
      ),
    );
  }
}
