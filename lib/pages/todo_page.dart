import 'package:flutter/material.dart';

/// Todo tab page shown inside the bottom navigation shell.
class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.checklist, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text('待办', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
