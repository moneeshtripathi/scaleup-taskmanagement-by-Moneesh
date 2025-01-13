import 'package:task_manager/features/task_manager/data/models/task_model.dart';

abstract class TaskRepository {
  Future<void> addTask(TaskModel task);
  Future<void> updateTask(TaskModel task);
  Future<void> deleteTask(String taskId);
  Future<List<TaskModel>> fetchAllTasks();
  Future<List<TaskModel>> fetchTasksByCategory(String category);
  Future<List<TaskModel>> fetchTasksByCompletion(bool isCompleted);
}
