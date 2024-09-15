// test/widgets/profile_page_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youapp_tester/base/error/custom_exception.dart';
import 'package:youapp_tester/features/login/presentation/cubit/login_cubit.dart';
import 'package:youapp_tester/features/profile/domain/entities/profile.dart';
import 'package:youapp_tester/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:youapp_tester/features/profile/presentation/pages/profile_page.dart';
import 'package:youapp_tester/features/profile/presentation/widgets/profile_widget.dart';

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
          child: const ProfilePage(),
        ),
      ),
      builder: EasyLoading.init(),
    );
  }

  testWidgets('displays loading indicator when profile is loading',
      (WidgetTester tester) async {
    when(() => mockProfileBloc.state).thenReturn(ProfileLoading());

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(); // Allow animations to complete

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows error message when profile state is ProfileError',
      (WidgetTester tester) async {
    when(() => mockProfileBloc.state)
        .thenReturn(ProfileError(exception: Exception("Error occurred")));

    await tester.pumpWidget(createWidgetUnderTest());
    await tester.pump(); // Allow animations to complete

    expect(find.text("Error occurred"), findsOneWidget);
  });

  testWidgets('displays profile information correctly when profile is found',
      (WidgetTester tester) async {
    const profile =
        Profile(username: 'testuser', interests: ['Reading', 'Traveling']);
    when(() => mockProfileBloc.state)
        .thenReturn(const ProfileFound(profile: profile));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text("@testuser"), findsOneWidget);
    expect(find.byType(ProfileWidget), findsOneWidget);
  });

  testWidgets('shows "Profile Not Found" message when profile is null',
      (WidgetTester tester) async {
    when(() => mockProfileBloc.state)
        .thenReturn(const ProfileError(exception: CustomException()));

    await tester.pumpWidget(createWidgetUnderTest());

    expect(find.text("Profil Tidak Ditemukan"), findsOneWidget);
  });

  testWidgets('handles logout action from PopupMenuButton',
      (WidgetTester tester) async {
    when(() => mockProfileBloc.state)
        .thenReturn(const ProfileFound(profile: Profile(username: 'testuser')));
    await tester.pumpWidget(createWidgetUnderTest());

    await tester.tap(find.byIcon(Icons.more_vert)); // Open the popup menu
    await tester.pump(); // Allow the popup to open

    await tester.tap(find.text("Logout")); // Tap the logout option
    await tester.pump(); // Allow the action to complete

    verify(() => mockLoginCubit.logout()).called(1);
  });
}
