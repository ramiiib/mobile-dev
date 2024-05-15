import 'package:deliverable_2/TabContent/help_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('HelpContent loads and displays components correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HelpContent()));
    expect(find.text('Help'), findsOneWidget);
    expect(find.byType(ListTile), findsWidgets);
    expect(find.text('Quick Links:'), findsOneWidget);
    expect(find.text('AskMQ'), findsOneWidget);
  });
}
