import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youapp_tester/base/usecase.dart';
import 'package:youapp_tester/features/login/domain/repositories/login_repository.dart';
import 'package:youapp_tester/features/login/domain/usecases/get_access_token.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  late MockLoginRepository mockLoginRepository;
  late GetAccessToken usecase;

  setUp(() {
    mockLoginRepository = MockLoginRepository();
    usecase = GetAccessToken(mockLoginRepository);
  });

  test('should return access token when repository returns token', () async {
    // Arrange
    const tAccessToken = 'dummyAccessToken';
    when(() => mockLoginRepository.getAccessToken())
        .thenAnswer((_) async => tAccessToken);

    // Act
    final result = await usecase(NoParams());

    // Assert
    expect(result, tAccessToken);
    verify(() => mockLoginRepository.getAccessToken()).called(1);
    verifyNoMoreInteractions(mockLoginRepository);
  });

  test('should return null when repository returns null', () async {
    // Arrange
    when(() => mockLoginRepository.getAccessToken())
        .thenAnswer((_) async => null);

    // Act
    final result = await usecase(NoParams());

    // Assert
    expect(result, null);
    verify(() => mockLoginRepository.getAccessToken()).called(1);
    verifyNoMoreInteractions(mockLoginRepository);
  });
}
