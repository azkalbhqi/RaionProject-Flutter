// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:CampVestor/pages/market_page.dart';
import 'package:CampVestor/pages/register_page.dart';
import './pages/onboarding_page.dart';
import 'pages/interface.dart';



void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Includemy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const OnboardingPage(),
    );
  }
}
