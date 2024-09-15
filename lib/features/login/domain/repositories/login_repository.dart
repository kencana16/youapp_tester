import 'package:youapp_tester/features/login/domain/entities/login_dto.dart';
import 'package:youapp_tester/features/login/domain/entities/register_dto.dart';

abstract class LoginRepository {
  Future<bool> revokeAccessToken();
  Future<bool> saveAccessToken(String accessToken);
  Future<String?> getAccessToken();

  Future<String> login(LoginDto dto);
  Future<bool> register(RegisterDto dto);
}
