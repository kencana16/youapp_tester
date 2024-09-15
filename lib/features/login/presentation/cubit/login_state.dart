part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];

  String getAccessToken() {
    var state = this;

    return switch (state) {
      LoginInitial() => "",
      LoginLoading() => "",
      LoginSuccess() => state.accessToken,
      LoginFailed() => "",
    };
  }
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final String accessToken;

  const LoginSuccess({required this.accessToken});

  @override
  List<Object> get props => [accessToken];
}

class LoginFailed extends LoginState {
  final Exception e;

  const LoginFailed({required this.e});

  @override
  List<Object> get props => [e];
}
