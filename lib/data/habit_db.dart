import 'package:habit_tracker/datetime/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';

// reference our box
final myBox = Hive.box('habit_db');

class HabitDb {
  List todaysHabitList = [];

  // create initial default data
  void createDefaultData() {
    todaysHabitList = [
      ['Run', false],
      ['Push up', false]
    ];

    myBox.put('Start_Date', todaysDateFormatted());
  }

  // load existing data
  void loadData() {
    // if it's a new day, get habit list from database
    if (myBox.get(todaysDateFormatted()) == null) {
      todaysHabitList = myBox.get('Current_Habit_List');
      // set all habit completed to false since it's a new day
      for (int i = 0; i < todaysHabitList.length; i++) {
        todaysHabitList[i][1] = false;
      }
    } else {
      // if it's not a new day, load today's list
      todaysHabitList = myBox.get(todaysDateFormatted());
    }

    
  }

  // update database
  void updateDatabase() {
    // update today's entry
    myBox.put(todaysDateFormatted(), todaysHabitList);

    // update general habit list
    myBox.put('Current_Habit_List', todaysHabitList);
  }
}