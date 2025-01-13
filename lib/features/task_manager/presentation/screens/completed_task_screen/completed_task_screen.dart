import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/features/task_manager/presentation/screens/task_detail_screen/task_detail_screen.dart';
import 'package:task_manager/features/task_manager/presentation/widgets/task_tile.dart';
import '../../blocs/task_bloc/task_bloc.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Completed Tasks"),
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskLoadedState) {
            final tasks = state.tasks;

            if (tasks.isEmpty) {
              return const Center(child: Text("No completed tasks."));
            }

            return ListView.builder(
              itemCount: tasks.where((v) => v.isCompleted).toList().length,
              itemBuilder: (context, index) {
                final task = tasks.where((v) => v.isCompleted).toList()[index];
                return TaskCard(
                  task: task,
                  onToggleComplete: (isCompleted) {
                    context.read<TaskBloc>().add(
                          UpdateTaskEvent(
                              task.copyWith(isCompleted: isCompleted)),
                        );
                  },
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskDetailScreen(task: task),
                      ),
                    );
                  },
                  // onDelete: () => _showDeleteConfirmation(context, task.id),
                );
              },
            );
          } else if (state is TaskErrorState) {
            return Center(child: Text("Error: ${state.message}"));
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
