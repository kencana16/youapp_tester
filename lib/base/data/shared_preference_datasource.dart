// ignore_for_file: constant_identifier_names

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SharedPreferenceDatasource {
  Future<String?> getAccessToken();
  Future<bool> saveAccessToken(String accessToken);

  Future<bool> revokeAccessToken();
}

@Injectable(as: SharedPreferenceDatasource)
class SharedPreferenceDatasourceImpl implements SharedPreferenceDatasource {
  static const String access_token_key = 'accessToken';

  // Inject SharedPreferences via constructor
  final SharedPreferences sharedPreferences;

  SharedPreferenceDatasourceImpl(this.sharedPreferences);

  @override
  Future<String?> getAccessToken() async {
    return sharedPreferences.getString(access_token_key);
  }

  @override
  Future<bool> saveAccessToken(String accessToken) async {
    return await sharedPreferences.setString(access_token_key, accessToken);
  }

  @override
  Future<bool> revokeAccessToken() async {
    return await sharedPreferences.remove(access_token_key);
  }
}
