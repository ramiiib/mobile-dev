import 'package:deliverable_2/TabContent/study_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget createWidget() {
    return const MaterialApp(
      home: Scaffold(
        body: StudyContent(),
      ),
    );
  }

  testWidgets('Displays the 4 main tiles', (WidgetTester tester) async {
    await tester.pumpWidget(createWidget());

    expect(find.text('To-Do'), findsOneWidget);
    expect(find.text('Notes'), findsOneWidget);
    expect(find.text('Study Groups'), findsOneWidget);
    expect(find.text('My Courses'), findsOneWidget);
  });

  testWidgets('Can add a task to the ToDoList', (WidgetTester tester) async {
    await tester.pumpWidget(createWidget());

    await tester.enterText(find.byType(TextField), 'Finish the project');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    expect(find.text('Finish the project'), findsOneWidget);
  });

  testWidgets('Can remove a task from the ToDoList',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidget());

    await tester.enterText(find.byType(TextField), 'Task to be removed');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump();

    await tester.tap(find.byIcon(Icons.delete));
    await tester.pump();

    expect(find.text('Task to be removed'), findsNothing);
  });
}
