import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:youapp_tester/dependencies.dart';
import 'package:youapp_tester/app_theme.dart';
import 'package:youapp_tester/features/login/presentation/cubit/login_cubit.dart';
import 'package:youapp_tester/routing/app_router.dart';

GlobalKey<NavigatorState> navigationKey = GlobalKey();
void main() {
  configureDependencies();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  ValueNotifier isLoggedIn = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      navigatorKey: navigationKey,
      refreshListenable: isLoggedIn,
      initialLocation:
          const ProfileRoute().location, // location getter is generated.
      routes: $appRoutes,
    );

    return BlocProvider(
      create: (context) {
        return LoginCubit();
      },
      child: BlocListener<LoginCubit, LoginState>(
        listenWhen: (previous, current) {
          bool prevIsLoggedIn = previous is LoginSuccess;
          bool currIsLoggedIn = current is LoginSuccess;

          return prevIsLoggedIn != currIsLoggedIn;
        },
        listener: (context, state) {
          isLoggedIn.value = state is LoginSuccess;
        },
        child: MaterialApp.router(
          theme: generateTheme(context),
          routerDelegate: router.routerDelegate,
          routeInformationParser: router.routeInformationParser,
          routeInformationProvider: router.routeInformationProvider,
          builder: EasyLoading.init(),
        ),
      ),
    );
  }
}
