import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youapp_tester/features/login/presentation/cubit/login_cubit.dart';
import 'package:youapp_tester/features/profile/domain/entities/profile.dart';
import 'package:youapp_tester/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:youapp_tester/features/profile/presentation/widgets/about_card.dart';

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

  Widget createWidgetUnderTest(Profile? profile, {bool editMode = false}) {
    return MaterialApp(
      home: BlocProvider<ProfileBloc>.value(
        value: mockProfileBloc,
        child: BlocProvider<LoginCubit>.value(
          value: mockLoginCubit,
          child: Scaffold(
            body: AboutCard(profile: profile),
          ),
        ),
      ),
    );
  }

  testWidgets('displays profile data correctly', (WidgetTester tester) async {
    final profile = Profile(
      name: 'John Doe',
      gender: Gender.male,
      birthday: DateTime(1990, 1, 1),
      height: 180.0,
      weight: 75.0,
    );

    await tester.pumpWidget(createWidgetUnderTest(profile));

    expect(find.text("Birthday : 01/01/1990 (Age 34)"), findsOneWidget);
    expect(find.text("Horoscope : Aries"), findsOneWidget);
    expect(find.text("Zodiac : Aries"), findsOneWidget);
    expect(find.text("Height : 180.0 cm"), findsOneWidget);
    expect(find.text("Weight : 75.0 Kg"), findsOneWidget);
  });

  testWidgets('shows edit mode form fields', (WidgetTester tester) async {
    final profile = Profile(
      name: 'John Doe',
      gender: Gender.male,
      birthday: DateTime(1990, 1, 1),
      height: 180.0,
      weight: 75.0,
    );

    await tester.pumpWidget(createWidgetUnderTest(profile, editMode: true));

    expect(find.byType(FormBuilder), findsOneWidget);
    expect(
        find.byType(FormBuilderTextField), findsNWidgets(6)); // 6 text fields
    expect(find.byType(FormBuilderDropdown),
        findsNWidgets(2)); // 2 dropdown fields
    expect(find.byType(FormBuilderDateTimePicker),
        findsOneWidget); // 1 date picker
  });

  testWidgets('submits form and calls ProfileBloc',
      (WidgetTester tester) async {
    const profile = Profile();

    await tester.pumpWidget(createWidgetUnderTest(profile, editMode: true));

    // Fill in form fields
    await tester.enterText(find.byType(FormBuilderTextField).at(0), 'Jane Doe');
    await tester.enterText(find.byType(FormBuilderTextField).at(1), '180');
    await tester.enterText(find.byType(FormBuilderTextField).at(2), '70');
    await tester.tap(find.byType(ElevatedButton)); // Trigger save

    verify(() => mockProfileBloc.add(any())).called(1);
  });

  testWidgets('handles missing profile data gracefully',
      (WidgetTester tester) async {
    await tester.pumpWidget(createWidgetUnderTest(null));

    expect(find.text("Add in your your to help others know you better"),
        findsOneWidget);
  });

  testWidgets('form validation shows errors for invalid data',
      (WidgetTester tester) async {
    const profile = Profile();
    await tester.pumpWidget(createWidgetUnderTest(profile, editMode: true));

    await tester.enterText(
        find.byType(FormBuilderTextField).at(0), ''); // Leave name empty
    await tester.tap(find.byType(ElevatedButton)); // Trigger save

    expect(find.text('This field cannot be empty'), findsOneWidget);
  });
}
