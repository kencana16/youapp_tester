import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:youapp_tester/base/page/error_page.dart';
import 'package:youapp_tester/features/login/presentation/cubit/login_cubit.dart';
import 'package:youapp_tester/features/login/presentation/pages/login_page.dart';
import 'package:youapp_tester/features/profile/presentation/pages/interest_form_page.dart';
import 'package:youapp_tester/features/profile/presentation/pages/profile_page.dart';
import 'package:youapp_tester/features/login/presentation/pages/register_page.dart';

import '../features/profile/presentation/bloc/profile_bloc.dart';

part 'app_router.g.dart';

String? _redirectToLoginPage(
  BuildContext context,
  GoRouterState state, {
  String? from,
}) {
  bool loginValid = context.read<LoginCubit>().state is LoginSuccess;
  if (loginValid) {
    return null;
  } else {
    return LoginRoute(from: from).location;
  }
}

/// will return to [to] or '/' location when login is valid
String? _redirectFromLoginPage(
  BuildContext context,
  GoRouterState state, {
  String? to,
}) {
  bool loginValid = context.read<LoginCubit>().state is LoginSuccess;
  if (loginValid) {
    return to ?? '/';
  } else {
    return null;
  }
}

class ErrorRoute extends GoRouteData {
  final Exception error;

  const ErrorRoute({required this.error});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return ErrorPage(error: error);
  }
}

@TypedShellRoute<ProfileShellRoute>(
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<ProfileRoute>(
      path: '/',
      routes: [
        TypedGoRoute<InterestFormRoute>(
          path: 'interest',
        ),
      ],
    ),
  ],
)
class ProfileShellRoute extends ShellRouteData {
  @override
  Widget builder(BuildContext context, GoRouterState state, Widget navigator) {
    return BlocProvider(
      create: (context) {
        var loginCubit = context.read<LoginCubit>();
        var profileBloc = ProfileBloc(
          revokeAccessToken: loginCubit.revokeAccessToken,
        );

        var accessToken = loginCubit.state.getAccessToken();
        profileBloc.add(ProfileEventChangeToken(accessToken: accessToken));
        return profileBloc;
      },
      child: BlocListener<LoginCubit, LoginState>(
        listenWhen: (previous, current) {
          String? accessTokenPrev = previous.getAccessToken();
          String? accessTokenCurr = current.getAccessToken();

          return accessTokenPrev != accessTokenCurr;
        },
        listener: (context, state) {
          var accessToken = state.getAccessToken();

          if (accessToken.isEmpty) {
            context.read<ProfileBloc>().add(ProfileEventReset());
          } else {
            context
                .read<ProfileBloc>()
                .add(ProfileEventChangeToken(accessToken: accessToken));
          }
        },
        child: navigator,
      ),
    );
  }
}

class ProfileRoute extends GoRouteData {
  const ProfileRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const ProfilePage();

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    return _redirectToLoginPage(
      context,
      state,
      from: location,
    );
  }
}

class InterestFormRoute extends GoRouteData {
  const InterestFormRoute();

  @override
  Widget build(BuildContext context, GoRouterState state) =>
      const InterestFormPage();

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    return _redirectToLoginPage(
      context,
      state,
      from: location,
    );
  }
}

@TypedGoRoute<LoginRoute>(
  path: '/login',
)
class LoginRoute extends GoRouteData {
  final String? from;

  const LoginRoute({this.from});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return LoginPage(from: from);
  }

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    return _redirectFromLoginPage(
      context,
      state,
      to: from,
    );
  }
}

@TypedGoRoute<RegisterRoute>(
  path: '/register',
)
class RegisterRoute extends GoRouteData {
  final String? from;
  const RegisterRoute({this.from});

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return RegisterPage(
      from: from,
    );
  }

  @override
  FutureOr<String?> redirect(BuildContext context, GoRouterState state) {
    return _redirectFromLoginPage(
      context,
      state,
    );
  }
}
