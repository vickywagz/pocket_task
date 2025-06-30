import 'package:flutter_test/flutter_test.dart';
import 'package:pocket_task/models/task_model.dart';

void main() {
  group('Task Model', () {
    test('should create a task with correct fields', () {
      final task = Task(
        title: 'Test Task',
        createdAt: DateTime.now(),
        isCompleted: false,
      );

      expect(task.title, 'Test Task');
      expect(task.isCompleted, false);
      expect(task.description, isNull);
    });
  });
}
