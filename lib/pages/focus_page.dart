import 'package:flutter/material.dart';

/// Focus tab page shown inside the bottom navigation shell.
class FocusPage extends StatelessWidget {
  const FocusPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.timer, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('专注', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
