import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:quiz_app/main.dart';

void main() {
  testWidgets('Quiz starts with first question', (WidgetTester tester) async {
    await tester.pumpWidget(QuizApp());

    // Look for the first question text
    expect(find.text('What is the largest ocean on Earth?'), findsOneWidget);
  });
}
