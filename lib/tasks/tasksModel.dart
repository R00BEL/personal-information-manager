import 'package:flutter/material.dart';

class Task {
  final int id;
  final String title;
  final bool isCompleted;

  Task({
    required this.id,
    required this.title,
    this.isCompleted = false,
  });
}

class TasksModel with ChangeNotifier {
  List<Task> _tasks = [];
  int _nextId = 1;

  List<Task> get tasks => List.unmodifiable(_tasks);

  void addTask(String title) {
    _tasks.add(Task(id: _nextId++, title: title));
    notifyListeners();
  }

  void toggleTaskCompletion(int id) {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      final task = _tasks[index];
      _tasks[index] = Task(
        id: task.id,
        title: task.title,
        isCompleted: !task.isCompleted,
      );
      notifyListeners();
    }
  }

  void updateTask(int id, String title) {
    final index = _tasks.indexWhere((task) => task.id == id);
    if (index != -1) {
      _tasks[index] = Task(id: id, title: title, isCompleted: _tasks[index].isCompleted);
      notifyListeners();
    }
  }

  void deleteTask(int id) {
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }
}

final tasksModel = TasksModel();
