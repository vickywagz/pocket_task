import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pocket_task/models/task_model.dart';
import 'package:pocket_task/providers/task_provider.dart';
import 'package:pocket_task/screens/home_page.dart';

void main() {
  testWidgets('Tab bar switches between filters', (WidgetTester tester) async {
    final tasks = [
      Task(title: 'Task 1', createdAt: DateTime.now(), isCompleted: false),
      Task(title: 'Task 2', createdAt: DateTime.now(), isCompleted: true),
    ];

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          taskListProvider.overrideWith((ref) => FakeTaskNotifier(tasks)),
        ],
        child: const MaterialApp(home: HomePage()),
      ),
    );

    // Tab 1 (To-do)
    expect(find.text('Task 1'), findsOneWidget);
    expect(find.text('Task 2'), findsOneWidget); // To-do tab shows all

    // Switch to Completed tab
    await tester.tap(find.text('Completed'));
    await tester.pumpAndSettle();

    expect(find.text('Task 2'), findsOneWidget);
    expect(find.text('Task 1'), findsNothing);
  });
}

class FakeTaskNotifier extends TaskListNotifier {
  FakeTaskNotifier(List<Task> initialTasks) {
    state = initialTasks;
  }
}
