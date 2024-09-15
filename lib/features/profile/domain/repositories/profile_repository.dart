import 'package:youapp_tester/features/profile/domain/entities/profile.dart';

abstract class ProfileRepository {
  Future<bool> updateProfile(String accessToken, Profile params);
  Future<Profile> getProfile(String accessToken);
}
