import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youapp_tester/base/data/shared_preference_datasource.dart';

// Define a Mock class for SharedPreferences
class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late MockSharedPreferences mockPrefs;
  late SharedPreferenceDatasourceImpl datasource;

  setUp(() {
    mockPrefs = MockSharedPreferences();
    datasource = SharedPreferenceDatasourceImpl(mockPrefs); // Inject mockPrefs
  });

  tearDown(() {
    reset(
        mockPrefs); // Reset the mock after each test to avoid shared state issues
  });

  group('SharedPreferenceDatasourceImpl', () {
    const accessToken = 'dummyAccessToken';

    test('getAccessToken returns access token', () async {
      // Arrange
      when(() => mockPrefs
              .getString(SharedPreferenceDatasourceImpl.access_token_key))
          .thenReturn(accessToken);

      // Act
      final result = await datasource.getAccessToken();

      // Assert
      expect(result, accessToken);
      verify(() => mockPrefs.getString(
          SharedPreferenceDatasourceImpl.access_token_key)).called(1);
    });

    test('saveAccessToken saves access token', () async {
      // Arrange
      when(() => mockPrefs.setString(
              SharedPreferenceDatasourceImpl.access_token_key, accessToken))
          .thenAnswer((_) async => true);

      // Act
      final result = await datasource.saveAccessToken(accessToken);

      // Assert
      expect(result, true);
      verify(() => mockPrefs.setString(
              SharedPreferenceDatasourceImpl.access_token_key, accessToken))
          .called(1);
    });

    test('revokeAccessToken removes access token', () async {
      // Arrange
      when(() =>
              mockPrefs.remove(SharedPreferenceDatasourceImpl.access_token_key))
          .thenAnswer((_) async => true);

      // Act
      final result = await datasource.revokeAccessToken();

      // Assert
      expect(result, true);
      verify(() =>
              mockPrefs.remove(SharedPreferenceDatasourceImpl.access_token_key))
          .called(1);
    });

    test('should correctly handle access token lifecycle', () async {
      // Arrange
      // Mocking the initial getString call to return null (since this should be the fresh state)
      when(() => mockPrefs.getString(
          SharedPreferenceDatasourceImpl.access_token_key)).thenReturn(null);
      when(() => mockPrefs.setString(
              SharedPreferenceDatasourceImpl.access_token_key, accessToken))
          .thenAnswer((_) async => true);
      when(() =>
              mockPrefs.remove(SharedPreferenceDatasourceImpl.access_token_key))
          .thenAnswer((_) async => true);

      // Act: Check current access token
      final initialToken = await datasource.getAccessToken();

      // Assert: Verify initial token is null
      expect(initialToken, null);

      // Act: Set access token
      final setResult = await datasource.saveAccessToken(accessToken);

      // Assert: Verify token was set correctly
      expect(setResult, true);
      verify(() => mockPrefs.setString(
              SharedPreferenceDatasourceImpl.access_token_key, accessToken))
          .called(1);

      // Act: Verify token was set
      when(() => mockPrefs
              .getString(SharedPreferenceDatasourceImpl.access_token_key))
          .thenReturn(accessToken);
      final tokenAfterSet = await datasource.getAccessToken();

      // Assert: Verify token after setting it
      expect(tokenAfterSet, accessToken);
      verify(() => mockPrefs.getString(
          SharedPreferenceDatasourceImpl.access_token_key)).called(2);

      // Act: Revoke access token
      final revokeResult = await datasource.revokeAccessToken();

      // Assert: Verify token was revoked correctly
      expect(revokeResult, true);
      verify(() =>
              mockPrefs.remove(SharedPreferenceDatasourceImpl.access_token_key))
          .called(1);

      // Act: Verify token is null after revoking
      when(() => mockPrefs.getString(
          SharedPreferenceDatasourceImpl.access_token_key)).thenReturn(null);
      final tokenAfterRevoke = await datasource.getAccessToken();

      // Assert: Verify token is null after revoking
      expect(tokenAfterRevoke, null);
    });
  });
}
