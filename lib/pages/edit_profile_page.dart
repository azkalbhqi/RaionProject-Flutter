import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditProfilePage extends StatefulWidget {
  final String userId;

  const EditProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final response = await http.get(
          Uri.parse('https://65fd98169fc4425c6532555f.mockapi.io/users/${widget.userId}'));
      if (response.statusCode == 200) {
        final userData = json.decode(response.body);
        _nameController.text = userData['name'] ?? '';
        _emailController.text = userData['email'] ?? '';
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (error) {
      print('Error: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> updateUserProfile() async {
    try {
      setState(() {
        _isLoading = true;
      });
      final response = await http.put(
        Uri.parse('https://65fd98169fc4425c6532555f.mockapi.io/users/${widget.userId}'),
        body: json.encode({
          'username': _nameController.text.trim(),
          // Do not update email field
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );
      if (response.statusCode == 200) {
        // Successfully updated
        Navigator.pop(context, true); // Navigate back and pass true to indicate success
      } else {
        throw Exception('Failed to update user profile');
      }
    } catch (error) {
      print('Error: $error');
      // Handle error
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(labelText: 'Name'),
                  ),
                  const SizedBox(height: 20),
                  // Disable email field
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    enabled: false, // Disable editing
                  ),
                  const SizedBox(height: 20),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: updateUserProfile,
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
    );
  }
}
