import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youapp_tester/features/profile/domain/entities/profile.dart';
import 'package:youapp_tester/features/profile/domain/repositories/profile_repository.dart';
import 'package:youapp_tester/features/profile/domain/usecases/get_profile.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}

void main() {
  late GetProfile getProfileUseCase;
  late MockProfileRepository mockProfileRepository;

  setUp(() {
    mockProfileRepository = MockProfileRepository();
    getProfileUseCase = GetProfile(mockProfileRepository);
  });

  group('GetProfile UseCase', () {
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

    test('should return Profile when repository call is successful', () async {
      when(() => mockProfileRepository.getProfile(accessToken))
          .thenAnswer((_) async => profile);

      final result = await getProfileUseCase.call(accessToken);

      expect(result, equals(profile));
      verify(() => mockProfileRepository.getProfile(accessToken)).called(1);
      verifyNoMoreInteractions(mockProfileRepository);
    });

    test('should throw an exception when repository call fails', () async {
      when(() => mockProfileRepository.getProfile(accessToken))
          .thenThrow(Exception('Failed to get profile'));

      expect(
        () => getProfileUseCase.call(accessToken),
        throwsA(isA<Exception>()),
      );

      verify(() => mockProfileRepository.getProfile(accessToken)).called(1);
      verifyNoMoreInteractions(mockProfileRepository);
    });
  });
}
