import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youapp_tester/features/login/data/datasources/login_datasource.dart';
import 'package:youapp_tester/base/data/shared_preference_datasource.dart';
import 'package:youapp_tester/features/login/domain/entities/login_dto.dart';
import 'package:youapp_tester/features/login/domain/entities/register_dto.dart';
import 'package:youapp_tester/features/login/data/repositories/login_repository_impl.dart';

class MockLoginDatasource extends Mock implements LoginDatasource {}

class MockSharedPreferenceDatasource extends Mock
    implements SharedPreferenceDatasource {}

void main() {
  late LoginRepositoryImpl repository;
  late MockLoginDatasource mockLoginDatasource;
  late MockSharedPreferenceDatasource mockSharedPreferenceDatasource;

  setUp(() {
    mockLoginDatasource = MockLoginDatasource();
    mockSharedPreferenceDatasource = MockSharedPreferenceDatasource();
    repository = LoginRepositoryImpl(
      mockSharedPreferenceDatasource,
      mockLoginDatasource,
    );
  });

  group('LoginRepositoryImpl', () {
    const String accessToken = 'dummyAccessToken';

    test('should return access token when login is successful', () async {
      // Arrange
      const loginDto = LoginDto(
        username: 'testuser',
        password: 'password',
        email: 'test@example.com',
      );
      when(() => mockLoginDatasource.login(loginDto))
          .thenAnswer((_) async => accessToken);

      // Act
      final result = await repository.login(loginDto);

      // Assert
      expect(result, accessToken);
      verify(() => mockLoginDatasource.login(loginDto)).called(1);
      verifyNoMoreInteractions(mockLoginDatasource);
    });

    test('should throw exception when login fails', () async {
      // Arrange
      const loginDto = LoginDto(
        username: 'testuser',
        password: 'password',
        email: 'test@example.com',
      );
      when(() => mockLoginDatasource.login(loginDto))
          .thenThrow(Exception('Login failed'));

      // Act & Assert
      expect(() => repository.login(loginDto), throwsException);
      verify(() => mockLoginDatasource.login(loginDto)).called(1);
      verifyNoMoreInteractions(mockLoginDatasource);
    });

    test('should return true when registration is successful', () async {
      // Arrange
      final registerDto = RegisterDto(
        username: 'testuser',
        password: 'password',
        email: 'test@example.com',
      );
      when(() => mockLoginDatasource.register(registerDto))
          .thenAnswer((_) async => true);

      // Act
      final result = await repository.register(registerDto);

      // Assert
      expect(result, true);
      verify(() => mockLoginDatasource.register(registerDto)).called(1);
      verifyNoMoreInteractions(mockLoginDatasource);
    });

    test('should throw exception when registration fails', () async {
      // Arrange
      final registerDto = RegisterDto(
        username: 'testuser',
        password: 'password',
        email: 'test@example.com',
      );
      when(() => mockLoginDatasource.register(registerDto))
          .thenThrow(Exception('Registration failed'));

      // Act & Assert
      expect(() => repository.register(registerDto), throwsException);
      verify(() => mockLoginDatasource.register(registerDto)).called(1);
      verifyNoMoreInteractions(mockLoginDatasource);
    });

    test('should return saved access token', () async {
      // Arrange
      when(() => mockSharedPreferenceDatasource.getAccessToken())
          .thenAnswer((_) async => accessToken);

      // Act
      final result = await repository.getAccessToken();

      // Assert
      expect(result, accessToken);
      verify(() => mockSharedPreferenceDatasource.getAccessToken()).called(1);
      verifyNoMoreInteractions(mockSharedPreferenceDatasource);
    });

    test('should save access token', () async {
      // Arrange
      when(() => mockSharedPreferenceDatasource.saveAccessToken(accessToken))
          .thenAnswer((_) async => true);

      // Act
      final result = await repository.saveAccessToken(accessToken);

      // Assert
      expect(result, true);
      verify(() => mockSharedPreferenceDatasource.saveAccessToken(accessToken))
          .called(1);
      verifyNoMoreInteractions(mockSharedPreferenceDatasource);
    });

    test('should revoke access token', () async {
      // Arrange
      when(() => mockSharedPreferenceDatasource.revokeAccessToken())
          .thenAnswer((_) async => true);

      // Act
      final result = await repository.revokeAccessToken();

      // Assert
      expect(result, true);
      verify(() => mockSharedPreferenceDatasource.revokeAccessToken())
          .called(1);
      verifyNoMoreInteractions(mockSharedPreferenceDatasource);
    });
  });
}
