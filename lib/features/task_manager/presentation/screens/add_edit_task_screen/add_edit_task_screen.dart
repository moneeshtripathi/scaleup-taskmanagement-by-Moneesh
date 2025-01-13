import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/core/utils/constants.dart';
import 'package:task_manager/features/task_manager/data/models/task_model.dart';
import 'package:task_manager/features/task_manager/presentation/blocs/task_bloc/task_bloc.dart';
import 'package:task_manager/features/task_manager/presentation/widgets/task_form.dart';
import 'package:uuid/uuid.dart';

class AddTaskScreen extends StatelessWidget {
  final TaskModel? taskToEdit;

  const AddTaskScreen({super.key, this.taskToEdit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(taskToEdit == null ? 'Add New Task' : 'Edit Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TaskForm(
          initialTitle: taskToEdit?.title,
          initialDescription: taskToEdit?.description,
          initialDueDate: taskToEdit?.dueDate,
          initialCategory: taskToEdit?.category,
          categories: AppConstants.categories,
          onSubmit: (title, description, dueDate, category) {
            final taskBloc = context.read<TaskBloc>();

            if (taskToEdit == null) {
              // Add new task
              final newTask = TaskModel(
                id: const Uuid().v4(), // Generating unique ID
                title: title,
                description: description,
                dueDate: dueDate,
                category: category,
                isCompleted: false, // Default value for a new task
              );

              taskBloc.add(AddTaskEvent(newTask));
            } else {
              // Update existing task
              final updatedTask = taskToEdit!.copyWith(
                title: title,
                description: description,
                dueDate: dueDate,
                category: category,
              );

              taskBloc.add(UpdateTaskEvent(updatedTask));
            }
            taskBloc.add(FetchTasksEvent());
            // Navigate back once the form is submitted
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
