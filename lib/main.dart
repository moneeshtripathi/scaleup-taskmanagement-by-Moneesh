import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_manager/features/task_manager/app/app.dart';
import 'package:task_manager/features/task_manager/data/models/task_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Hive and open the box for tasks
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter()); // Register the Task adapter
  var tasksBox = await Hive.openBox<TaskModel>('tasks'); // Open the tasks box
  runApp(TaskManagerApp(tasksBox: tasksBox));
}

