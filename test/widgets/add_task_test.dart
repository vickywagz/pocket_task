import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pocket_task/screens/add_task_sheet.dart';

void main() {
  testWidgets('AddTaskSheet shows title field and button', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: AddTaskSheet())),
    );

    expect(find.text('Add Task'), findsOneWidget);
    expect(find.byType(TextFormField), findsWidgets);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
