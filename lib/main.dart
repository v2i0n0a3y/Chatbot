import 'package:flutter/material.dart';
import 'package:gemiii/splashscreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'gemiii',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF0000FF)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}



