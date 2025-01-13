import '../models/task_model.dart';

abstract class LocalTaskDataSource {
  Future<void> addTask(TaskModel task);
  Future<List<TaskModel>> getTasks({
    String? category,
    bool? isCompleted,
    String? sortBy,
  });
}
