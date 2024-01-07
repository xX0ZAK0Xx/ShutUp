import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shutup/auth/auth_gate.dart';
import 'package:shutup/firebase_options.dart';
import 'package:shutup/themes/light_mode.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}   

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
      theme: lightMode,
    );
  }
}