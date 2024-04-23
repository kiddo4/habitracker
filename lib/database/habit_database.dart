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

  
  
}