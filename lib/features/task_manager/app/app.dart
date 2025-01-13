import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:task_manager/features/task_manager/data/models/task_model.dart';
import 'package:task_manager/features/task_manager/data/repositories/task_repository_impl.dart';
import 'package:task_manager/features/task_manager/domain/usecases/add_task_use_case.dart';
import 'package:task_manager/features/task_manager/domain/usecases/delete_task_use_case.dart';
import 'package:task_manager/features/task_manager/domain/usecases/fetch_task_by_category.dart';
import 'package:task_manager/features/task_manager/domain/usecases/fetch_tasks_use_case.dart';
import 'package:task_manager/features/task_manager/domain/usecases/sort_task_usecase.dart';
import 'package:task_manager/features/task_manager/domain/usecases/update_task_use_case.dart';
import 'package:task_manager/features/task_manager/presentation/blocs/task_bloc/task_bloc.dart';
import 'package:task_manager/features/task_manager/presentation/blocs/theme_bloc/theme_bloc.dart';
import 'package:task_manager/features/task_manager/presentation/blocs/theme_bloc/theme_state.dart';
import 'package:task_manager/features/task_manager/presentation/screens/task_list_screen/task_list_screen.dart';

class TaskManagerApp extends StatelessWidget {
  final Box<TaskModel> tasksBox;

  const TaskManagerApp({super.key, required this.tasksBox});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => TaskBloc(
            addTask:
                AddTaskUseCase(TaskRepositoryImpl(localDataSource: tasksBox)),
            updateTask: UpdateTaskUseCase(
                TaskRepositoryImpl(localDataSource: tasksBox)),
            deleteTask: DeleteTaskUseCase(
                TaskRepositoryImpl(localDataSource: tasksBox)),
            fetchAllTasks: FetchAllTasksUseCase(
                TaskRepositoryImpl(localDataSource: tasksBox)),
            fetchTasksByCategory: FetchTasksByCategoryUseCase(
                TaskRepositoryImpl(localDataSource: tasksBox)),
            sortTasks: SortTasksUseCase(),
          )..add(FetchTasksEvent()),
        ),
        BlocProvider(
          create: (_) => ThemeBloc(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: themeState.themeData,
          home: TaskListScreen(),
        );
      }),
    );
  }
}
