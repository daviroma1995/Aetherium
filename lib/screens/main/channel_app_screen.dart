import 'package:aetherium_salon/auth/sign_in_screen.dart';
import 'package:aetherium_salon/screens/error_screen.dart';
import 'package:aetherium_salon/screens/main/full_app_screen.dart';
import 'package:aetherium_salon/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChannelScreen extends StatelessWidget {
  const ChannelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) return const LoadingScreen();
        if (snapshot.hasError) return const ErrorScreen();
        if (snapshot.hasData) return const FullAppScreen();

        return const SignInScreen();
      },
    );
  }
}
