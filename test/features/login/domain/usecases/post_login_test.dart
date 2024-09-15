import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youapp_tester/features/login/domain/entities/login_dto.dart';
import 'package:youapp_tester/features/login/domain/repositories/login_repository.dart';
import 'package:youapp_tester/features/login/domain/usecases/post_login.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  late MockLoginRepository mockLoginRepository;
  late PostLogin usecase;

  setUp(() {
    mockLoginRepository = MockLoginRepository();
    usecase = PostLogin(mockLoginRepository);
  });

  const loginDto = LoginDto(
    email: 'test@example.com',
    username: 'testuser',
    password: 'password123',
  );
  const accessToken = 'dummyAccessToken';

  test('should return access token when repository login is successful', () async {
    // Arrange
    when(() => mockLoginRepository.login(loginDto))
        .thenAnswer((_) async => accessToken);

    // Act
    final result = await usecase(loginDto);

    // Assert
    expect(result, accessToken);
    verify(() => mockLoginRepository.login(loginDto)).called(1);
    verifyNoMoreInteractions(mockLoginRepository);
  });

  test('should throw an exception when repository login fails', () async {
    // Arrange
    when(() => mockLoginRepository.login(loginDto))
        .thenThrow(Exception('Login failed'));

    // Act & Assert
    expect(() => usecase(loginDto), throwsA(isA<Exception>()));
    verify(() => mockLoginRepository.login(loginDto)).called(1);
    verifyNoMoreInteractions(mockLoginRepository);
  });
}
