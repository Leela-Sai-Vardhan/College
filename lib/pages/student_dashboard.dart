import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrsec_admin/models/user_model.dart';
import 'package:vrsec_admin/student/home_section.dart';
import 'package:vrsec_admin/student/profile_section.dart';
import 'package:vrsec_admin/student/progress_section.dart'; // Updated import

class StudentDashboard extends StatefulWidget {
  final User user; // Accept user as a parameter

  const StudentDashboard({
    super.key,
    required this.user,
  });

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  int _currentIndex = 0;

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    // Initialize the UserModel with user data and notify listeners
    final userModel = Provider.of<UserModel>(context, listen: false);
    userModel.updateUser(
      userId: widget.user.uid, // Pass the Firebase UID
      username: widget.user.displayName ?? 'Student',
      email: widget.user.email ?? 'No email',
    );

    // Define pages without passing username/email manually
    _pages = [
      const HomeSection(), // Access username from Provider in HomeSection
      const ProgressPage(), // Updated to use ProgressPage
      ProfileSection(), // Access username and email from Provider in ProfileSection
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
