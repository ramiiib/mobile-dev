import 'package:deliverable_2/TabContent/map_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MapContent screen loads and displays the map image',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MapContent()));
    expect(find.text("Campus Map"), findsOneWidget);
    expect(find.byType(InteractiveViewer), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);
  });

  testWidgets('InteractiveViewer allows zooming', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MapContent()));

    final Finder interactiveViewerFinder = find.byType(InteractiveViewer);
    final InteractiveViewer viewer =
        tester.widget(interactiveViewerFinder) as InteractiveViewer;
    expect(viewer.minScale, 0.01);
    expect(viewer.maxScale, 5.0);
  });

  testWidgets('Check constraints', (WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(home: MapContent()));

    final Finder interactiveViewerFinder = find.byType(InteractiveViewer);
    final InteractiveViewer viewer =
        tester.widget(interactiveViewerFinder) as InteractiveViewer;
    expect(viewer.constrained, false);
  });
}
