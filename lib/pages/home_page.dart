import 'package:flutter/material.dart';

import '../components/habit_tile.dart';
import '../components/my_fab.dart';
import '../components/new_habit_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // data structure for today's list
  List todaysHabitList = [
    // [habitName, habitCompleted]
    ['Do exercise', false],
    ['Buy groceries', false],
    ['Code app', false],
  ];

  // checkbox is tapped
  void checkboxTapped(bool? value, int index) {
    setState(() {
      todaysHabitList[index][1] = value;
    });
  }

  // create a new habit
  void createNewHabit() {
    // show alert dialog
    showDialog(
      context: context,
      builder: (context) {
        return const EnterNewHabitBox();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      floatingActionButton: MyFloatingActionButton(
        onPressed: createNewHabit,
      ),
      body: ListView.builder(
        itemCount: todaysHabitList.length,
        itemBuilder: (context, index) {
          return HabitTile(
            habitName: todaysHabitList[index][0],
            habitCompleted: todaysHabitList[index][1],
            onChanged: (value) => checkboxTapped(value, index),
          );
        },
      ),
    );
  }
}
