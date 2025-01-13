import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/features/task_manager/presentation/blocs/task_bloc/task_bloc.dart';
import 'package:task_manager/features/task_manager/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:task_manager/features/task_manager/presentation/blocs/theme_bloc/theme_event.dart';
import 'package:task_manager/features/task_manager/presentation/screens/add_edit_task_screen/add_edit_task_screen.dart';
import 'package:task_manager/features/task_manager/presentation/screens/completed_task_screen/completed_task_screen.dart';
import 'package:task_manager/features/task_manager/presentation/screens/task_detail_screen/task_detail_screen.dart';
import 'package:task_manager/features/task_manager/presentation/widgets/category_filter_drop_down.dart';
import 'package:task_manager/features/task_manager/presentation/widgets/completed_task_toggle.dart';
import 'package:task_manager/features/task_manager/presentation/widgets/task_tile.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Open filter modal
              showModalBottomSheet(
                context: context,
                builder: (context) => FilterModal(
                  onFilterSelected: (filter) {
                    context
                        .read<TaskBloc>()
                        .add(FilterTasksEvent(category: filter));
                  },
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskLoadedState) {
            if (state.filteredTasks.isEmpty) {
              return const Center(
                child: Text('No tasks available. Add some!'),
              );
            }
            return ListView.builder(
              itemCount: state.filteredTasks.length,
              itemBuilder: (context, index) {
                final task = state.filteredTasks[index];
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
                  onDelete: () => _showDeleteConfirmation(context, task.id),
                );
              },
            );
          } else if (state is TaskErrorState) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTaskScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Center(
                child: Text(
                  'Task Manager',
                  style: TextStyle(fontSize: 24),
                ),
              ),
            ),
            ListTile(
              title: const Text('Completed Tasks'),
              onTap: () async {
                Navigator.pop(context);
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const CompletedTasksScreen(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Dark Mode'),
              trailing: const Icon(Icons.brightness_6),
              onTap: () {
                Navigator.pop(context);
                context.read<ThemeBloc>().add(ToggleThemeEvent());
              },
            ),
          ],
        ),
      ),
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
            Navigator.pop(context);
            context.read<TaskBloc>().add(FetchTasksEvent());
          },
          onCancel: () {
            Navigator.pop(context);
          },
        );
      },
    );
  }
}
