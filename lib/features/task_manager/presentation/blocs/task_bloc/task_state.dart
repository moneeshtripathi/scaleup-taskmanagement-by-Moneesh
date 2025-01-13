part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TaskLoadingState extends TaskState {}

class TaskLoadedState extends TaskState {
  final List<TaskModel> tasks;
  final List<TaskModel> filteredTasks;
  final String? filterCategory;

  TaskLoadedState({
    required this.tasks,
    required this.filteredTasks,
    this.filterCategory,
  });

  @override
  List<Object?> get props => [tasks, filteredTasks, filterCategory];
}

class TaskErrorState extends TaskState {
  final String message;

  TaskErrorState(this.message);

  @override
  List<Object?> get props => [message];
}
