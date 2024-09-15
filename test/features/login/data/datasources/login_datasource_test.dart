import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youapp_tester/base/error/custom_exception.dart';
import 'package:youapp_tester/features/login/data/datasources/login_datasource.dart';
import 'package:youapp_tester/features/login/domain/entities/login_dto.dart';
import 'package:youapp_tester/features/login/domain/entities/register_dto.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late MockDio mockDio;
  late LoginDatasourceImpl datasource;

  setUp(() {
    mockDio = MockDio();
    when(() => mockDio.interceptors).thenReturn(Interceptors());

    datasource = LoginDatasourceImpl(dio: mockDio);
    verify(() => mockDio.interceptors).called(1);
  });

  group('LoginDatasourceImpl', () {
    const accessToken = 'dummyAccessToken';

    test('login should return access token on successful login', () async {
      // Arrange
      const loginDto =
          LoginDto(username: 'test', password: 'password', email: 'email');
      final mockResponse = Response<Map<String, dynamic>>(
        data: {
          "message": "User has been logged in successfully",
          "access_token": accessToken,
        },
        statusCode: 200,
        requestOptions: RequestOptions(path: '/login'),
      );
      when(() => mockDio.post<Map<String, dynamic>>('/login',
          data: loginDto.toJson())).thenAnswer((_) async => mockResponse);

      // Act
      final result = await datasource.login(loginDto);

      // Assert
      expect(result, accessToken);
      verify(() => mockDio.post<Map<String, dynamic>>('/login',
          data: loginDto.toJson())).called(1);
      verifyNoMoreInteractions(mockDio); // Verify no more interactions
    });

    test('login should throw CustomException if access_token is missing',
        () async {
      // Arrange
      const loginDto =
          LoginDto(username: 'test', password: 'password', email: 'email');
      final mockResponse = Response<Map<String, dynamic>>(
        data: {'message': 'Invalid credentials'},
        statusCode: 401,
        requestOptions: RequestOptions(path: '/login'),
      );
      when(() => mockDio.post<Map<String, dynamic>>('/login',
          data: loginDto.toJson())).thenAnswer((_) async => mockResponse);

      // Act & Assert
      expect(() => datasource.login(loginDto), throwsA(isA<CustomException>()));
      verify(() => mockDio.post<Map<String, dynamic>>('/login',
          data: loginDto.toJson())).called(1);
      verifyNoMoreInteractions(mockDio); // Verify no more interactions
    });

    test('register should return true on successful registration', () async {
      // Arrange
      final registerDto = RegisterDto(
          username: 'test', password: 'password', email: 'test@example.com');
      final mockResponse = Response<Map<String, dynamic>>(
        data: {'message': 'User registered successfully'},
        statusCode: 201,
        requestOptions: RequestOptions(path: '/register'),
      );
      when(() => mockDio.post<Map<String, dynamic>>('/register',
          data: registerDto.toJson())).thenAnswer((_) async => mockResponse);

      // Act
      final result = await datasource.register(registerDto);

      // Assert
      expect(result, true);
      verify(() => mockDio.post<Map<String, dynamic>>('/register',
          data: registerDto.toJson())).called(1);
      verifyNoMoreInteractions(mockDio); // Verify no more interactions
    });

    test('register should throw CustomException if user already exists',
        () async {
      // Arrange
      final registerDto = RegisterDto(
          username: 'test', password: 'password', email: 'test@example.com');
      final mockResponse = Response<Map<String, dynamic>>(
        data: {'message': 'User already exists'},
        statusCode: 409,
        requestOptions: RequestOptions(path: '/register'),
      );
      when(() => mockDio.post<Map<String, dynamic>>('/register',
          data: registerDto.toJson())).thenAnswer((_) async => mockResponse);

      // Act & Assert
      expect(() => datasource.register(registerDto),
          throwsA(isA<CustomException>()));
      verify(() => mockDio.post<Map<String, dynamic>>('/register',
          data: registerDto.toJson())).called(1);
      verifyNoMoreInteractions(mockDio); // Verify no more interactions
    });
  });
}
