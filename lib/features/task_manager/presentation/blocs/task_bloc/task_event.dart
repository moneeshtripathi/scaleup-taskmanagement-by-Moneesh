part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchTasksEvent extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final TaskModel task;

  AddTaskEvent(this.task);

  @override
  List<Object> get props => [task];
}

class UpdateTaskEvent extends TaskEvent {
  final TaskModel task;

  UpdateTaskEvent(this.task);

  @override
  List<Object> get props => [task];
}

class DeleteTaskEvent extends TaskEvent {
  final String taskId;

  DeleteTaskEvent(this.taskId);

  @override
  List<Object> get props => [taskId];
}

class FilterTasksEvent extends TaskEvent {
  final String? category;

  FilterTasksEvent({this.category});

  @override
  List<Object> get props => [category ?? ''];
}

class SortTasksEvent extends TaskEvent {
  final String sortBy;

  SortTasksEvent({required this.sortBy});

  @override
  List<Object> get props => [sortBy];
}
