import 'package:flutter/material.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Icon(Icons.task_alt, size: 100, color: Color(0xFF448AFF)),
        SizedBox(height: 12),
        Text(
          'Daily Task',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFF448AFF),
          ),
        ),
      ],
    );
  }
}
