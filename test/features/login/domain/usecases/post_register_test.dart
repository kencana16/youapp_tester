import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youapp_tester/features/login/domain/entities/register_dto.dart';
import 'package:youapp_tester/features/login/domain/repositories/login_repository.dart';
import 'package:youapp_tester/features/login/domain/usecases/post_register.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  late MockLoginRepository mockLoginRepository;
  late PostRegister usecase;

  setUp(() {
    mockLoginRepository = MockLoginRepository();
    usecase = PostRegister(mockLoginRepository);
  });

  final registerDto = RegisterDto(
    email: 'test@example.com',
    username: 'testuser',
    password: 'password123',
  );

  test('should return true when repository register is successful', () async {
    // Arrange
    when(() => mockLoginRepository.register(registerDto))
        .thenAnswer((_) async => true);

    // Act
    final result = await usecase(registerDto);

    // Assert
    expect(result, true);
    verify(() => mockLoginRepository.register(registerDto)).called(1);
    verifyNoMoreInteractions(mockLoginRepository);
  });

  test('should throw an exception when repository register fails', () async {
    // Arrange
    when(() => mockLoginRepository.register(registerDto))
        .thenThrow(Exception('Registration failed'));

    // Act & Assert
    expect(() => usecase(registerDto), throwsA(isA<Exception>()));
    verify(() => mockLoginRepository.register(registerDto)).called(1);
    verifyNoMoreInteractions(mockLoginRepository);
  });
}
