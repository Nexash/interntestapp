import 'dart:convert';

import 'package:revision/modals/taskModal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static const String _taskKey = 'tasks';

  // Save Tasks
  static Future<void> setTasks(List<TaskModal> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> taskJsonList =
        tasks.map((task) => jsonEncode(task.toJson())).toList();

    await prefs.setStringList(_taskKey, taskJsonList);
  }

  // Get String
  static Future<List<TaskModal>> getTasks(String key) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? taskJsonList = prefs.getStringList(_taskKey);

    if (taskJsonList == null) return [];

    return taskJsonList
        .map((task) => TaskModal.fromJson(jsonDecode(task)))
        .toList();
  }

  // Save Bool
  static Future<void> setBool(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
  }

  // Get Bool
  static Future<bool?> getBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(key);
  }

  // Remove Key
  static Future<void> clearTasks(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('tasks');
  }

  // Clear all tasks
  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
