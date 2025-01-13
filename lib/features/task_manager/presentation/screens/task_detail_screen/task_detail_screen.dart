import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/features/task_manager/data/models/task_model.dart';
import 'package:task_manager/features/task_manager/presentation/blocs/task_bloc/task_bloc.dart';
import 'package:task_manager/features/task_manager/presentation/screens/add_edit_task_screen/add_edit_task_screen.dart';
import 'package:task_manager/features/task_manager/presentation/widgets/completed_task_toggle.dart';

class TaskDetailScreen extends StatelessWidget {
  final TaskModel task;

  const TaskDetailScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTaskScreen(
                    taskToEdit: task,
                  ),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => _showDeleteConfirmation(context, task.id),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow('Title:', task.title),
            const SizedBox(height: 8.0),
            _buildDetailRow('Description:', task.description),
            const SizedBox(height: 8.0),
            _buildDetailRow('Due Date:', task.dueDate.toLocal().toString()),
            const SizedBox(height: 8.0),
            _buildDetailRow('Category:', task.category),
            const SizedBox(height: 8.0),
            _buildDetailRow(
              'Status:',
              task.isCompleted ? 'Completed' : 'Pending',
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                context.read<TaskBloc>().add(
                      UpdateTaskEvent(
                        task.copyWith(isCompleted: !task.isCompleted),
                      ),
                    );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      task.isCompleted
                          ? 'Task marked as pending.'
                          : 'Task marked as completed.',
                    ),
                  ),
                );
              },
              child: Text(
                task.isCompleted ? 'Mark as Pending' : 'Mark as Completed',
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label ',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(color: Colors.black87),
          ),
        ),
      ],
    );
  }

  void _showDeleteConfirmation(BuildContext context, String taskId) {
    showDialog(
      context: context,
      builder: (context) {
        return ConfirmationDialog(
          title: 'Delete Task',
          message: 'Are you sure you want to delete this task?',
          onConfirm: () {
            context.read<TaskBloc>().add(DeleteTaskEvent(taskId));
            Navigator.pop(context); // Close the dialog
            Navigator.pop(context); // Go back to Task List Screen
          },
          onCancel: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
