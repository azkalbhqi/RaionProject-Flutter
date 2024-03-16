// ignore_for_file: unused_import, empty_constructor_bodies, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:raionapp/pages/investor_prof_page.dart';
import 'package:raionapp/pages/register_page.dart';
import 'package:raionapp/pages/who_are_you.dart';
import '../styles/styles.dart';
import 'interface.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import './widget/buttons.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.primary,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profile Bar
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: GestureDetector(
                onTap: () {
                  // Handle the onTap event
                  // For example, navigate to a profile details page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => InvestorProfile()),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        // Add your profile picture here
                        backgroundImage: AssetImage('assets/profile_image.jpg'), // Example image
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome, Name', // Replace with actual user's name
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Investor',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Total Portfolio Summary
            Card(
              elevation: 3,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Total Portfolio Summary',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Total Value: \$10,000',
                      style: TextStyle(fontSize: 16),
                    ),
                    Text(
                      'Total Profit/Loss: +\$1,500 (15%)',
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            // Trending Stocks
            Card(
              elevation: 3,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Trending Stocks',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16),
                    ListTile(
                      title: Text('Apple Inc.'),
                      subtitle: Text('AAPL'),
                      trailing: Text('\$150.00 (+2.5%)'),
                    ),
                    ListTile(
                      title: Text('Google Inc.'),
                      subtitle: Text('GOOGL'),
                      trailing: Text('\$2,000.00 (+1.8%)'),
                    ),
                    ListTile(
                      title: Text('Amazon.com Inc.'),
                      subtitle: Text('AMZN'),
                      trailing: Text('\$3,500.00 (-0.5%)'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}