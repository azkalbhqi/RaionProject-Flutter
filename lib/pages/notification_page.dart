// ignore_for_file: unnecessary_null_comparison, use_key_in_widget_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:CampVestor/pages/interface.dart';
import 'package:CampVestor/styles/styles.dart';

class NotificationPage extends StatefulWidget {
  final String userName; // Pass the user name from the Interface widget
  final String userId;

  const NotificationPage({Key? key, required this.userName, required this.userId}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  late List<NotificationData> notifications;

  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    final response = await http.get(Uri.parse('https://65fd90629fc4425c653243d7.mockapi.io/log'));
    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      setState(() {
        notifications = responseData
            .map((data) => NotificationData.fromJson(data))
            .toList();
        notifications.sort((a, b) => b.timestamp.compareTo(a.timestamp)); // Sort by timestamp
      });
    } else {
      throw Exception('Failed to load notifications');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: ColorStyles.primary,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => Interface(userName: widget.userName, userId: widget.userId,), // Pass the user name
              ),
            );
          },
        ),
        title: const Text('Notifications'),
      ),
      body: notifications != null
          ? ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return ListTile(
                  leading: const Icon(Icons.notifications),
                  title: Text(notification.name),
                  subtitle: Text('${notification.price} at ${notification.timestamp}'),
                  trailing: notification.buy
                      ? const Badge(color: Colors.green, text: 'Buy')
                      : const Badge(color: Colors.red, text: 'Sell'),
                );
              },
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class NotificationData {
  final String name;
  final double price;
  final String timestamp;
  final bool buy;

  NotificationData({
    required this.name,
    required this.price,
    required this.timestamp,
    required this.buy,
  });

  factory NotificationData.fromJson(Map<String, dynamic> json) {
    return NotificationData(
      name: json['name'],
      price: json['price'].toDouble(),
      timestamp: json['timestamp'],
      buy: json['buy'],
    );
  }
}

class Badge extends StatelessWidget {
  final Color color;
  final String text;

  const Badge({
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
