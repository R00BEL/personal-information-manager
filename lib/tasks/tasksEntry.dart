import 'package:flutter/material.dart';
import 'tasksModel.dart';

class TasksEntry extends StatefulWidget {
  final int? taskId;
  final VoidCallback onSave;

  const TasksEntry({super.key, this.taskId, required this.onSave});

  @override
  State<TasksEntry> createState() => _TasksEntryState();
}

class _TasksEntryState extends State<TasksEntry> {
  final _formKey = GlobalKey<FormState>();
  late String _title;

  @override
  void initState() {
    super.initState();
    if (widget.taskId != null) {
      final task = tasksModel.tasks.firstWhere((task) => task.id == widget.taskId);
      _title = task.title;
    } else {
      _title = '';
    }
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (widget.taskId == null) {
        tasksModel.addTask(_title);
      } else {
        tasksModel.updateTask(widget.taskId!, _title);
      }
      widget.onSave();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add/Edit Task")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(labelText: "Task Title"),
                validator: (value) =>
                value == null || value.isEmpty ? "Title is required" : null,
                onSaved: (value) => _title = value!,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveTask,
                child: const Text("Save"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
