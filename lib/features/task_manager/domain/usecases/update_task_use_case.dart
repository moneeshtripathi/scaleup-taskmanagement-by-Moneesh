import 'package:task_manager/features/task_manager/data/models/task_model.dart';

import '../repositories/task_repository.dart';

class UpdateTaskUseCase {
  final TaskRepository repository;

  UpdateTaskUseCase(this.repository);

  Future<void> call(TaskModel task) async {
    if (task.title.isEmpty) {
      throw ArgumentError("Task title cannot be empty.");
    }
    await repository.updateTask(task);
  }
}
