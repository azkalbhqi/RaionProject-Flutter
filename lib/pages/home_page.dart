// ignore_for_file: unused_import, empty_constructor_bodies, prefer_const_constructors

import 'package:flutter/material.dart';
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
      
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            // Total Portfolio Summary
            Card(
              elevation: 3,
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                  children: [
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