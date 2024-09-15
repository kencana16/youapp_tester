import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youapp_tester/base/usecase.dart';
import 'package:youapp_tester/features/login/domain/repositories/login_repository.dart';
import 'package:youapp_tester/features/login/domain/usecases/revoke_access_token.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  late MockLoginRepository mockLoginRepository;
  late RevokeAccessToken usecase;

  setUp(() {
    mockLoginRepository = MockLoginRepository();
    usecase = RevokeAccessToken(mockLoginRepository);
  });

  test('should return true when repository revokeAccessToken is successful',
      () async {
    // Arrange
    when(() => mockLoginRepository.revokeAccessToken())
        .thenAnswer((_) async => true);

    // Act
    final result = await usecase(NoParams());

    // Assert
    expect(result, true);
    verify(() => mockLoginRepository.revokeAccessToken()).called(1);
    verifyNoMoreInteractions(mockLoginRepository);
  });

  test('should return false when repository revokeAccessToken fails', () async {
    // Arrange
    when(() => mockLoginRepository.revokeAccessToken())
        .thenAnswer((_) async => false);

    // Act
    final result = await usecase(NoParams());

    // Assert
    expect(result, false);
    verify(() => mockLoginRepository.revokeAccessToken()).called(1);
    verifyNoMoreInteractions(mockLoginRepository);
  });

  test(
      'should throw an exception when repository revokeAccessToken throws an error',
      () async {
    // Arrange
    when(() => mockLoginRepository.revokeAccessToken())
        .thenThrow(Exception('Revoke token failed'));

    // Act & Assert
    expect(() => usecase(NoParams()), throwsA(isA<Exception>()));
    verify(() => mockLoginRepository.revokeAccessToken()).called(1);
    verifyNoMoreInteractions(mockLoginRepository);
  });
}
