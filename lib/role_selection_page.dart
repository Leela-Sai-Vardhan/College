import 'package:flutter/material.dart';
import 'package:vrsec_admin/pages/faculty_login_page.dart';
import 'package:vrsec_admin/pages/parent_login_page.dart';
import 'package:vrsec_admin/pages/student_login_page.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Logo Space - Add your image here
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  // Replace the placeholder below with your actual logo
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                  ),
                  // If you don't have the logo yet, use this placeholder:
                  // child: Center(
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     children: [
                  //       Icon(Icons.school, size: 60, color: Colors.blue[800]),
                  //       SizedBox(height: 8),
                  //       Text(
                  //         'LOGO HERE',
                  //         style: TextStyle(
                  //           color: Colors.grey[600],
                  //           fontSize: 12,
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ),
                SizedBox(height: 60),

                // Student Login Button
                _buildRoleButton(
                  context,
                  label: 'STUDENT LOGIN',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StudentLoginPage()),
                    );
                  },
                ),
                SizedBox(height: 20),

                // Faculty Login Button
                _buildRoleButton(
                  context,
                  label: 'FACULTY LOGIN',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FacultyLoginPage()),
                    );
                  },
                ),
                SizedBox(height: 20),

                // Parent Login Button
                _buildRoleButton(
                  context,
                  label: 'PARENT LOGIN',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ParentLoginPage()),
                    );
                  },
                ),
                SizedBox(height: 60),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper Method to Create a Styled Button
  Widget _buildRoleButton(BuildContext context,
      {required String label, required VoidCallback onPressed}) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[700],
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 3,
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
          ),
        ),
      ),
    );
  }
}
