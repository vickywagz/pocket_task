import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_task/models/task_model.dart';
import 'package:pocket_task/providers/task_provider.dart';
import 'package:pocket_task/screens/add_task_sheet.dart';
import 'package:pocket_task/screens/task_detail_screen.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "My Tasks",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 1,
          bottom: const TabBar(
            labelColor: Colors.deepPurple,
            unselectedLabelColor: Colors.grey,
            indicatorColor: Colors.deepPurple,
            tabs: [
              Tab(text: 'To-do'),
              Tab(text: 'In-Progress'),
              Tab(text: 'Completed'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            TaskListView(status: 'todo'),
            TaskListView(status: 'in-progress'),
            TaskListView(status: 'completed'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (context) => const AddTaskSheet(),
            );
          },
          backgroundColor: Colors.deepPurple,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

class TaskListView extends ConsumerWidget {
  final String status;

  const TaskListView({super.key, required this.status});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskListProvider);

    final filtered = switch (status) {
      'todo' => tasks,
      'in-progress' => tasks.where((task) => !task.isCompleted).toList(),
      'completed' => tasks.where((task) => task.isCompleted).toList(),
      _ => tasks,
    };

    final filteredTasks = List<Task>.from(filtered)..sort((a, b) {
      final aDate = a.dueDate ?? DateTime(2100);
      final bDate = b.dueDate ?? DateTime(2100);
      return aDate.compareTo(bDate);
    });

    if (filteredTasks.isEmpty) {
      return Center(
        child: Text(
          'No task in "$status"',
          style: const TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: filteredTasks.length,
      itemBuilder: (context, index) {
        final task = filteredTasks[index];

        return Dismissible(
          key: ValueKey(task.key),
          direction: DismissDirection.endToStart,
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          onDismissed: (_) {
            ref.read(taskListProvider.notifier).deleteTask(task);
          },
          child: Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 6),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => TaskDetailScreen(task: task),
                  ),
                );
              },
              leading: Checkbox(
                value: task.isCompleted,
                onChanged: (_) {
                  ref.read(taskListProvider.notifier).toggleComplete(task);
                },
                activeColor: Colors.deepPurple,
              ),
              title: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder:
                    (child, animation) =>
                        SizeTransition(sizeFactor: animation, child: child),
                child: Text(
                  task.title,
                  key: ValueKey("${task.title}_${task.isCompleted}"),
                  style: TextStyle(
                    decoration:
                        task.isCompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              subtitle:
                  task.dueDate != null
                      ? Text(
                        "${task.dueDate!.day}/${task.dueDate!.month}/${task.dueDate!.year}",
                        style: const TextStyle(fontSize: 12),
                      )
                      : null,
              trailing:
                  task.category != null
                      ? Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _getCategoryColor(task.category),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          task.category!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                      : null,
            ),
          ),
        );
      },
    );
  }

  Color _getCategoryColor(String? category) {
    switch (category?.toLowerCase()) {
      case 'work':
        return Colors.blue;
      case 'education':
        return Colors.purple;
      case 'personal':
        return Colors.green;
      case 'home':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
