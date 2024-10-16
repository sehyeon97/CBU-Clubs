import 'package:club/screens/home/home.dart';
import 'package:club/screens/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        home: StreamBuilder(
          // this stream points to whether the user has logged in before
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // if this user has logged in before and
            // therefore has data in firebase, then go straight to
            // Home screen instead of showing login screen
            // it can still go to login screen if that
            // user authentication token state expired
            if (snapshot.hasData) {
              return const HomeScreen();
            }

            return const Login();
          },
        ),
      ),
    );
  }
}
