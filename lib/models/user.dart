import 'package:club/models/club.dart';

class User {
  const User({
    required this.name,
    required this.userClubs,
  });

  final String name;
  final List<Club> userClubs;
}
