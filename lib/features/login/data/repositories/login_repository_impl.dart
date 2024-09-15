import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:youapp_tester/features/login/data/datasources/login_datasource.dart';
import 'package:youapp_tester/base/data/shared_preference_datasource.dart';
import 'package:youapp_tester/features/login/domain/entities/login_dto.dart';
import 'package:youapp_tester/features/login/domain/entities/register_dto.dart';
import 'package:youapp_tester/features/login/domain/repositories/login_repository.dart';

@Injectable(as: LoginRepository)
class LoginRepositoryImpl implements LoginRepository {
  final SharedPreferenceDatasource _sharedPreferenceDatasource;
  final LoginDatasource _loginDatasource;

  LoginRepositoryImpl(
    this._sharedPreferenceDatasource,
    this._loginDatasource,
  );

  @override
  Future<String> login(LoginDto dto) {
    try {
      return _loginDatasource.login(dto);
    } catch (e, s) {
      debugPrintStack(
        stackTrace: s,
        label: "LoginRepositoryImpl.login",
      );
      rethrow;
    }
  }

  @override
  Future<bool> register(RegisterDto dto) {
    try {
      return _loginDatasource.register(dto);
    } catch (e, s) {
      debugPrintStack(
        stackTrace: s,
        label: "LoginRepositoryImpl.register",
      );
      rethrow;
    }
  }

  @override
  Future<String?> getAccessToken() {
    try {
      return _sharedPreferenceDatasource.getAccessToken();
    } catch (e, s) {
      debugPrintStack(
        stackTrace: s,
        label: "LoginRepositoryImpl.getAccessToken",
      );
      rethrow;
    }
  }

  @override
  Future<bool> saveAccessToken(String accessToken) {
    try {
      return _sharedPreferenceDatasource.saveAccessToken(accessToken);
    } catch (e, s) {
      debugPrintStack(
        stackTrace: s,
        label: "LoginRepositoryImpl.saveAccessToken",
      );
      rethrow;
    }
  }

  @override
  Future<bool> revokeAccessToken() {
    try {
      return _sharedPreferenceDatasource.revokeAccessToken();
    } catch (e, s) {
      debugPrintStack(
        stackTrace: s,
        label: "LoginRepositoryImpl.revokeAccessToken",
      );
      rethrow;
    }
  }
}
