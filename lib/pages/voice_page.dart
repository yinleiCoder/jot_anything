import 'package:flutter/material.dart';

/// Voice tab page shown inside the bottom navigation shell.
class VoicePage extends StatelessWidget {
  const VoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.keyboard_voice, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('语音', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
