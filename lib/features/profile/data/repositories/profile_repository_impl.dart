import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:youapp_tester/features/profile/data/datasources/profile_datasource.dart';
import 'package:youapp_tester/features/profile/domain/entities/profile.dart';
import 'package:youapp_tester/features/profile/domain/repositories/profile_repository.dart';

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDatasource _profileDatasource;

  ProfileRepositoryImpl(this._profileDatasource);

  @override
  Future<Profile> getProfile(String accessToken) {
    try {
      return _profileDatasource.getProfile(accessToken);
    } catch (e, s) {
      debugPrintStack(
        stackTrace: s,
        label: "LoginRepositoryImpl.login",
      );
      rethrow;
    }
  }

  @override
  Future<bool> updateProfile(String accessToken, Profile params) {
    try {
      return _profileDatasource.updateProfile(accessToken, params);
    } catch (e, s) {
      debugPrintStack(
        stackTrace: s,
        label: "LoginRepositoryImpl.login",
      );
      rethrow;
    }
  }
}
