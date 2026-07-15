import 'package:flutter/material.dart';

/// Schedule tab page shown inside the bottom navigation shell.
class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calendar_month, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('日程', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
