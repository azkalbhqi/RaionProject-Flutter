// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  final String message;
  final String timestamp;

  const Notifications ({
    required this.message,
    required this.timestamp,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: const Icon(Icons.notifications_active),
          title: Text(message),
          subtitle: Text(timestamp),
          onTap: () {
            // Handle tap on notification
          },
        ),
        const Divider(),
      ],
    );
  }
}