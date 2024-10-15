import 'package:flutter_riverpod/flutter_riverpod.dart';

// tells the app which user is logged on by user ID
class UserProvider extends StateNotifier<String> {
  UserProvider() : super("");
}

final userProvider = StateNotifierProvider<UserProvider, String>((ref) {
  return UserProvider();
});
