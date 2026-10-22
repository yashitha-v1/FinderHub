import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/splash_screen.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(

      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        fontFamily: 'Poppins',
      ),

      home: const AppStart(),
    );
  }
}

class AppStart extends StatefulWidget {

  const AppStart({super.key});

  @override
  State<AppStart> createState() =>
      _AppStartState();
}

class _AppStartState
    extends State<AppStart> {

  @override
  void initState() {

    super.initState();

    navigate();
  }

  Future<void> navigate() async {

    await Future.delayed(
      const Duration(seconds: 2),
    );

    User? user =
        FirebaseAuth.instance.currentUser;

    if (!mounted) return;

    if (user != null) {

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(
          builder: (_) =>
          const HomeScreen(),
        ),
      );

    } else {

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(
          builder: (_) =>
          const LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {

    return const SplashScreen();
  }
}