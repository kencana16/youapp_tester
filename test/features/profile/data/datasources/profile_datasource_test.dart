import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youapp_tester/base/error/custom_exception.dart';
import 'package:youapp_tester/features/profile/data/datasources/profile_datasource.dart';
import 'package:youapp_tester/features/profile/domain/entities/profile.dart';

class MockDio extends Mock implements Dio {}

void main() {
  late ProfileDatasourceImpl profileDatasource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    when(() => mockDio.interceptors).thenReturn(Interceptors());

    profileDatasource = ProfileDatasourceImpl(dio: mockDio);
    verify(() => mockDio.interceptors).called(1);
  });

  group('ProfileDatasourceImpl', () {
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
    final Map<String, dynamic> profileJson = profile.toJson();

    test('should return Profile when getProfile is successful', () async {
      when(() => mockDio.get<Map<String, dynamic>>(
            '/getProfile',
            options: any(named: 'options'),
          )).thenAnswer((_) async => Response<Map<String, dynamic>>(
            requestOptions: RequestOptions(path: '/getProfile'),
            statusCode: 200,
            data: {'data': profileJson},
          ));

      final result = await profileDatasource.getProfile(accessToken);

      expect(result, equals(profile));

      verify(() => mockDio.get<Map<String, dynamic>>(
            '/getProfile',
            options: any(named: 'options'),
          )).called(1);
      verifyNoMoreInteractions(mockDio);
    });

    test('should throw CustomException when getProfile fails', () async {
      when(() => mockDio.get<Map<String, dynamic>>(
            '/getProfile',
            options: any(named: 'options'),
          )).thenAnswer((_) async => Response<Map<String, dynamic>>(
            requestOptions: RequestOptions(path: '/getProfile'),
            statusCode: 400,
            data: {'message': 'Failed to retrieve profile'},
          ));

      expect(
        () => profileDatasource.getProfile(accessToken),
        throwsA(isA<CustomException>()),
      );

      verify(() => mockDio.get<Map<String, dynamic>>(
            '/getProfile',
            options: any(named: 'options'),
          )).called(1);
      verifyNoMoreInteractions(mockDio);
    });

    test('should return true when updateProfile is successful', () async {
      when(() => mockDio.put<Map<String, dynamic>>(
            '/updateProfile',
            options: any(named: 'options'),
            data: profile.toJson(),
          )).thenAnswer((_) async => Response<Map<String, dynamic>>(
            requestOptions: RequestOptions(path: '/updateProfile'),
            statusCode: 200,
          ));

      final result =
          await profileDatasource.updateProfile(accessToken, profile);

      expect(result, isTrue);

      verify(() => mockDio.put<Map<String, dynamic>>(
            '/updateProfile',
            options: any(named: 'options'),
            data: profile.toJson(),
          )).called(1);
      verifyNoMoreInteractions(mockDio);
    });

    test('should throw CustomException when updateProfile fails', () async {
      when(() => mockDio.put<Map<String, dynamic>>(
            '/updateProfile',
            options: any(named: 'options'),
            data: profile.toJson(),
          )).thenAnswer((_) async => Response<Map<String, dynamic>>(
            requestOptions: RequestOptions(path: '/updateProfile'),
            statusCode: 400,
            data: {'message': 'Failed to update profile'},
          ));

      expect(
        () => profileDatasource.updateProfile(accessToken, profile),
        throwsA(isA<CustomException>()),
      );

      verify(() => mockDio.put<Map<String, dynamic>>(
            '/updateProfile',
            options: any(named: 'options'),
            data: profile.toJson(),
          )).called(1);
      verifyNoMoreInteractions(mockDio);
    });
  });
}
