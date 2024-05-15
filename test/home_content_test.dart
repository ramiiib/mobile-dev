import 'package:deliverable_2/TabContent/home_content.dart' as home_content;
import 'package:deliverable_2/TabContent/home_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('HomeContent screen loads and displays all components correctly',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: HomeContent()));

    // Make sure all the elements exist on the screen
    expect(find.byType(Hero), findsOneWidget);
    expect(find.byType(home_content.Banner), findsNWidgets(2));
    expect(find.text("Upcoming events"), findsOneWidget);
    expect(find.text("Next class"), findsOneWidget);
    expect(find.image(const AssetImage('images/mqlogo.png')), findsOneWidget);

    // Scrollability test
    final gesture = await tester.startGesture(Offset.zero);
    await gesture.moveBy(const Offset(0, -300));
    await tester.pump();
    expect(find.text("Upcoming events"), findsOneWidget);
    expect(find.text("Next class"), findsOneWidget);
  });
}
