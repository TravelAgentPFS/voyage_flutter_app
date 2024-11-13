import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:voyage_flutter_app/pages/auth/register_page.dart';

void main() {

  // Helper function to pump the RegisterPageContent widget
  Future<void> pumpRegisterPage(WidgetTester tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: RegisterPageContent(),
    ));
  }

  group('Register Page Tests', () {
    // Test 1: Check if the form fields are present
    testWidgets('Form fields and register button should be present', (WidgetTester tester) async {
      await pumpRegisterPage(tester);

      expect(find.byType(TextFormField), findsNWidgets(3)); // Username, Email, Password fields
      expect(find.byType(ElevatedButton), findsOneWidget); // Register button
    });

    // Test 2: Validate empty username field
    testWidgets('Should show error if username is empty', (WidgetTester tester) async {
      await pumpRegisterPage(tester);

      await tester.enterText(find.byType(TextFormField).at(1), 'test@example.com');
      await tester.enterText(find.byType(TextFormField).at(2), 'password123');

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Please enter your username'), findsOneWidget);
    });

    // Test 3: Validate incorrect email format
    testWidgets('Should show error for invalid email format', (WidgetTester tester) async {
      await pumpRegisterPage(tester);

      await tester.enterText(find.byType(TextFormField).at(0), 'testuser');
      await tester.enterText(find.byType(TextFormField).at(1), 'invalid-email');
      await tester.enterText(find.byType(TextFormField).at(2), 'password123');

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Please enter a valid email address'), findsOneWidget);
    });

    // Test 4: Validate password length
    testWidgets('Should show error if password is less than 8 characters', (WidgetTester tester) async {
      await pumpRegisterPage(tester);

      await tester.enterText(find.byType(TextFormField).at(0), 'testuser');
      await tester.enterText(find.byType(TextFormField).at(1), 'test@example.com');
      await tester.enterText(find.byType(TextFormField).at(2), 'short');

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(find.text('Password should be at least 8 characters'), findsOneWidget);
    });
  });
}


