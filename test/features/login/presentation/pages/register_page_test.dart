// test/widgets/register_page_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youapp_tester/base/widget/password_form_field.dart';
import 'package:youapp_tester/features/login/presentation/cubit/login_cubit.dart';
import 'package:youapp_tester/features/login/presentation/pages/register_page.dart';

class MockLoginCubit extends Mock implements LoginCubit {}

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
    return MaterialApp(
      home: BlocProvider<LoginCubit>.value(
        value: mockLoginCubit,
        child: const RegisterPage(),
      ),
    );
  }

  testWidgets('displays register form initially', (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(FormBuilder), findsOneWidget);
    expect(find.text('Register'), findsOneWidget);
    expect(find.byType(FormBuilderTextField), findsNWidgets(4));
    expect(find.byType(FilledButton), findsOneWidget);
  });

  testWidgets('shows loading indicator when state is LoginLoading',
      (WidgetTester tester) async {
    when(() => mockLoginCubit.state).thenReturn(LoginLoading());

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(); // Allow animations to complete

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('navigates on successful registration',
      (WidgetTester tester) async {
    when(() => mockLoginCubit.state).thenReturn(const LoginSuccess(accessToken: ''));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(); // Allow animations to complete

    expect(find.byType(CircularProgressIndicator), findsNothing);
    // Replace with your navigation expectations
    // e.g., expect(GoRouter.of(context).location, '/');
  });

  testWidgets('shows error message on registration failure',
      (WidgetTester tester) async {
    when(() => mockLoginCubit.state)
        .thenReturn(LoginFailed(e: Exception('Registration failed')));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(); // Allow animations to complete

    expect(find.byType(CircularProgressIndicator), findsNothing);
    expect(find.text('Registration failed'), findsOneWidget);
  });

  testWidgets('enables register button when form is valid',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    // Fill in the form
    await tester.enterText(
        find.byType(FormBuilderTextField).at(0), 'test@example.com');
    await tester.enterText(find.byType(FormBuilderTextField).at(1), 'testuser');
    await tester.enterText(find.byType(PasswordFormField).first, 'password123');
    await tester.enterText(find.byType(PasswordFormField).last, 'password123');

    // Trigger form validation
    await tester.pump();

    // Ensure that the button is enabled
    final button = tester.widget<FilledButton>(find.byType(FilledButton));
    expect(button.onPressed, isNotNull);
  });

  testWidgets('disables register button when form is invalid',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest());

    // Trigger form validation without entering any data
    await tester.pump();

    // Ensure that the button is disabled
    final button = tester.widget<FilledButton>(find.byType(FilledButton));
    expect(button.onPressed, isNull);
  });
}
