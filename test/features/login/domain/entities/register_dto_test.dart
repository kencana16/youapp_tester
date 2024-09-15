import 'package:flutter_test/flutter_test.dart';
import 'package:youapp_tester/features/login/domain/entities/register_dto.dart';

void main() {
  group('RegisterDto', () {
    final registerDto = RegisterDto(
      email: 'test@example.com',
      username: 'testuser',
      password: 'password',
    );

    test('should convert to map correctly', () {
      // Act
      final map = registerDto.toMap();

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
      final result = RegisterDto.fromMap(map);

      // Assert
      expect(result, registerDto);
    });

    test('should convert to JSON correctly', () {
      // Act
      final json = registerDto.toJson();

      // Assert
      expect(json,
          '{"email":"test@example.com","username":"testuser","password":"password"}');
    });

    test('should convert from JSON correctly', () {
      // Arrange
      const jsonString =
          '{"email":"test@example.com","username":"testuser","password":"password"}';

      // Act
      final result = RegisterDto.fromJson(jsonString);

      // Assert
      expect(result, registerDto);
    });

    test('should return true for equality when data is the same', () {
      // Arrange
      final registerDto2 = RegisterDto(
        email: 'test@example.com',
        username: 'testuser',
        password: 'password',
      );

      // Assert
      expect(registerDto, registerDto2);
    });

    test('copyWith should update the specified fields', () {
      // Act
      final modifiedDto = registerDto.copyWith(username: 'newuser');

      // Assert
      expect(modifiedDto.username, 'newuser');
      expect(modifiedDto.email, 'test@example.com');
      expect(modifiedDto.password, 'password');
    });

    test('hashCode should be consistent for equal objects', () {
      // Arrange
      final registerDto2 = RegisterDto(
        email: 'test@example.com',
        username: 'testuser',
        password: 'password',
      );

      // Assert
      expect(registerDto.hashCode, registerDto2.hashCode);
    });
  });
}
