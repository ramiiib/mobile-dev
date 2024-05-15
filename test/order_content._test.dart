import 'package:deliverable_2/Models/cart_model.dart';
import 'package:deliverable_2/Models/food_details.dart';
import 'package:deliverable_2/TabContent/order_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  Widget createWidget() {
    return ChangeNotifierProvider<CartModel>(
      create: (_) => CartModel(),
      child: const MaterialApp(
        home: OrderContent(),
      ),
    );
  }

  testWidgets('OrderContent loads and displays components',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidget());
    expect(find.text("I'm looking for..."), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);
    expect(find.byType(ListView), findsOneWidget);
  });

  testWidgets('Search works', (WidgetTester tester) async {
    await tester.pumpWidget(createWidget());
    await tester.enterText(find.byType(TextField), 'latte');
    await tester.pumpAndSettle();
    expect(find.text('Latte'), findsOneWidget);
    expect(find.text('Espresso'), findsNothing); // Espresso should not show up
  });

  testWidgets('Tapping a food item shows its details',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidget());
    await tester.tap(find.text('Latte'));
    await tester.pumpAndSettle();
    expect(find.byType(FoodDetailsScreen), findsOneWidget);
  });
}
