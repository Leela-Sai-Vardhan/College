import 'package:flutter/material.dart';

class ExerciseTitle extends StatelessWidget {
  final IconData icon;
  final String exerciseName;
  final int numberofExercises;

  const ExerciseTitle({
    super.key,
    required this.icon,
    required this.exerciseName,
    required this.numberofExercises,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.blue, // Optional: Add color to icons
          ),
          title: Text(
            exerciseName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text('$numberofExercises Exercises Needing Attention'),
          trailing: const Icon(Icons.more_horiz),
        ),
      ),
    );
  }
}
