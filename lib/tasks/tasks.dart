import 'package:flutter/material.dart';
import 'tasksList.dart';
import 'tasksEntry.dart';
import 'tasksModel.dart';

class Tasks extends StatefulWidget {
  const Tasks({super.key});

  @override
  State<Tasks> createState() => _TasksState();
}

class _TasksState extends State<Tasks> {
  int _currentIndex = 0;
  int? _editingTaskId;

  void _showEntryScreen([int? taskId]) {
    setState(() {
      _currentIndex = 1;
      _editingTaskId = taskId;
    });
  }

  void _showListScreen() {
    setState(() {
      _currentIndex = 0;
      _editingTaskId = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: _currentIndex,
      children: [
        TasksList(onAdd: _showEntryScreen, onEdit: _showEntryScreen),
        TasksEntry(taskId: _editingTaskId, onSave: _showListScreen),
      ],
    );
  }
}
