// test/widgets/interest_card_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youapp_tester/features/profile/domain/entities/profile.dart';
import 'package:youapp_tester/features/profile/presentation/widgets/interest_card.dart';

// Mocking AppRouter
class MockAppRouter extends Mock implements GoRouter {}

void main() {
  testWidgets('renders InterestCard with interests',
      (WidgetTester tester) async {
    const profile = Profile(interests: ['Flutter', 'Dart']);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: InterestCard(profile: profile),
        ),
      ),
    );

    // Check that the interests are displayed as InputChip widgets
    expect(find.byType(InputChip), findsNWidgets(2));
    expect(find.text('Flutter'), findsOneWidget);
    expect(find.text('Dart'), findsOneWidget);
  });

  testWidgets('renders InterestCard with no interests',
      (WidgetTester tester) async {
    const profile = Profile(interests: []);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: InterestCard(profile: profile),
        ),
      ),
    );

    // Check that the message for no interests is displayed
    expect(find.text('Add in your interest to find a better match'),
        findsOneWidget);
    expect(find.byType(InputChip), findsNothing);
  });

  testWidgets('triggers navigation on edit button click',
      (WidgetTester tester) async {
    // Create a mock AppRouter
    final mockAppRouter = MockAppRouter();

    when(() => mockAppRouter.push(any())).thenAnswer((_) async {
      return null;
    });

    // Override the AppRouter with the mock
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: InterestCard(profile: Profile(interests: ['Flutter'])),
        ),
      ),
    );

    // Tap the edit button
    await tester.tap(find.byIcon(Icons.border_color));
    await tester.pump(); // Rebuild the widget

    // Verify that navigation is triggered
    verify(() => mockAppRouter.push(any())).called(1);
  });
}
