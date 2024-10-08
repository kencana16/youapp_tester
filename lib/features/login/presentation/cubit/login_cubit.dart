import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youapp_tester/base/usecase.dart';
import 'package:youapp_tester/features/login/domain/entities/login_dto.dart';
import 'package:youapp_tester/features/login/domain/entities/register_dto.dart';
import 'package:youapp_tester/features/login/domain/usecases/get_access_token.dart';
import 'package:youapp_tester/features/login/domain/usecases/post_login.dart';
import 'package:youapp_tester/features/login/domain/usecases/post_register.dart';
import 'package:youapp_tester/features/login/domain/usecases/revoke_access_token.dart';
import 'package:youapp_tester/features/login/domain/usecases/save_access_token.dart';

import '../../../../base/error/custom_exception.dart';
import '../../../../dependencies.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final PostLogin _postLogin;
  final PostRegister _postRegister;
  final GetAccessToken _getAccessToken;
  final SaveAccessToken _saveAccessToken;
  final RevokeAccessToken _revokeAccessToken;

  LoginCubit({
    PostLogin? postLogin,
    PostRegister? postRegister,
    GetAccessToken? getAccessToken,
    SaveAccessToken? saveAccessToken,
    RevokeAccessToken? revokeAccessToken,
  })  : _postLogin = postLogin ?? getIt<PostLogin>(),
        _postRegister = postRegister ?? getIt<PostRegister>(),
        _getAccessToken = getAccessToken ?? getIt<GetAccessToken>(),
        _saveAccessToken = saveAccessToken ?? getIt<SaveAccessToken>(),
        _revokeAccessToken = revokeAccessToken ?? getIt<RevokeAccessToken>(),
        super(LoginInitial()) {
    this.getAccessToken(emitNothingwhenEmpty: true);
  }

  @override
  void onChange(Change<LoginState> change) {
    debugPrint("=========================---");
    debugPrint(change.currentState.toString());
    debugPrint(change.nextState.toString());
    debugPrint("=========================---");
    super.onChange(change);
  }

  Future<void> login({
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      emit(LoginLoading());
      _postLogin
          .call(LoginDto(
        email: email,
        username: username,
        password: password,
      ))
          .then(
        (accessToken) async {
          await saveAccessToken(accessToken);
        },
        onError: (e, s) {
          emit(LoginFailed(e: e));
        },
      );
    } on Exception catch (e) {
      emit(LoginFailed(e: e));
    }
  }

  Future<void> register({
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      emit(LoginLoading());
      _postRegister
          .call(RegisterDto(
        email: email,
        username: username,
        password: password,
      ))
          .then(
        (success) async {
          if (success) {
            await login(
              email: email,
              username: username,
              password: password,
            );
            return;
          }

          emit(const LoginFailed(
              e: CustomException("Gagal melakukan pendaftaran")));
        },
        onError: (e, s) {
          emit(LoginFailed(e: e));
        },
      );
    } on Exception catch (e) {
      emit(LoginFailed(e: e));
    }
  }

  Future<void> getAccessToken({
    bool emitNothingwhenEmpty = false,
  }) async {
    try {
      await _getAccessToken.call(NoParams()).then(
        (value) {
          if (value != null) {
            emit(LoginSuccess(accessToken: value));
          } else {
            if (!emitNothingwhenEmpty) {
              emit(const LoginFailed(
                  e: CustomException("Access Token not saved")));
            }
          }
        },
        onError: (e, s) {
          debugPrintStack(
            stackTrace: s,
            label: e.toString(),
          );
        },
      );
    } on Exception catch (e, s) {
      debugPrintStack(
        stackTrace: s,
        label: e.toString(),
      );
    }
  }

  Future<void> saveAccessToken(String accessToken) async {
    try {
      await _saveAccessToken.call(accessToken).then(
        (value) async {
          if (value) {
            await getAccessToken();
          } else {
            emit(const LoginFailed(
                e: CustomException("Access Token fail to save")));
          }
        },
        onError: (e, s) {
          debugPrintStack(
            stackTrace: s,
            label: e.toString(),
          );
        },
      );
    } on Exception catch (e, s) {
      debugPrintStack(
        stackTrace: s,
        label: e.toString(),
      );
    }
  }

  Future<void> revokeAccessToken() async {
    if (state is LoginInitial) {
      return;
    }

    await _revokeAccessToken.call(NoParams()).then(
      (value) {
        if (value) {
          emit(const LoginFailed(e: CustomException("Access Token invalid")));
        }
      },
      onError: (e, s) {
        debugPrintStack(
          stackTrace: s,
          label: e.toString(),
        );
      },
    );
  }

  Future<void> logout() async {
    await _revokeAccessToken.call(NoParams()).then(
      (value) {
        if (value) {
          emit(LoginInitial());
        }
      },
      onError: (e, s) {
        debugPrintStack(
          stackTrace: s,
          label: e.toString(),
        );
      },
    );
  }
}
