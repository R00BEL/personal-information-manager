import 'package:flutter/material.dart';
import 'tasksModel.dart';

class TasksList extends StatelessWidget {
  final VoidCallback onAdd;
  final Function(int) onEdit;

  const TasksList({super.key, required this.onAdd, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tasks")),
      body: AnimatedBuilder(
        animation: tasksModel,
        builder: (context, _) {
          final tasks = tasksModel.tasks;

          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];

              return ListTile(
                title: Text(
                  task.title,
                  style: TextStyle(
                    decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                leading: Checkbox(
                  value: task.isCompleted,
                  onChanged: (_) => tasksModel.toggleTaskCompletion(task.id),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => onEdit(task.id),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => tasksModel.deleteTask(task.id),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onAdd,
        child: const Icon(Icons.add),
      ),
    );
  }
}
