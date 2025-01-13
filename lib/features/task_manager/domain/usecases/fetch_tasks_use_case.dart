import 'package:task_manager/features/task_manager/data/models/task_model.dart';

import '../repositories/task_repository.dart';

class FetchAllTasksUseCase {
  final TaskRepository repository;

  FetchAllTasksUseCase(this.repository);

  Future<List<TaskModel>> call() async {
    return await repository.fetchAllTasks();
  }
}
