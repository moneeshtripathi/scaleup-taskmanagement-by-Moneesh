import 'package:task_manager/features/task_manager/data/models/task_model.dart';

import '../repositories/task_repository.dart';

class FetchCompletedTasksUseCase {
  final TaskRepository repository;

  FetchCompletedTasksUseCase(this.repository);

  Future<List<TaskModel>> call(bool isCompleted) async {
    return await repository.fetchTasksByCompletion(isCompleted);
  }
}
