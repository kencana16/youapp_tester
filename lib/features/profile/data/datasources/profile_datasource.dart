import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:youapp_tester/base/data/you_app_datasource.dart';
import 'package:youapp_tester/features/profile/domain/entities/profile.dart';

import '../../../../base/error/custom_exception.dart';

abstract class ProfileDatasource {
  Future<Profile> getProfile(String accessToken);
  Future<bool> updateProfile(
    String accessToken,
    Profile profile,
  );
}

@Injectable(as: ProfileDatasource)
class ProfileDatasourceImpl extends YouAppDatasource
    implements ProfileDatasource {
  ProfileDatasourceImpl({super.dio});

  Map<String, String> generateHeader(String accessToken) => {
        'x-access-token': accessToken,
      };

  @override
  Future<Profile> getProfile(String accessToken) async {
    try {
      Response<Map<String, dynamic>> res = await dio.get<Map<String, dynamic>>(
        '/getProfile',
        options: Options(
          headers: generateHeader(accessToken),
        ),
      );

      if (res.statusCode == 200) {
        return Profile.fromJson(res.data!['data']);
      } else {
        throw CustomException(res.data?['message']?.toString());
      }
    } catch (e, s) {
      debugPrintStack(
        stackTrace: s,
        label: "LoginDatasourceImpl.getProfile",
      );
      rethrow;
    }
  }

  @override
  Future<bool> updateProfile(String accessToken, Profile profile) async {
    try {
      Response<Map<String, dynamic>> res = await dio.put<Map<String, dynamic>>(
        '/updateProfile',
        options: Options(
          headers: generateHeader(accessToken),
        ),
        data: profile.toJson(),
      );

      if (res.statusCode == 200) {
        return true;
      } else {
        throw CustomException(res.data?['message']?.toString());
      }
    } catch (e, s) {
      debugPrintStack(
        stackTrace: s,
        label: "LoginDatasourceImpl.updateProfile",
      );
      rethrow;
    }
  }
}
