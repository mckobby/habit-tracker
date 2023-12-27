import 'package:flutter/material.dart';
import 'package:habit_tracker/data/habit_db.dart';
import 'package:hive/hive.dart';

import '../components/habit_tile.dart';
import '../components/my_fab.dart';
import '../components/my_alert_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HabitDb db = HabitDb();
  final mybox = Hive.box('habit_db');
  

  @override
  void initState() {
    // if this is the first time ever opening the app, run this method
    if (mybox.get('Current_Habit_List') == null) {
      db.createDefaultData();
    } else {
      // data already exists
      db.loadData();
    }

    // update the database
    db.updateDatabase();
    super.initState();
  }

  // checkbox is tapped
  void checkboxTapped(bool? value, int index) {
    setState(() {
      db.todaysHabitList[index][1] = value;
    });
    db.updateDatabase();
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
        db.todaysHabitList.add([newHabitNameController.text, false]);
      }
    });
    // clear textfield
    newHabitNameController.clear();
    // pop dialog box
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  // cancel dialog box
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
          hintText: db.todaysHabitList[index][0],
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
        db.todaysHabitList[index][0] = newHabitNameController.text;
      }
    });
    // clear textfield
    newHabitNameController.clear();
    // pop dialog box
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  // delete habit
  void deleteHabit(int index) {
    setState(() {
      db.todaysHabitList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan[50],
      floatingActionButton: MyFloatingActionButton(
        onPressed: createNewHabit,
      ),
      body: ListView.builder(
        itemCount: db.todaysHabitList.length,
        itemBuilder: (context, index) {
          return HabitTile(
            habitName: db.todaysHabitList[index][0],
            habitCompleted: db.todaysHabitList[index][1],
            onChanged: (value) => checkboxTapped(value, index),
            editTapped: (context) => openHabitEdit(index),
            deleteTapped: (context) => deleteHabit(index),
          );
        },
      ),
    );
  }
}
