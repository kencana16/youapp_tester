import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:youapp_tester/features/profile/domain/entities/profile.dart';

void main() {
  const profileJson = {
    'imageBytes': 'dGVzdA==', // base64 for 'test'
    'email': 'test@example.com',
    'username': 'testuser',
    'imageUrl': 'http://example.com/image.png',
    'gender': 'male',
    'name': 'Test User',
    'birthday': 0, // Set to current DateTime in milliseconds
    'height': 180.0,
    'weight': 75.0,
    'interests': ['Reading', 'Coding'],
  };

  test('Profile can be created from JSON', () {
    final profile = Profile.fromJson(profileJson);

    expect(profile.email, 'test@example.com');
    expect(profile.username, 'testuser');
    expect(profile.imageUrl, 'http://example.com/image.png');
    expect(profile.gender, Gender.male);
    expect(profile.name, 'Test User');
    expect(profile.height, 180.0);
    expect(profile.weight, 75.0);
    expect(profile.interests, ['Reading', 'Coding']);
    expect(profile.imageBytes, Uint8List.fromList(base64Decode('dGVzdA==')));
  });

  test('Profile can be serialized to JSON', () {
    final profile = Profile(
      imageBytes: Uint8List.fromList(base64Decode('dGVzdA==')),
      email: 'test@example.com',
      username: 'testuser',
      imageUrl: 'http://example.com/image.png',
      gender: Gender.male,
      name: 'Test User',
      birthday: DateTime.fromMillisecondsSinceEpoch(0),
      height: 180.0,
      weight: 75.0,
      interests: ['Reading', 'Coding'],
    );

    final profileJsonOutput = profile.toJson();

    expect(profileJsonOutput['email'], 'test@example.com');
    expect(profileJsonOutput['username'], 'testuser');
    expect(profileJsonOutput['imageUrl'], 'http://example.com/image.png');
    expect(profileJsonOutput['gender'], 'male');
    expect(profileJsonOutput['name'], 'Test User');
    expect(profileJsonOutput['height'], 180.0);
    expect(profileJsonOutput['weight'], 75.0);
    expect(profileJsonOutput['interests'], ['Reading', 'Coding']);
    expect(profileJsonOutput['imageBytes'], 'dGVzdA==');
  });

  test('Profile computed properties work', () {
    final profile = Profile(
      birthday: DateTime.now()
          .subtract(const Duration(days: 365 * 30)), // 30 years ago
    );

    expect(profile.age, isNotNull);
    expect(profile.zodiac, isNotNull);
    expect(profile.horoscope, isNotNull);
  });
}
