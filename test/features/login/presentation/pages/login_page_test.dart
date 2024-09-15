// test/widgets/login_page_test.dart
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youapp_tester/base/widget/password_form_field.dart';
import 'package:youapp_tester/features/login/presentation/cubit/login_cubit.dart';
import 'package:youapp_tester/features/login/presentation/pages/login_page.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

class FakeLoginState extends Fake implements LoginInitial {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeLoginState());
  });

  late LoginCubit mockLoginCubit;

  setUp(() {
    mockLoginCubit = MockLoginCubit();
  });

  Widget createWidgetUnderTest() {
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => BlocProvider<LoginCubit>.value(
            value: mockLoginCubit,
            child: const LoginPage(),
          ),
        )
      ],
    );

    return MaterialApp.router(
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }

  testWidgets('displays login form initially', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pumpAndSettle(const Duration(seconds: 1));
    var widgets = tester.widgetList(find.byType(Widget));

    expect(find.byType(MaterialApp), findsOneWidget);
    expect(find.byType(FormBuilder), findsOneWidget);
    expect(find.text('Login'), findsOneWidget);
    expect(find.byType(FormBuilderTextField), findsNWidgets(3));
    expect(find.byType(FilledButton), findsOneWidget);
  });

  testWidgets('shows loading indicator when state is LoginLoading',
      (WidgetTester tester) async {
    when(() => mockLoginCubit.state).thenReturn(LoginLoading());

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(); // Allow animations to complete

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('navigates on successful login', (WidgetTester tester) async {
    when(() => mockLoginCubit.state)
        .thenReturn(const LoginSuccess(accessToken: ''));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(); // Allow animations to complete

    expect(find.byType(CircularProgressIndicator), findsNothing);
    // Replace with your navigation expectations
    // e.g., expect(GoRouter.of(context).location, '/');
  });

  testWidgets('shows error message on login failure',
      (WidgetTester tester) async {
    when(() => mockLoginCubit.state)
        .thenReturn(LoginFailed(e: Exception('Login failed')));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(); // Allow animations to complete

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('Login failed'), findsOneWidget);
  });

  testWidgets('enables login button when form is valid',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    // Fill in the form
    await tester.enterText(
        find.byType(FormBuilderTextField).at(0), 'test@example.com');
    await tester.enterText(find.byType(FormBuilderTextField).at(1), 'testuser');
    await tester.enterText(find.byType(PasswordFormField), 'password123');

    // Trigger form validation
    await tester.pump();

    // Ensure that the button is enabled
    final button = tester.widget<FilledButton>(find.byType(FilledButton));
    expect(button.onPressed, isNotNull);
  });

  testWidgets('disables login button when form is invalid',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    // Trigger form validation without entering any data
    await tester.pump();

    // Ensure that the button is disabled
    final button = tester.widget<FilledButton>(find.byType(FilledButton));
    expect(button.onPressed, isNull);
  });
}
