// ignore_for_file: use_rethrow_when_possible

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:raionapp/pages/investor_prof_page.dart';
import 'package:raionapp/styles/styles.dart';

class HomePage extends StatefulWidget {
  final String userName;

  const HomePage({Key? key, required this.userName}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late double totalPortfolioValue;

  @override
  void initState() {
    super.initState();
    fetchPortfolioData();
  }

  Future<void> fetchPortfolioData() async {
    try {
      final response = await http.get(Uri.parse('https://65fd90629fc4425c653243d7.mockapi.io/stocks'));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        double totalValue = 0;
        for (var data in responseData) {
          if (data['bought']) {
            totalValue += double.parse(data['price'].toString());
          }
        }
        setState(() {
          totalPortfolioValue = totalValue;
        });
      } else {
        throw Exception('Failed to load portfolio data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.primary,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Profile Bar
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const InvestorProfile()),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundImage: AssetImage('assets/profile_image.jpg'), 
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome, ${widget.userName}', 
                            style: const TextStyle(
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
            const SizedBox(height: 20),
            // Total Portfolio Summary
            FutureBuilder<double>(
              future: PortfolioData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  final totalPortfolioValue = snapshot.data ?? 0;
                  return Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Total Portfolio Summary',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Total Value: \$${totalPortfolioValue.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Future<double> PortfolioData() async {
    try {
      final response = await http.get(Uri.parse('https://65fd90629fc4425c653243d7.mockapi.io/stocks'));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        double totalValue = 0;
        for (var data in responseData) {
          if (data['bought'] == true) {
            totalValue += double.parse(data['price'].toString());
          }
        }
        return totalValue;
      } else {
        throw Exception('Failed to load portfolio data');
      }
    } catch (error) {
      print('Error: $error');
      throw error;
    }
  }
}
