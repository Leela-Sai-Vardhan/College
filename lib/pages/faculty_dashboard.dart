import 'package:flutter/material.dart';

class FacultyDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Faculty Dashboard')),
      body: Center(
        child: Text(
          'Welcome to the Faculty Dashboard',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}