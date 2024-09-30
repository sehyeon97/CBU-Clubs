import 'package:club/widgets/buttons/club_list_buttons.dart';
import 'package:flutter/material.dart';

class CustomListView extends StatelessWidget {
  const CustomListView({
    super.key,
    required this.list,
  });

  // use of generic list instead of list of Club to make it more
  // reusable in the future
  final List list;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: CustomElevatedButton(
            club: list[index],
          ),
        );
      },
    );
  }
}
