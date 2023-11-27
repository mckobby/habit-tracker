import 'package:flutter/material.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final bool habitCompleted;
  Function(bool?)? onChanged;

  HabitTile({
    super.key,
    required this.habitName,
    required this.habitCompleted,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(height * 0.02),
      child: Container(
        padding: EdgeInsets.all(height * 0.015),
        decoration: BoxDecoration(
          color: Colors.cyan[300],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            // checkbox
            Checkbox(
              value: habitCompleted,
              onChanged: onChanged,
            ),
            // habit name
            Text(
              habitName,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
