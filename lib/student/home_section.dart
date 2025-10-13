import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrsec_admin/util/exercise_title.dart';

import '../models/user_model.dart'; // Ensure this is the correct path to your UserModel

class HomeSection extends StatelessWidget {
  const HomeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access the UserModel from the Provider
    final userModel = Provider.of<UserModel>(context);

    // Extract the last part of the username
    final String lastName = userModel.username.split(' ').last;

    return Scaffold(
      backgroundColor: Colors.blue[800],
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Greetings row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Hi Student!
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi, $lastName!', // Display the last part of the username
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '05 Jan, 2024',
                            style: TextStyle(color: Colors.blue[100]),
                          ),
                        ],
                      ),

                      // Notifications
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.blue[600],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(12),
                        child: const Icon(
                          Icons.notifications,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),

                  // Search bar
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[600],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: const [
                        Icon(Icons.search, color: Colors.white),
                        SizedBox(width: 5),
                        Text(
                          'Search',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 25),

            // Main content area
            Expanded(
              child: ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(50)),
                child: Container(
                  padding: EdgeInsets.all(25),
                  color: Colors.grey[200],
                  child: Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Upcoming Events',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Icon(Icons.more_horiz),
                          ],
                        ),

                        SizedBox(
                          height: 20,
                        ),

                        // listview of events
                        Expanded(
                          child: ListView(
                            physics: const BouncingScrollPhysics(
                                parent:
                                    AlwaysScrollableScrollPhysics()), // Enable bouncing physics
                            scrollDirection: Axis
                                .vertical, // Set scroll direction to vertical
                            children: [
                              ExerciseTitle(
                                icon: Icons.favorite,
                                exerciseName: 'New Event',
                                numberofExercises: 16,
                              ),
                              ExerciseTitle(
                                icon: Icons.person,
                                exerciseName: 'Attention Needed',
                                numberofExercises: 8,
                              ),
                              ExerciseTitle(
                                icon: Icons.star,
                                exerciseName: 'Attention',
                                numberofExercises: 20,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
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
