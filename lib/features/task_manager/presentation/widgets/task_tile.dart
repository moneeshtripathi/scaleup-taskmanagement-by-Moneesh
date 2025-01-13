import 'package:flutter/material.dart';
import 'package:task_manager/features/task_manager/data/models/task_model.dart';

class TaskCard extends StatelessWidget {
  final TaskModel task;
  final Function(bool) onToggleComplete;
  final VoidCallback onTap;
  final VoidCallback? onDelete;

  const TaskCard({
    super.key,
    required this.task,
    required this.onToggleComplete,
    required this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        title: Text(task.title),
        subtitle: Text('Due: ${task.dueDate.toLocal()}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: task.isCompleted,
              onChanged: (value) => onToggleComplete(value!),
            ),
            onDelete != null
                ? IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: onDelete ?? () {},
                  )
                : SizedBox.shrink(),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
