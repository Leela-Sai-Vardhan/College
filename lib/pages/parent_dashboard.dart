import 'package:flutter/material.dart';

class ParentDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Parent Dashboard')),
      body: Center(
        child: Text(
          'Welcome to the Parent Dashboard',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}