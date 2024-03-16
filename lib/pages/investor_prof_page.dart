// ignore_for_file: use_key_in_widget_constructors, unused_import, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../styles/styles.dart';
import './widget/buttons.dart';
import 'interface.dart';

class InvestorProfile extends StatefulWidget {
  const InvestorProfile({super.key});

  @override
  State<InvestorProfile> createState() => _InvestorProfileState();
}

class _InvestorProfileState extends State<InvestorProfile>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              radius: 50,
              // Placeholder for profile picture
              backgroundImage: AssetImage('assets/profile_image.jpg'),
            ),
            SizedBox(height: 20),
            Text(
              'User Name', // Replace with actual user's name
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Investor', // Replace with user's role
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to edit profile page
              },
              child: Text('Edit Profile'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Navigate to settings page
              },
              child: Text('Settings'),
            ),
          ],
        ),
      ),
    );
  }
}