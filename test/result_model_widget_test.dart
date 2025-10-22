import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:respyr_dietitian/features/result_screen/data/models/result_model.dart';

void main() {
  testWidgets('ResultCard displays result values', (WidgetTester tester) async {
    // Arrange: create a dummy result
    final result = ResultModel.dummy();

    // Act: pump the ResultCard widget
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
         // body: ResultCard(result: result),
        ),
      ),
    );

    // Debug print
    print("Testing with result: $result");

    // Assert: check expected texts
    expect(find.text('BMI: 25.0'), findsOneWidget);
    expect(find.text('BMR: 1827.0'), findsOneWidget); // note: your BMR might be double
    expect(find.text('Gut Absorptive: 75.0'), findsOneWidget);
  });
}
