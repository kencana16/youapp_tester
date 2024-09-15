import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youapp_tester/features/profile/domain/entities/profile.dart';
import 'package:youapp_tester/features/profile/domain/repositories/profile_repository.dart';
import 'package:youapp_tester/features/profile/domain/usecases/update_profile.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}

void main() {
  late UpdateProfile updateProfileUseCase;
  late MockProfileRepository mockProfileRepository;

  setUp(() {
    mockProfileRepository = MockProfileRepository();
    updateProfileUseCase = UpdateProfile(mockProfileRepository);
  });

  group('UpdateProfile UseCase', () {
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
    final UpdateProfileParam params = UpdateProfileParam(
      accessToken: accessToken,
      profile: profile,
    );

    test('should return true when repository updateProfile call is successful',
        () async {
      when(() => mockProfileRepository.updateProfile(accessToken, profile))
          .thenAnswer((_) async => true);

      final result = await updateProfileUseCase.call(params);

      expect(result, true);
      verify(() => mockProfileRepository.updateProfile(accessToken, profile))
          .called(1);
      verifyNoMoreInteractions(mockProfileRepository);
    });

    test('should throw an exception when repository updateProfile call fails',
        () async {
      when(() => mockProfileRepository.updateProfile(accessToken, profile))
          .thenThrow(Exception('Failed to update profile'));

      expect(
        () => updateProfileUseCase.call(params),
        throwsA(isA<Exception>()),
      );

      verify(() => mockProfileRepository.updateProfile(accessToken, profile))
          .called(1);
      verifyNoMoreInteractions(mockProfileRepository);
    });
  });
}
