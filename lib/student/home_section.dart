import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrsec_admin/util/exercise_title.dart';
import '../models/user_model.dart';
import '../student/events/class_timetable.dart';
import '../student/events/event.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({super.key});

  String _cleanDisplayName(String username) {
    if (username.trim().isEmpty) return 'User';
    final parts = username.trim().split(RegExp(r'\s+'));

    // If there are multiple parts, skip the first one (Google first name)
    // and return the rest (which should be the college ID)
    if (parts.length > 1) {
      return parts.sublist(1).join(' ');
    }

    // If only one part, return it as is
    return parts.join(' ');
  }

  @override
  Widget build(BuildContext context) {
    final userModel = Provider.of<UserModel>(context);
    final cleanedName = _cleanDisplayName(userModel.username).toUpperCase();

    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: SafeArea(
        child: Column(
          children: [
            // ---------------- Header ----------------
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top Row: Hi + Notification Icon
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          'Hi, $cleanedName',
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[600],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(10),
                        child: const Icon(
                          Icons.notifications,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  // Academic Info Row
                  Text(
                    '${userModel.branch.isNotEmpty ? userModel.branch : "Branch"} - '
                    '${userModel.semester.isNotEmpty ? userModel.semester : ""}'
                    '${userModel.section.isNotEmpty ? userModel.section : ""} | '
                    'Roll No. ${userModel.rollNumber.isNotEmpty ? userModel.rollNumber : "--"} | '
                    'Batch ${userModel.batch.isNotEmpty ? userModel.batch : "--"}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),

            // ---------------- Body ----------------
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(40)),
                child: Container(
                  padding: const EdgeInsets.all(25),
                  color: Colors.grey[200],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Section Header
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Dashboard',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Icon(Icons.more_horiz),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Scrollable Cards Section with Bouncing Physics
                      Expanded(
                        child: ListView(
                          physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics(),
                          ),
                          children: [
                            // --- Classes Block ---
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const ClassTimeTable(),
                                  ),
                                );
                              },
                              child: const ExerciseTitle(
                                icon: Icons.class_outlined,
                                exerciseName: 'Classes',
                                numberofExercises: 5,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // --- Upcoming Events Block ---
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const EventsPage(),
                                  ),
                                );
                              },
                              child: const ExerciseTitle(
                                icon: Icons.event,
                                exerciseName: 'Upcoming Events',
                                numberofExercises: 8,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // --- General Notice Block ---
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const BlankPage(
                                        title: 'General Notice'),
                                  ),
                                );
                              },
                              child: const ExerciseTitle(
                                icon: Icons.announcement,
                                exerciseName: 'General Notice',
                                numberofExercises: 20,
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BlankPage extends StatelessWidget {
  final String title;
  const BlankPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text(
          'This is a blank page for $title.',
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
