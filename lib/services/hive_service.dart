import 'package:hive_flutter/hive_flutter.dart';
import '../models/task_model.dart';

class HiveService {
  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskAdapter());
    await Hive.openBox<Task>('tasksBox');
  }

  static Box<Task> get taskBox => Hive.box<Task>('tasksBox');
}
