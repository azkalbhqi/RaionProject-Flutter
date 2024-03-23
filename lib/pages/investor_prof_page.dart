// ignore_for_file: use_key_in_widget_constructors, unused_import, prefer_const_constructors

import 'package:CampVestor/pages/widget/buttons.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:CampVestor/pages/edit_profile_page.dart';
import 'package:CampVestor/pages/login_page.dart'; // Import the login page
import '../styles/styles.dart';

class InvestorProfile extends StatefulWidget {
  final String id;

  const InvestorProfile({Key? key, required this.id}) : super(key: key);

  @override
  State<InvestorProfile> createState() => _InvestorProfileState();
}

class _InvestorProfileState extends State<InvestorProfile> {
  late String userName;
  late String email;
  late String profileImageUrl;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final response = await http.get(Uri.parse('https://65fd98169fc4425c6532555f.mockapi.io/users/${widget.id}'));
      if (response.statusCode == 200) {
        final userData = json.decode(response.body);
        setState(() {
          userName = userData['username'];
          email = userData['email'];
          profileImageUrl = userData['pp'];
        });
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void logout() {
    // Navigate back to the login page
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        // Add back button on the left side
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(profileImageUrl),
            ),
            SizedBox(height: 20),
            Text(
              userName,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              email,
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EditProfilePage(userId: widget.id)),
                );
              },
              child: Text('Edit Profile'),
            ),
            SizedBox(height: 10),
            // Red logout button
            Buttons(
              onClicked: logout,
              text: 'Logout',
              width: MediaQuery.of(context).size.width, 
              backgroundColor: ColorStyles.red, 
              fontColor: ColorStyles.white
            ),
          ],
        ),
      ),
    );
  }
}
