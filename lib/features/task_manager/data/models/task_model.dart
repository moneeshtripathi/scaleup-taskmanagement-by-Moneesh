// ignore: depend_on_referenced_packages
import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String description;

  @HiveField(3)
  final DateTime dueDate;

  @HiveField(4)
  final String category;

  @HiveField(5)
  final bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    required this.category,
    required this.isCompleted,
  });

  // Add the copyWith method
  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dueDate,
    String? category,
    bool? isCompleted,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      category: category ?? this.category,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}

// import 'package:hive/hive.dart';

// part 'task_model.g.dart';

// @HiveType(typeId: 0)
// class TaskModel {
//   @HiveField(0)
//   final String id;

//   @HiveField(1)
//   final String title;

//   @HiveField(2)
//   final String description;

//   @HiveField(3)
//   final DateTime dueDate;

//   @HiveField(4)
//   final String category;

//   @HiveField(5)
//   final bool isCompleted;

//   TaskModel({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.dueDate,
//     required this.category,
//     required this.isCompleted,
//   });
// }
