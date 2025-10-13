import 'package:flutter/material.dart';

class AttendancePage extends StatelessWidget {
  const AttendancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Attendance Percentage
            Center(
              child: Column(
                children: [
                  Text(
                    '60%',
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange,
                    ),
                  ),
                  const SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: 0.6,
                    backgroundColor: Colors.grey[300],
                    color: Colors.orange,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Date Range Selection
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildDateBox('Jan 01, 2023'),
                Text('-'),
                _buildDateBox('May 31, 2023'),
              ],
            ),
            const SizedBox(height: 16),
            // Days Left and Target
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildInfoBox('Days Left', '17'),
                _buildInfoBox('Target', '2.4% /day'),
              ],
            ),
            const SizedBox(height: 16),
            // Description Box
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Description',
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Tasks Section
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        'Tasks',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('1 of 4'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  _buildTaskRow('Research', Colors.green, 1.0),
                  _buildTaskRow('Analyze', Colors.orange, 0.54),
                  _buildTaskRow('Communicate', Colors.red, 0.37),
                  _buildTaskRow('Development', Colors.orange, 0.5),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: const Text('New Task'),
        icon: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildDateBox(String date) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(date),
    );
  }

  Widget _buildInfoBox(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildTaskRow(String task, Color color, double progress) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            progress == 1.0 ? Icons.check_box : Icons.check_box_outline_blank,
            color: color,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(task),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              color: color,
            ),
          ),
          const SizedBox(width: 8),
          Text('${(progress * 100).toStringAsFixed(0)}%'),
        ],
      ),
    );
  }
}
