import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task_manager/features/task_manager/data/models/task_model.dart';
import 'package:task_manager/features/task_manager/domain/usecases/add_task_use_case.dart';
import 'package:task_manager/features/task_manager/domain/usecases/delete_task_use_case.dart';
import 'package:task_manager/features/task_manager/domain/usecases/fetch_task_by_category.dart';
import 'package:task_manager/features/task_manager/domain/usecases/fetch_tasks_use_case.dart';
import 'package:task_manager/features/task_manager/domain/usecases/sort_task_usecase.dart';
import 'package:task_manager/features/task_manager/domain/usecases/update_task_use_case.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final AddTaskUseCase addTask;
  final UpdateTaskUseCase updateTask;
  final DeleteTaskUseCase deleteTask;
  final FetchAllTasksUseCase fetchAllTasks;
  final FetchTasksByCategoryUseCase fetchTasksByCategory;
  final SortTasksUseCase sortTasks;

  List<TaskModel> _tasks = []; // Cache for all tasks

  TaskBloc({
    required this.addTask,
    required this.updateTask,
    required this.deleteTask,
    required this.fetchAllTasks,
    required this.fetchTasksByCategory,
    required this.sortTasks,
  }) : super(TaskLoadingState()) {
    on<FetchTasksEvent>((event, emit) async {
      emit(TaskLoadingState());
      try {
        _tasks = await fetchAllTasks();
        emit(TaskLoadedState(tasks: _tasks, filteredTasks: _tasks));
      } catch (error) {
        emit(TaskErrorState(error.toString()));
      }
    });

    on<AddTaskEvent>((event, emit) async {
      try {
        await addTask(event.task);
        _tasks.add(event.task);
        emit(TaskLoadedState(tasks: _tasks, filteredTasks: _tasks));
      } catch (error) {
        emit(TaskErrorState(error.toString()));
      }
    });

    on<UpdateTaskEvent>((event, emit) async {
      try {
        await updateTask(event.task);
        _tasks = _tasks
            .map((task) => task.id == event.task.id ? event.task : task)
            .toList();
        emit(TaskLoadedState(tasks: _tasks, filteredTasks: _tasks));
      } catch (error) {
        emit(TaskErrorState(error.toString()));
      }
    });

    on<DeleteTaskEvent>((event, emit) async {
      try {
        await deleteTask(event.taskId);
        _tasks.removeWhere((task) => task.id == event.taskId);
        emit(TaskLoadedState(tasks: _tasks, filteredTasks: _tasks));
      } catch (error) {
        emit(TaskErrorState(error.toString()));
      }
    });

    on<FilterTasksEvent>((event, emit) {
      final filtered = event.category == null || event.category!.isEmpty
          ? _tasks
          : _tasks.where((task) => task.category == event.category).toList();

      emit(TaskLoadedState(
          tasks: _tasks,
          filteredTasks: filtered,
          filterCategory: event.category));
    });

    on<SortTasksEvent>((event, emit) {
      final sorted = sortTasks(_tasks, sortBy: event.sortBy);
      emit(TaskLoadedState(tasks: sorted, filteredTasks: sorted));
    });
  }
}
