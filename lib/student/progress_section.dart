import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrsec_admin/models/user_model.dart'; // Import your UserModel
import 'package:vrsec_admin/progress/attendance.dart';

class ProgressPage extends StatelessWidget {
  const ProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context); // Access UserModel

    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
        automaticallyImplyLeading: false, // Removes the back icon
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          scrollDirection: Axis.vertical,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AttendancePage(),
                        ),
                      );
                    },
                    child: _buildProgressCard(
                      title: '${userModel.attendance.toStringAsFixed(1)}%',
                      subtitle: 'Attendance',
                      color: Colors.blue,
                      progressValue: userModel.attendance / 100,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _showResultUploadDialog(context, userModel);
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 4,
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: Center(
                          child: Icon(
                            Icons.add,
                            size: 36,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _buildProgressCard(
                    title: '${userModel.results.length}/4',
                    subtitle: 'Assignments Completed',
                    color: Colors.orange,
                    progressValue: userModel.results.length / 4,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _buildProgressCard(
                    title: '${userModel.cgpa.toStringAsFixed(2)}',
                    subtitle: 'CGPA',
                    color: Colors.purple,
                    progressValue: userModel.cgpa / 10,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressCard({
    required String title,
    required String subtitle,
    required Color color,
    required double progressValue,
  }) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 4,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color.withAlpha(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progressValue,
              backgroundColor: Colors.grey[300],
              color: color,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showResultUploadDialog(BuildContext context, UserModel userModel) {
    final TextEditingController resultController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Upload Result'),
          content: TextField(
            controller: resultController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Enter Result (e.g., CGPA)',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final double? result = double.tryParse(resultController.text);
                if (result != null) {
                  userModel.addResult(type: 'Semester', value: result);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Invalid input')),
                  );
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
