// test/widgets/interest_form_page_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youapp_tester/features/login/presentation/cubit/login_cubit.dart';
import 'package:youapp_tester/features/profile/domain/entities/profile.dart';
import 'package:youapp_tester/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:youapp_tester/features/profile/presentation/pages/interest_form_page.dart';

class MockProfileBloc extends Mock implements ProfileBloc {}

class MockLoginCubit extends Mock implements LoginCubit {}

class FakeProfileState extends Fake implements ProfileState {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeProfileState());
  });

  late ProfileBloc mockProfileBloc;
  late LoginCubit mockLoginCubit;

  setUp(() {
    mockProfileBloc = MockProfileBloc();
    mockLoginCubit = MockLoginCubit();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<ProfileBloc>.value(
        value: mockProfileBloc,
        child: BlocProvider<LoginCubit>.value(
          value: mockLoginCubit,
          child: const InterestFormPage(),
        ),
      ),
      builder: EasyLoading.init(),
    );
  }

  testWidgets('displays form fields and save button',
      (WidgetTester tester) async {
    when(() => mockProfileBloc.state)
        .thenReturn(const ProfileFound(profile: Profile(interests: [])));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(FormBuilder), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
    expect(find.byType(InputChip), findsNothing);
    expect(find.text('Save'), findsOneWidget);
  });

  testWidgets('shows loading indicator when profile is loading',
      (WidgetTester tester) async {
    when(() => mockProfileBloc.state).thenReturn(ProfileLoading());

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(); // Allow animations to complete

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows interests and allows adding new ones',
      (WidgetTester tester) async {
    when(() => mockProfileBloc.state).thenReturn(
        const ProfileFound(profile: Profile(interests: ['Reading', 'Traveling'])));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.byType(InputChip), findsNWidgets(2));
    await tester.enterText(find.byType(TextField), 'New Interest');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump(); // Allow state changes to complete

    expect(find.text('New Interest'), findsOneWidget);
  });

  testWidgets('handles form submission', (WidgetTester tester) async {
    when(() => mockProfileBloc.state)
        .thenReturn(const ProfileFound(profile: Profile(interests: [])));
    when(() => mockLoginCubit.state)
        .thenReturn(const LoginSuccess(accessToken: 'dummy-token'));

    await tester.pumpWidget(createWidgetUnderTest());

    await tester.enterText(find.byType(TextField), 'Interest');
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pump(); // Allow state changes to complete

    await tester.tap(find.text('Save'));
    await tester.pump(); // Allow state changes to complete

    verify(() => mockProfileBloc.add(any())).called(1);
  });
}
