import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_task/models/task_model.dart';
import 'package:pocket_task/services/hive_service.dart';

final taskListProvider = StateNotifierProvider<TaskListNotifier, List<Task>>((
  ref,
) {
  return TaskListNotifier();
});

class TaskListNotifier extends StateNotifier<List<Task>> {
  TaskListNotifier() : super([]) {
    _loadTasks();
  }

  void _loadTasks() {
    final box = HiveService.taskBox;
    state = box.values.toList();
  }

  void addTask(Task task) {
    HiveService.taskBox.add(task);
    state = [...state, task];
  }

  void toggleComplete(Task task) {
    final index = state.indexOf(task);
    if (index == -1 || !task.isInBox) return;

    task.isCompleted = !task.isCompleted;
    task.save();

    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index) task else state[i],
    ];
  }

  void updateTask(Task task) {
    final index = state.indexWhere((t) => t.key == task.key);
    if (index == -1) return;

    task.save(); // Save the updated task

    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index) task else state[i],
    ];
  }

  void deleteTask(Task task) {
    HiveService.taskBox.delete(task.key);
    state = state.where((t) => t != task).toList();
  }
}
