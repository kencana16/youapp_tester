import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:youapp_tester/base/data/you_app_datasource.dart';
import 'package:youapp_tester/features/login/domain/entities/login_dto.dart';
import 'package:youapp_tester/features/login/domain/entities/register_dto.dart';

import '../../../../base/error/custom_exception.dart';

abstract class LoginDatasource {
  Future<String> login(LoginDto dto);

  Future<bool> register(RegisterDto dto);
}

@Injectable(as: LoginDatasource)
class LoginDatasourceImpl extends YouAppDatasource implements LoginDatasource {
  LoginDatasourceImpl({super.dio});

  @override
  Future<String> login(LoginDto dto) async {
    try {
      Response<Map<String, dynamic>> res = await dio.post<Map<String, dynamic>>(
        '/login',
        data: dto.toJson(),
      );

      if ((res.statusCode == 200 || res.statusCode == 201) &&
          res.data?.containsKey('access_token') == true) {
        return res.data!['access_token'] as String;
      } else {
        throw CustomException(res.data?['message']?.toString());
      }
    } catch (e, s) {
      debugPrintStack(
        stackTrace: s,
        label: "LoginDatasourceImpl.login",
      );
      rethrow;
    }
  }

  @override
  Future<bool> register(RegisterDto dto) async {
    try {
      Response<Map<String, dynamic>> res = await dio.post<Map<String, dynamic>>(
        '/register',
        data: dto.toJson(),
      );

      if (res.statusCode == 201) {
        if (res.data?['message'] == 'User already exists') {
          throw CustomException(res.data?['message']?.toString());
        }

        return true;
      } else {
        throw CustomException(res.data?['message']?.toString());
      }
    } catch (e, s) {
      debugPrintStack(
        stackTrace: s,
        label: "LoginDatasourceImpl.register",
      );
      rethrow;
    }
  }
}
