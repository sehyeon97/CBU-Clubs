import 'package:club/models/club.dart';
import 'package:club/providers/available_clubs.dart';
import 'package:club/widgets/lazy_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AvailableClubs extends ConsumerWidget {
  const AvailableClubs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Club> availableClubs = ref.watch(availableClubsProvider);

    return Center(
      child: CustomListView(list: availableClubs),
    );
  }
}
