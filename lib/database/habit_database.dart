import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:myapp/config/app_settings.dart';
import 'package:myapp/models/habit.dart';
import 'package:path_provider/path_provider.dart';

class HabitDatabase extends ChangeNotifier {

  static late Isar isar;

  static Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [HabitSchema, AppSettingsSchema],
       directory: dir.path);
  }

  Future<void> saveFirstLaunchDate() async {
    final exististingSettings = await isar.appSettings.where().findFirst();
    if (exististingSettings == null) {
      final settings = AppSettings()..firstLaunchDate = DateTime.now();
      await isar.writeTxn(() async {
        await isar.appSettings.put(settings);
      });
    
    }
    
    
  }
  Future<DateTime?> getFirstLaunchDate() async {
      final settings = await isar.appSettings.where().findFirst();
      return settings?.firstLaunchDate;
    }

  final List<Habit> currentHabits  = [];

  Future<void> addHabit(String habitName) async {
    final newHabit = Habit()..name = habitName;
    await isar.writeTxn(() => isar.habits.put(newHabit)
    );
    readHabits();
  }

  Future<void> readHabits() async {
    List<Habit> habits = await isar.habits.where().findAll();
    currentHabits.clear();
    currentHabits.addAll(habits);
    notifyListeners();
  }

  Future<void> updateHabitCompletion(int id, bool isCompleted) async {
    final habit = await isar.habits.get(id);
    
    if (habit != null) {
      await isar.writeTxn(
        () async {
         if (isCompleted && !habit.completedDays.contains(DateTime.now())) {

           final today = DateTime.now();
           habit.completedDays.add(
            DateTime(
              today.year,
              today.month,
              today.day)
           );

         } else {
           
           habit.completedDays.removeWhere(
            (date) => date.year == DateTime.now().year &&
            date.month == DateTime.now().month &&
            date.day == DateTime.now().day
           );
         }

         await isar.habits.put(habit);
        }
      );
      readHabits();
    }
    
   
  }
   Future<void> updateHabit(int id, String newName) {
      return isar.writeTxn(() async {
        final habit = await isar.habits.get(id);
        if (habit != null) {
          habit.name = newName;
          await isar.habits.put(habit);
        }

      });
      readHabits();
    }

    Future<void> deleteHabit(int id) async {
      await isar.writeTxn(() async {
        await isar.habits.delete(id);
      });
      readHabits();
    }
    
  
}