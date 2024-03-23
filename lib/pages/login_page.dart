// ignore_for_file: use_build_context_synchronously

import 'package:CampVestor/pages/register_page.dart';
import 'package:CampVestor/pages/widget/buttons.dart';
import 'package:CampVestor/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:CampVestor/pages/interface.dart';

class User {
  final String userId;
  final String username;
  final String email;

  User({
    required this.userId,
    required this.username,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['id'],
      username: json['username'],
      email: json['email'],
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<User?> signIn() async {
    try {
      // Fetch user data from API
      final response = await http.get(
        Uri.parse('https://65fd98169fc4425c6532555f.mockapi.io/users'),
      );

      if (response.statusCode == 200) {
        // Decode the response body
        final List<dynamic> userData = jsonDecode(response.body);

        if (userData.isNotEmpty) {
          // Assuming email is unique, find user data by email
          final userMap = userData.firstWhere((user) => user['email'] == _emailController.text);
          final user = User.fromJson(userMap);

          // Navigate to another page (e.g., HomePage) passing the User instance
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => Interface(userName: user.username, userId: user.userId,),
            ),
          );

          return user;
        } else {
          // Handle empty response
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: const Text('No user data found.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      } else {
        // Handle unsuccessful response from the API
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to fetch user data. Status code: ${response.statusCode}'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (error) {
      // Handle errors that might occur during login or API request
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text('An error occurred: $error'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }

    // Return null if an error occurs
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Login",
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Poppins',
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add your login form fields here
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Buttons(
                  onClicked: () async {
                    // Call signIn method when the Sign In button is pressed
                    await signIn();
                  },
                  text: ('Sign In'),
                  width: MediaQuery.of(context).size.width, 
                  backgroundColor: ColorStyles.primary, 
                  fontColor: ColorStyles.white
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
                  },
                  child: const Text("I don't have an account"),
                ),
                
              ],
            ),
          ],
        ),
      ),
    );
  }
}
