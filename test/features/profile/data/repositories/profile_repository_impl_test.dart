import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youapp_tester/features/profile/data/datasources/profile_datasource.dart';
import 'package:youapp_tester/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:youapp_tester/features/profile/domain/entities/profile.dart';

class MockProfileDatasource extends Mock implements ProfileDatasource {}

void main() {
  late ProfileRepositoryImpl profileRepository;
  late MockProfileDatasource mockProfileDatasource;

  setUp(() {
    mockProfileDatasource = MockProfileDatasource();
    profileRepository = ProfileRepositoryImpl(mockProfileDatasource);
  });

  group('ProfileRepositoryImpl', () {
    const String accessToken = 'mockAccessToken';
    final Profile profile = Profile(
      email: 'test@example.com',
      username: 'testuser',
      imageBytes: Uint8List.fromList([1, 2, 3]),
      gender: Gender.male,
      name: 'Test User',
      birthday: DateTime.now()
          .subtract(const Duration(days: 365 * 30)), // 30 years ago
      height: 180.0,
      weight: 75.0,
      interests: ['Reading', 'Coding'],
    );

    test('should return Profile when getProfile is successful', () async {
      when(() => mockProfileDatasource.getProfile(accessToken))
          .thenAnswer((_) async => profile);

      final result = await profileRepository.getProfile(accessToken);

      expect(result, equals(profile));
      verify(() => mockProfileDatasource.getProfile(accessToken)).called(1);
      verifyNoMoreInteractions(mockProfileDatasource);
    });

    test('should throw an exception when getProfile fails', () async {
      when(() => mockProfileDatasource.getProfile(accessToken))
          .thenThrow(Exception('Failed to get profile'));

      expect(
        () => profileRepository.getProfile(accessToken),
        throwsA(isA<Exception>()),
      );

      verify(() => mockProfileDatasource.getProfile(accessToken)).called(1);
      verifyNoMoreInteractions(mockProfileDatasource);
    });

    test('should return true when updateProfile is successful', () async {
      when(() => mockProfileDatasource.updateProfile(accessToken, profile))
          .thenAnswer((_) async => true);

      final result =
          await profileRepository.updateProfile(accessToken, profile);

      expect(result, isTrue);
      verify(() => mockProfileDatasource.updateProfile(accessToken, profile))
          .called(1);
      verifyNoMoreInteractions(mockProfileDatasource);
    });

    test('should throw an exception when updateProfile fails', () async {
      when(() => mockProfileDatasource.updateProfile(accessToken, profile))
          .thenThrow(Exception('Failed to update profile'));

      expect(
        () => profileRepository.updateProfile(accessToken, profile),
        throwsA(isA<Exception>()),
      );

      verify(() => mockProfileDatasource.updateProfile(accessToken, profile))
          .called(1);
      verifyNoMoreInteractions(mockProfileDatasource);
    });
  });
}
