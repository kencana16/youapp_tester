import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youapp_tester/base/widget/password_form_field.dart';

void main() {
  testWidgets(
      'PasswordFormField should toggle obscure text when suffix icon is tapped',
      (WidgetTester tester) async {
    // Arrange: Build the PasswordFormField widget inside a test environment.
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Form(
            child: PasswordFormField(
              name: 'password',
              hintText: 'Enter password',
            ),
          ),
        ),
      ),
    );

    // Act: Find the obscure text icon (visibility_off icon) and check initial state.
    final textFieldFinder = find.byType(FormBuilderTextField);
    final visibilityIconFinder = find.byIcon(
        Icons.visibility_off); // Initially, it should be visibility_off.

    expect(textFieldFinder, findsOneWidget);
    expect(visibilityIconFinder,
        findsOneWidget); // Initially, it should be visibility_off.

    // Assert: Verify that the obscureText is true initially.
    FormBuilderTextField textField = tester.widget(textFieldFinder);
    expect(textField.obscureText, true);

    // Act: Tap on the visibility icon to toggle obscure text.
    await tester.tap(visibilityIconFinder);
    await tester.pump(); // Rebuild after state change.

    // Assert: Verify that the icon has changed to visibility and obscureText is now false.
    final visibilityIconOnFinder = find.byIcon(Icons.visibility);
    expect(visibilityIconOnFinder,
        findsOneWidget); // The icon should now be visibility.

    textField = tester.widget(textFieldFinder);
    expect(textField.obscureText, false); // Text should no longer be obscured.

    // Act: Tap again to obscure the text.
    await tester.tap(visibilityIconOnFinder);
    await tester.pump();

    // Assert: Verify that the icon is back to visibility_off and obscureText is true again.
    expect(find.byIcon(Icons.visibility_off),
        findsOneWidget); // The icon should be visibility_off again.
    textField = tester.widget(textFieldFinder);
    expect(textField.obscureText, true); // Text should be obscured again.
  });
}
