import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youapp_tester/features/login/domain/repositories/login_repository.dart';
import 'package:youapp_tester/features/login/domain/usecases/save_access_token.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  late MockLoginRepository mockLoginRepository;
  late SaveAccessToken usecase;

  setUp(() {
    mockLoginRepository = MockLoginRepository();
    usecase = SaveAccessToken(mockLoginRepository);
  });

  test('should return true when repository saveAccessToken is successful',
      () async {
    // Arrange
    const accessToken = 'dummyAccessToken';
    when(() => mockLoginRepository.saveAccessToken(accessToken))
        .thenAnswer((_) async => true);

    // Act
    final result = await usecase(accessToken);

    // Assert
    expect(result, true);
    verify(() => mockLoginRepository.saveAccessToken(accessToken)).called(1);
    verifyNoMoreInteractions(mockLoginRepository);
  });

  test('should return false when repository saveAccessToken fails', () async {
    // Arrange
    const accessToken = 'dummyAccessToken';
    when(() => mockLoginRepository.saveAccessToken(accessToken))
        .thenAnswer((_) async => false);

    // Act
    final result = await usecase(accessToken);

    // Assert
    expect(result, false);
    verify(() => mockLoginRepository.saveAccessToken(accessToken)).called(1);
    verifyNoMoreInteractions(mockLoginRepository);
  });

  test(
      'should throw an exception when repository saveAccessToken throws an error',
      () async {
    // Arrange
    const accessToken = 'dummyAccessToken';
    when(() => mockLoginRepository.saveAccessToken(accessToken))
        .thenThrow(Exception('Save token failed'));

    // Act & Assert
    expect(() => usecase(accessToken), throwsA(isA<Exception>()));
    verify(() => mockLoginRepository.saveAccessToken(accessToken)).called(1);
    verifyNoMoreInteractions(mockLoginRepository);
  });
}
