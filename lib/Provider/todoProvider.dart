import 'package:flutter/material.dart';
import 'package:revision/modals/taskModal.dart';
import 'package:revision/sharedPreference/share_preference_helper.dart';

class TaskProvider extends ChangeNotifier {
  TaskProvider() {
    loadTasks();
  }
  List<TaskModal> _tasks = [];

  List<TaskModal> get tasks => _tasks;

  Future<void> loadTasks() async {
    _tasks = await SharedPrefHelper.getTasks('tasks');
    notifyListeners();
  }

  Future<void> addTask(TaskModal task) async {
    _tasks.add(task);
    await SharedPrefHelper.setTasks(_tasks);
    notifyListeners();
  }

  Future<void> updateTask(int index, TaskModal task) async {
    if (index >= 0 && index < _tasks.length) {
      _tasks[index] = task;
      await SharedPrefHelper.setTasks(_tasks);
      notifyListeners();
    }
  }

  Future<void> deleteTask(int index) async {
    if (index >= 0 && index < _tasks.length) {
      _tasks.removeAt(index);
      await SharedPrefHelper.setTasks(_tasks);
      notifyListeners();
    }
  }

  // Toggle completion
  Future<void> toggleCompletion(int index) async {
    if (index >= 0 && index < _tasks.length) {
      _tasks[index].isCompleted = !_tasks[index].isCompleted;
      await SharedPrefHelper.setTasks(_tasks);
      notifyListeners();
    }
  }
}
