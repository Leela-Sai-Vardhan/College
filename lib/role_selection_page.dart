import 'package:flutter/material.dart';
import 'package:vrsec_admin/pages/faculty_login_page.dart';
import 'package:vrsec_admin/pages/parent_login_page.dart';
import 'package:vrsec_admin/pages/student_login_page.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Your Role',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.purpleAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildRoleButton(
                  context,
                  icon: Icons.school,
                  label: 'Login as Student',
                  color: Colors.green,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StudentLoginPage()),
                    );
                  },
                ),
                SizedBox(height: 20),
                _buildRoleButton(
                  context,
                  icon: Icons.person,
                  label: 'Login as Faculty',
                  color: Colors.blue,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FacultyLoginPage()),
                    );
                  },
                ),
                SizedBox(height: 20),
                _buildRoleButton(
                  context,
                  icon: Icons.family_restroom,
                  label: 'Login as Parent',
                  color: Colors.orange,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ParentLoginPage()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper Method to Create a Styled Button
  Widget _buildRoleButton(BuildContext context,
      {required IconData icon,
      required String label,
      required Color color,
      required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      icon: Icon(icon, size: 28),
      label: Text(
        label,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color, // Use backgroundColor instead of primary
        foregroundColor: Colors.white, // Replaces onPrimary
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 5,
      ),
      onPressed: onPressed,
    );
  }
}
