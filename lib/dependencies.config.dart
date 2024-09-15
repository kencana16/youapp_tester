// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i3;
import 'package:youapp_tester/base/data/shared_preference_datasource.dart'
    as _i8;
import 'package:youapp_tester/dependencies.dart' as _i18;
import 'package:youapp_tester/features/login/data/datasources/login_datasource.dart'
    as _i5;
import 'package:youapp_tester/features/login/data/repositories/login_repository_impl.dart'
    as _i10;
import 'package:youapp_tester/features/login/domain/repositories/login_repository.dart'
    as _i9;
import 'package:youapp_tester/features/login/domain/usecases/get_access_token.dart'
    as _i15;
import 'package:youapp_tester/features/login/domain/usecases/post_login.dart'
    as _i13;
import 'package:youapp_tester/features/login/domain/usecases/post_register.dart'
    as _i14;
import 'package:youapp_tester/features/login/domain/usecases/revoke_access_token.dart'
    as _i16;
import 'package:youapp_tester/features/login/domain/usecases/save_access_token.dart'
    as _i17;
import 'package:youapp_tester/features/profile/data/datasources/profile_datasource.dart'
    as _i4;
import 'package:youapp_tester/features/profile/data/repositories/profile_repository_impl.dart'
    as _i7;
import 'package:youapp_tester/features/profile/domain/repositories/profile_repository.dart'
    as _i6;
import 'package:youapp_tester/features/profile/domain/usecases/get_profile.dart'
    as _i11;
import 'package:youapp_tester/features/profile/domain/usecases/update_profile.dart'
    as _i12;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.singletonAsync<_i3.SharedPreferences>(
        () => registerModule.sharedPreferences);
    gh.factory<_i4.ProfileDatasource>(() => _i4.ProfileDatasourceImpl());
    gh.factory<_i5.LoginDatasource>(() => _i5.LoginDatasourceImpl());
    gh.factory<_i6.ProfileRepository>(
        () => _i7.ProfileRepositoryImpl(gh<_i4.ProfileDatasource>()));
    gh.factoryAsync<_i8.SharedPreferenceDatasource>(() async =>
        _i8.SharedPreferenceDatasourceImpl(
            await getAsync<_i3.SharedPreferences>()));
    gh.factoryAsync<_i9.LoginRepository>(() async => _i10.LoginRepositoryImpl(
          await getAsync<_i8.SharedPreferenceDatasource>(),
          gh<_i5.LoginDatasource>(),
        ));
    gh.factory<_i11.GetProfile>(
        () => _i11.GetProfile(gh<_i6.ProfileRepository>()));
    gh.factory<_i12.UpdateProfile>(
        () => _i12.UpdateProfile(gh<_i6.ProfileRepository>()));
    gh.factoryAsync<_i13.PostLogin>(
        () async => _i13.PostLogin(await getAsync<_i9.LoginRepository>()));
    gh.factoryAsync<_i14.PostRegister>(
        () async => _i14.PostRegister(await getAsync<_i9.LoginRepository>()));
    gh.factoryAsync<_i15.GetAccessToken>(
        () async => _i15.GetAccessToken(await getAsync<_i9.LoginRepository>()));
    gh.factoryAsync<_i16.RevokeAccessToken>(() async =>
        _i16.RevokeAccessToken(await getAsync<_i9.LoginRepository>()));
    gh.factoryAsync<_i17.SaveAccessToken>(() async =>
        _i17.SaveAccessToken(await getAsync<_i9.LoginRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i18.RegisterModule {}
