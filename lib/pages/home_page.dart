// ignore_for_file: use_key_in_widget_constructors, unused_import, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../styles/styles.dart';
import './widget/buttons.dart';
import './notification_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text(
          'Capital Venture Investment Broker',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const NotificationPage()));
            },
          ),
        ],
      ),
      
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Welcome!',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            ListTile(
              title: Text(
                'View Investments',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                // Navigate to investments page
              },
            ),
            Divider(),
            ListTile(
              title: Text(
                'View Reports',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                // Navigate to reports page
              },
            ),
            Divider(),
            ListTile(
              title: Text(
                'Contact Us',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                // Navigate to contact us page
              },
            ),
            Divider(),
            ListTile(
              title: Text(
                'Settings',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                ),
              ),
              onTap: () {
                // Navigate to settings page
              },
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}
