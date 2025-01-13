import 'package:task_manager/features/task_manager/data/models/task_model.dart';

class SortTasksUseCase {
  List<TaskModel> call(List<TaskModel> tasks, {String sortBy = 'due_date'}) {
    List<TaskModel> sortedTasks = [...tasks];
    if (sortBy == 'due_date') {
      sortedTasks.sort((a, b) => a.dueDate.compareTo(b.dueDate));
    } else if (sortBy == 'priority') {
      // sortedTasks.sort((a, b) => b.priority.compareTo(a.priority));
    }
    return sortedTasks;
  }
}
