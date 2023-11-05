import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/core.dart';
import '../../../injection.dart';
import '../../presentation.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => SplashPageState();
}

class SplashPageState extends State<SplashPage> {
  final AppNavigator navigator = sl<AppNavigator>();
  final SplashCubit splashCubit = sl<SplashCubit>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ScaffoldBuilder(
            onThemeModeChange: (_) => setState(() {}),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasData) {
          return const Homepage();
        } else {
          return const AuthPage();
        }
      },
    );
  }
}
