import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_task/models/task_model.dart';
import 'package:pocket_task/providers/task_provider.dart';
import 'package:pocket_task/screens/edit_task_sheet.dart';

class TaskDetailScreen extends ConsumerWidget {
  final Task task;

  const TaskDetailScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 🟣 Refresh task from provider to reflect latest edits
    final tasks = ref.watch(taskListProvider);
    final updatedTask = tasks.firstWhere(
      (t) => t.key == task.key,
      orElse: () => task,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Task Details"),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                builder: (_) => EditTaskSheet(task: updatedTask),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              updatedTask.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            if (updatedTask.description != null &&
                updatedTask.description!.isNotEmpty)
              Text(
                updatedTask.description!,
                style: const TextStyle(fontSize: 16),
              ),
            const SizedBox(height: 12),

            Row(
              children: [
                const Icon(Icons.calendar_today, size: 18),
                const SizedBox(width: 6),
                Text(
                  updatedTask.dueDate != null
                      ? "${updatedTask.dueDate!.day}/${updatedTask.dueDate!.month}/${updatedTask.dueDate!.year}"
                      : "No due date",
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 12),

            if (updatedTask.category != null)
              Row(
                children: [
                  const Icon(Icons.label, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    updatedTask.category!,
                    style: const TextStyle(fontSize: 14),
                  ),
                ],
              ),

            const SizedBox(height: 20),

            Row(
              children: [
                const Icon(Icons.check_circle_outline, size: 18),
                const SizedBox(width: 6),
                Text(
                  updatedTask.isCompleted ? "Completed" : "Not Completed",
                  style: TextStyle(
                    color: updatedTask.isCompleted ? Colors.green : Colors.red,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                showDialog(
                  context: context,
                  builder:
                      (ctx) => AlertDialog(
                        title: const Text("Delete Task"),
                        content: const Text(
                          "Are you sure you want to delete this task?",
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(ctx).pop(),
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              ref
                                  .read(taskListProvider.notifier)
                                  .deleteTask(updatedTask);
                              Navigator.of(context)
                                ..pop()
                                ..pop();
                            },
                            child: const Text(
                              "Delete",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      ),
                );
              },
              icon: const Icon(Icons.delete),
              label: const Text("Delete Task"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
