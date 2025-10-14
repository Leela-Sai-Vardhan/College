import 'package:flutter/material.dart';
import 'package:vrsec_admin/util/exercise_title.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[800],
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Upcoming Events',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 20),
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
                            'All Events',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          Icon(Icons.filter_list),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Scrollable Events List with Bouncing Physics
                      Expanded(
                        child: ListView(
                          physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics(),
                          ),
                          children: [
                            // --- Innovation Day 2025 ---
                            GestureDetector(
                              onTap: () {
                                _showEventDetails(
                                    context,
                                    'Innovation Day 2025',
                                    'Annual technical festival with coding competitions, workshops, and tech talks.');
                              },
                              child: const ExerciseTitle(
                                icon: Icons.computer,
                                exerciseName: 'Innovation Day 2025',
                                numberofExercises: 15,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // --- Sports Day ---
                            GestureDetector(
                              onTap: () {
                                _showEventDetails(context, 'Sports Day',
                                    'Inter-department sports competition including cricket, football, and athletics.');
                              },
                              child: const ExerciseTitle(
                                icon: Icons.sports_cricket,
                                exerciseName: 'Sports Day',
                                numberofExercises: 10,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // --- Cultural Fest ---
                            GestureDetector(
                              onTap: () {
                                _showEventDetails(context, 'Cultural Fest',
                                    'Celebrate diversity with music, dance, drama, and art exhibitions.');
                              },
                              child: const ExerciseTitle(
                                icon: Icons.theater_comedy,
                                exerciseName: 'Cultural Fest',
                                numberofExercises: 12,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // --- Hackathon 2024 ---
                            GestureDetector(
                              onTap: () {
                                _showEventDetails(context, 'Hackathon 2024',
                                    '24-hour coding marathon to build innovative solutions for real-world problems.');
                              },
                              child: const ExerciseTitle(
                                icon: Icons.code,
                                exerciseName: 'Hackathon 2024',
                                numberofExercises: 8,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // --- Guest Lecture ---
                            GestureDetector(
                              onTap: () {
                                _showEventDetails(context, 'Guest Lecture',
                                    'Industry expert talk on emerging technologies and career opportunities.');
                              },
                              child: const ExerciseTitle(
                                icon: Icons.person,
                                exerciseName: 'Guest Lecture',
                                numberofExercises: 5,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // --- Workshop: AI & ML ---
                            GestureDetector(
                              onTap: () {
                                _showEventDetails(context, 'Workshop: AI & ML',
                                    'Hands-on workshop on Artificial Intelligence and Machine Learning fundamentals.');
                              },
                              child: const ExerciseTitle(
                                icon: Icons.psychology,
                                exerciseName: 'Workshop: AI & ML',
                                numberofExercises: 6,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // --- Annual Day ---
                            GestureDetector(
                              onTap: () {
                                _showEventDetails(context, 'Annual Day',
                                    'Celebrating the college\'s achievements with awards, performances, and gatherings.');
                              },
                              child: const ExerciseTitle(
                                icon: Icons.celebration,
                                exerciseName: 'Annual Day',
                                numberofExercises: 20,
                              ),
                            ),
                            const SizedBox(height: 8),

                            // --- Placement Drive ---
                            GestureDetector(
                              onTap: () {
                                _showEventDetails(context, 'Placement Drive',
                                    'On-campus recruitment drive by top companies for final year students.');
                              },
                              child: const ExerciseTitle(
                                icon: Icons.work,
                                exerciseName: 'Placement Drive',
                                numberofExercises: 25,
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

  void _showEventDetails(
      BuildContext context, String eventName, String description) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(eventName),
        content: Text(description),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Registered for $eventName!'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Register'),
          ),
        ],
      ),
    );
  }
}
