// test/widgets/profile_hero_test.dart
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:youapp_tester/features/profile/domain/entities/profile.dart';
import 'package:youapp_tester/features/profile/presentation/widgets/profile_hero.dart';

void main() {
  testWidgets('renders ProfileHero with image bytes',
      (WidgetTester tester) async {
    final profile = Profile(
      imageBytes: Uint8List.fromList([0, 0, 0, 0]), // Dummy data for the image
      username: 'john_doe',
      gender: Gender.male,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProfileHero(profile: profile),
        ),
      ),
    );

    // Check that the image is rendered
    expect(find.byType(Image), findsOneWidget);
    expect(find.text('@john_doe, 30'), findsOneWidget);
    expect(find.text('Male'), findsOneWidget);
    expect(find.text('Aries'), findsOneWidget);
    expect(find.text('Lucky'), findsOneWidget);
  });

  testWidgets('renders ProfileHero without image bytes',
      (WidgetTester tester) async {
    const profile = Profile(
      imageBytes: null,
      username: 'john_doe',
      gender: Gender.male,
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ProfileHero(profile: profile),
        ),
      ),
    );

    // Check that the network image is rendered
    expect(find.byType(Image), findsOneWidget);
    expect(find.text('@john_doe, 30'), findsOneWidget);
    expect(find.text('Male'), findsOneWidget);
    expect(find.text('Aries'), findsOneWidget);
    expect(find.text('Lucky'), findsOneWidget);
  });

  testWidgets('renders ProfileHero with missing optional fields',
      (WidgetTester tester) async {
    const profile = Profile(
      imageBytes: null,
      username: 'john_doe',
      gender: null,
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ProfileHero(profile: profile),
        ),
      ),
    );

    // Check that only the username is rendered
    expect(find.text('@john_doe, '), findsOneWidget);
    expect(find.text('Male'), findsNothing);
    expect(find.text('Aries'), findsNothing);
    expect(find.text('Lucky'), findsNothing);
  });

  testWidgets('renders FilterChip widgets for zodiac and horoscope',
      (WidgetTester tester) async {
    const profile = Profile(
      imageBytes: null,
      username: 'john_doe',
      gender: Gender.male,
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ProfileHero(profile: profile),
        ),
      ),
    );

    // Check that the FilterChip widgets are rendered correctly
    expect(find.byType(FilterChip), findsNWidgets(2));
    expect(find.text('Aries'), findsOneWidget);
    expect(find.text('Lucky'), findsOneWidget);
  });
}
