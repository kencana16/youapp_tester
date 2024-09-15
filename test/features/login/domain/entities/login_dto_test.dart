import 'package:flutter_test/flutter_test.dart';
import 'package:youapp_tester/features/login/domain/entities/login_dto.dart';

void main() {
  group('LoginDto', () {
    const loginDto = LoginDto(
      email: 'test@example.com',
      username: 'testuser',
      password: 'password',
    );

    test('should convert to map correctly', () {
      // Act
      final map = loginDto.toMap();

      // Assert
      expect(map, {
        'email': 'test@example.com',
        'username': 'testuser',
        'password': 'password',
      });
    });

    test('should convert from map correctly', () {
      // Arrange
      final map = {
        'email': 'test@example.com',
        'username': 'testuser',
        'password': 'password',
      };

      // Act
      final result = LoginDto.fromMap(map);

      // Assert
      expect(result, loginDto);
    });

    test('should convert to JSON correctly', () {
      // Act
      final json = loginDto.toJson();

      // Assert
      expect(json,
          '{"email":"test@example.com","username":"testuser","password":"password"}');
    });

    test('should convert from JSON correctly', () {
      // Arrange
      const jsonString =
          '{"email":"test@example.com","username":"testuser","password":"password"}';

      // Act
      final result = LoginDto.fromJson(jsonString);

      // Assert
      expect(result, loginDto);
    });

    test('should return true for equality when data is the same', () {
      // Arrange
      const loginDto2 = LoginDto(
        email: 'test@example.com',
        username: 'testuser',
        password: 'password',
      );

      // Assert
      expect(loginDto, loginDto2);
    });

    test('copyWith should update the specified fields', () {
      // Act
      final modifiedDto = loginDto.copyWith(username: 'newuser');

      // Assert
      expect(modifiedDto.username, 'newuser');
      expect(modifiedDto.email, 'test@example.com');
      expect(modifiedDto.password, 'password');
    });

    test('hashCode should be consistent for equal objects', () {
      // Arrange
      const loginDto2 = LoginDto(
        email: 'test@example.com',
        username: 'testuser',
        password: 'password',
      );

      // Assert
      expect(loginDto.hashCode, loginDto2.hashCode);
    });
  });
}
