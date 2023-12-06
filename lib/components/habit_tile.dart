import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final bool habitCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? editTapped;
  final Function(BuildContext)? deleteTapped;


  const HabitTile({
    super.key,
    required this.habitName,
    required this.habitCompleted,
    required this.onChanged,
    required this.editTapped,
    required this.deleteTapped,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    // final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.all(height * 0.02),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            // edit
            SlidableAction(
              onPressed: editTapped,
              backgroundColor: Colors.grey,
              icon: Icons.edit,
              borderRadius: BorderRadius.circular(10),
            ),
            // delete
            SlidableAction(
              onPressed: deleteTapped,
              backgroundColor: Colors.red,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(10),
            ),
          ],
        ),
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
      ),
    );
  }
}
