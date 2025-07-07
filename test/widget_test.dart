import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:zaika_box/main.dart';  // Ensure this path is correct

void main() {
  testWidgets('ZaikaBox app loads', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(ZaikaBoxApp());  // ✅ Correct class name

    // Since this is a custom app, remove counter logic if not present
    expect(find.byType(MaterialApp), findsOneWidget);  // Sanity check
  });
}
