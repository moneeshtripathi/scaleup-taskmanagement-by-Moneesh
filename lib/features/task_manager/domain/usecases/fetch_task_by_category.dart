import 'package:task_manager/features/task_manager/data/models/task_model.dart';

import '../repositories/task_repository.dart';

class FetchTasksByCategoryUseCase {
  final TaskRepository repository;

  FetchTasksByCategoryUseCase(this.repository);

  Future<List<TaskModel>> call(String category) async {
    return await repository.fetchTasksByCategory(category);
  }
}
