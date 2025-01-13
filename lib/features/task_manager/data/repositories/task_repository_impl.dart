// ignore: depend_on_referenced_packages
import 'package:hive/hive.dart';
import 'package:task_manager/features/task_manager/data/models/task_model.dart';
import '../../domain/repositories/task_repository.dart';

class TaskRepositoryImpl implements TaskRepository {
  final Box<TaskModel> localDataSource;

  TaskRepositoryImpl({required this.localDataSource});

  @override
  Future<void> addTask(TaskModel task) async {
    try {
      await localDataSource.put(task.id, task);
    } catch (e) {
      throw Exception("Failed to add task: $e");
    }
  }

  @override
  Future<void> updateTask(TaskModel task) async {
    try {
      await localDataSource.put(task.id, task);
    } catch (e) {
      throw Exception("Failed to update task: $e");
    }
  }

  @override
  Future<void> deleteTask(String taskId) async {
    try {
      await localDataSource.delete(taskId);
    } catch (e) {
      throw Exception("Failed to delete task: $e");
    }
  }

  @override
  Future<List<TaskModel>> fetchAllTasks() async {
    try {
      return localDataSource.values.toList();
    } catch (e) {
      throw Exception("Failed to fetch all tasks: $e");
    }
  }

  @override
  Future<List<TaskModel>> fetchTasksByCategory(String category) async {
    try {
      return localDataSource.values
          .where((task) => task.category == category)
          .toList();
    } catch (e) {
      throw Exception("Failed to fetch tasks by category: $e");
    }
  }

  @override
  Future<List<TaskModel>> fetchTasksByCompletion(bool isCompleted) async {
    try {
      return localDataSource.values
          .where((task) => task.isCompleted == isCompleted)
          .toList();
    } catch (e) {
      throw Exception("Failed to fetch tasks by completion status: $e");
    }
  }
}
