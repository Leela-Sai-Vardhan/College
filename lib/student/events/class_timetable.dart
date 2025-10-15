import 'package:flutter/material.dart';

class ClassTimeTable extends StatefulWidget {
  const ClassTimeTable({super.key});

  @override
  State<ClassTimeTable> createState() => _ClassTimeTableState();
}

class _ClassTimeTableState extends State<ClassTimeTable> {
  int selectedDayIndex = 0; // Default: Monday

  final List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  final List<int> dates = [14, 15, 16, 17, 18, 19];

  // Complete timetable data per day
  final Map<String, List<Map<String, String>>> timetableData = {
    'Mon': [
      {'subject': '23EC5204AB', 'time': '8:40 - 9:30 AM'},
      {'subject': '5301', 'time': '9:30 - 10:20 AM'},
      {'subject': '5302', 'time': '10:20 - 11:10 AM'},
      {'subject': 'BREAK', 'time': '11:10 - 11:20 AM'},
      {'subject': '5353', 'time': '11:20 - 12:10 PM'},
    ],
    'Tue': [
      {'subject': '23EC5204AB', 'time': '8:40 - 9:30 AM'},
      {'subject': 'Continuation of previous class', 'time': '9:30 - 10:20 AM'},
      {'subject': '5351/52', 'time': '10:20 - 11:10 AM'},
      {'subject': 'BREAK + Class continuation', 'time': '11:10 - 12:10 PM'},
      {'subject': '23EC5403ABCD', 'time': '12:10 - 1:00 PM'},
      {'subject': 'LUNCH', 'time': '1:00 - 2:00 PM'},
      {'subject': 'Continuation of LUNCH', 'time': '2:00 - 2:50 PM'},
      {'subject': '5607A/B/C/D', 'time': '2:50 - 3:40 PM'},
    ],
    'Wed': [
      {'subject': '23EC5204AB', 'time': '8:40 - 9:30 AM'},
      {'subject': '5301', 'time': '9:30 - 10:20 AM'},
      {'subject': '5302', 'time': '10:20 - 11:10 AM'},
      {'subject': 'BREAK + Class continuation', 'time': '11:10 - 12:10 PM'},
      {'subject': '23EC5403ABCD', 'time': '12:10 - 1:00 PM'},
      {'subject': 'LUNCH', 'time': '1:00 - 2:00 PM'},
    ],
    'Thu': [
      {'subject': 'M/H', 'time': '8:40 - 9:30 AM'},
      {'subject': '5301', 'time': '9:30 - 10:20 AM'},
      {'subject': '5302', 'time': '10:20 - 11:10 AM'},
      {'subject': 'BREAK + Class continuation', 'time': '11:10 - 12:10 PM'},
      {'subject': '23EC5403ABCD', 'time': '12:10 - 1:00 PM'},
      {'subject': 'LUNCH', 'time': '1:00 - 2:00 PM'},
      {'subject': '5353', 'time': '2:00 - 2:50 PM'},
      {'subject': '5353', 'time': '2:50 - 3:40 PM'},
    ],
    'Fri': [
      {'subject': 'M/H', 'time': '8:40 - 9:30 AM'},
      {'subject': '5301', 'time': '9:30 - 10:20 AM'},
      {'subject': '5302', 'time': '10:20 - 11:10 AM'},
      {'subject': 'BREAK', 'time': '11:10 - 11:20 AM'},
      {'subject': 'COUN / 23TP5106', 'time': '11:20 - 12:10 PM'},
      {'subject': '23EC5403ABCD', 'time': '12:10 - 1:00 PM'},
      {'subject': 'LUNCH + continuation', 'time': '1:00 - 2:50 PM'},
      {'subject': 'VALUE ADD', 'time': '2:50 - 3:40 PM'},
    ],
    'Sat': [
      {'subject': 'M/H', 'time': '8:40 - 9:30 AM'},
      {'subject': 'Continuation of previous class', 'time': '9:30 - 10:20 AM'},
      {'subject': 'Humanities', 'time': '10:20 - 11:10 AM'},
      {'subject': 'BREAK', 'time': '11:10 - 11:20 AM'},
      {'subject': 'Electives / 23TP5106', 'time': '11:20 - 12:10 PM'},
      {'subject': 'CLUB ACTIVITY', 'time': '12:10 - 1:00 PM'},
      {'subject': 'LUNCH', 'time': '1:00 - 2:00 PM'},
      {'subject': '5302', 'time': '2:00 - 2:50 PM'},
      {'subject': '5301', 'time': '2:50 - 3:40 PM'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final selectedDay = days[selectedDayIndex];
    final currentTimetable = timetableData[selectedDay]!;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          'Timetable',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0.5,
      ),
      body: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Flexible(
                  child: Text(
                    '14-07-2025 to 20-07-2025',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 8),
                Text(
                  'ECE-4',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            ),
          ),

          // Date Selector - FIXED
          Container(
            height: 80,
            color: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 4),
              itemCount: days.length,
              itemBuilder: (context, index) {
                bool isSelected = selectedDayIndex == index;
                return GestureDetector(
                  onTap: () => setState(() => selectedDayIndex = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 58,
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.black : Colors.transparent,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${dates[index]}',
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          days[index],
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black54,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Timetable List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: currentTimetable.length,
              itemBuilder: (context, index) {
                final item = currentTimetable[index];
                final isBreak =
                    item['subject']!.toUpperCase().contains('BREAK') ||
                        item['subject']!.toUpperCase().contains('LUNCH');

                if (isBreak) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    alignment: Alignment.center,
                    child: Text(
                      item['subject']!.toUpperCase(),
                      style: const TextStyle(
                        color: Colors.amber,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  );
                }

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.15),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    leading: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue.shade50,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Lecture',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 11,
                        ),
                      ),
                    ),
                    title: Text(
                      item['subject']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Text(
                        item['time']!,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
