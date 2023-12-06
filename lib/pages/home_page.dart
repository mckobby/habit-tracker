import 'package:flutter/material.dart';

import '../components/habit_tile.dart';
import '../components/my_fab.dart';
import '../components/my_alert_box.dart';

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

  final newHabitNameController = TextEditingController();

  // create a new habit
  void createNewHabit() {
    // show alert dialog
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: newHabitNameController,
          hintText: 'Enter habit name',
          onSave: saveNewHabit,
          onCancel: cancelDialogBox,
        );
      },
    );
  }

  // save new habit
  void saveNewHabit() {
    // add new habit to the list
    setState(() {
      if (newHabitNameController.text.isNotEmpty) {
        todaysHabitList.add([newHabitNameController.text, false]);
      }
    });
    // clear textfield
    newHabitNameController.clear();
    // pop dialog box
    Navigator.of(context).pop();
  }

  // cancel new habit
  void cancelDialogBox() {
    // clear textfield
    newHabitNameController.clear();
    // pop dialog box
    Navigator.of(context).pop();
  }

  // edit habit
  void openHabitEdit(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return MyAlertBox(
          controller: newHabitNameController,
          hintText: todaysHabitList[index][0],
          onSave: () => saveExistingHabit(index),
          onCancel: cancelDialogBox,
        );
      },
    );
  }

  // save existing habit with different name
  void saveExistingHabit(int index) {
    setState(() {
      if (newHabitNameController.text.isNotEmpty) {
        todaysHabitList[index][0] = newHabitNameController.text;
      }
    });
    // clear textfield
    newHabitNameController.clear();
    // pop dialog box
    Navigator.of(context).pop();
  }

  // delete habit
  void deleteHabit(int index) {
    setState(() {
      todaysHabitList.removeAt(index);
    });
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
            editTapped: (context) => openHabitEdit(index),
            deleteTapped: (context) => deleteHabit(index),
          );
        },
      ),
    );
  }
}
