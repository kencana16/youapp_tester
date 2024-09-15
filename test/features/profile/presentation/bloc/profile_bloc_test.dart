import 'dart:typed_data';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youapp_tester/base/error/custom_exception.dart';
import 'package:youapp_tester/features/profile/domain/entities/profile.dart';
import 'package:youapp_tester/features/profile/domain/usecases/get_profile.dart';
import 'package:youapp_tester/features/profile/domain/usecases/update_profile.dart';
import 'package:youapp_tester/features/profile/presentation/bloc/profile_bloc.dart';

class FakeUpdateProfileParam extends Fake implements UpdateProfileParam {}

class MockGetProfile extends Mock implements GetProfile {}

class MockUpdateProfile extends Mock implements UpdateProfile {}

void main() {
  String? _accessTokenState;
  Profile? _profileState;
  late ProfileBloc profileBloc;
  late MockGetProfile mockGetProfile;
  late MockUpdateProfile mockUpdateProfile;

  setUp(() {
    registerFallbackValue(FakeUpdateProfileParam());

    _accessTokenState = null;
    _profileState = null;

    mockGetProfile = MockGetProfile();
    mockUpdateProfile = MockUpdateProfile();

    when(() => mockUpdateProfile.call(any())).thenAnswer((invocation) async {
      var positionalArguments = invocation.positionalArguments;
      var param = positionalArguments[0] as UpdateProfileParam?;
      var accessTokenArgument = param?.accessToken;
      if (accessTokenArgument != _accessTokenState) {
        return false;
      }

      var profileArgument = param?.profile;
      _profileState = profileArgument;
      return true;
    });
    when(() => mockGetProfile.call(any())).thenAnswer((invocation) async {
      var positionalArguments = invocation.positionalArguments;
      var accessTokenArgument = positionalArguments[0] as String?;
      if (accessTokenArgument != _accessTokenState) {
        return null;
      }

      return _profileState;
    });

    profileBloc = ProfileBloc(
      getProfile: mockGetProfile,
      updateProfile: mockUpdateProfile,
    );
  });

  tearDown(() {
    verifyNoMoreInteractions(mockGetProfile);
    verifyNoMoreInteractions(mockUpdateProfile);
  });

  const String accessTokenDefault = 'mockAccessToken';
  final Profile profileDefault = Profile(
    email: 'test@example.com',
    username: 'testuser',
    imageBytes: Uint8List.fromList([1, 2, 3]),
    gender: Gender.male,
    name: 'Test User',
    birthday:
        DateTime.now().subtract(const Duration(days: 365 * 30)), // 30 years ago
    height: 180.0,
    weight: 75.0,
    interests: ['Reading', 'Coding'],
  );

  test('initial state should be ProfileInitial', () {
    expect(profileBloc.state, isA<ProfileInitial>());
  });

  blocTest<ProfileBloc, ProfileState>(
    'should emit [ProfileLoading, ProfileFound] when profile is fetched successfully',
    setUp: () {
      _accessTokenState = accessTokenDefault;
      _profileState = profileDefault;
    },
    build: () {
      return profileBloc;
    },
    act: (bloc) =>
        bloc.add(ProfileEventChangeToken(accessToken: accessTokenDefault)),
    expect: () => [
      isA<ProfileLoading>(),
      ProfileFound(profile: profileDefault),
    ],
    verify: (_) {
      verify(() => mockGetProfile.call(accessTokenDefault)).called(1);
    },
  );

  blocTest<ProfileBloc, ProfileState>(
    'should emit [ProfileLoading, ProfileError] when profile fetching fails',
    setUp: () {},
    build: () {
      return profileBloc;
    },
    act: (bloc) =>
        bloc.add(ProfileEventChangeToken(accessToken: accessTokenDefault)),
    expect: () => [
      isA<ProfileLoading>(),
      isA<ProfileError>(),
    ],
    verify: (_) {
      verify(() => mockGetProfile.call(accessTokenDefault)).called(1);
    },
  );

  blocTest<ProfileBloc, ProfileState>(
    'should emit [ProfileLoading, ProfileFound] when profile is updated successfully',
    setUp: () {
      _accessTokenState = accessTokenDefault;
      _profileState = profileDefault;
    },
    build: () {
      return profileBloc;
    },
    act: (bloc) => bloc.add(ProfileEventUpdateData(
        accessToken: accessTokenDefault, profile: profileDefault)),
    expect: () => [
      isA<ProfileLoading>(),
      ProfileFound(profile: profileDefault),
    ],
    verify: (_) {
      verify(() => mockUpdateProfile.call(any())).called(1);
      verify(() => mockGetProfile.call(any())).called(1);
    },
  );

  blocTest<ProfileBloc, ProfileState>(
    'should emit [ProfileError] when profile update fails',
    setUp: () {},
    build: () {
      return profileBloc;
    },
    act: (bloc) => bloc.add(ProfileEventUpdateData(
      accessToken: accessTokenDefault,
      profile: profileDefault,
    )),
    expect: () => [
      isA<ProfileLoading>(),
      isA<ProfileError>(),
    ],
    verify: (_) {
      verify(() => mockUpdateProfile.call(any())).called(1);
      verify(() => mockGetProfile.call(any())).called(1);
    },
  );

  blocTest<ProfileBloc, ProfileState>(
    'should emit [ProfileLoading, ProfileFound] when interests are updated successfully',
    setUp: () {
      _accessTokenState = accessTokenDefault;
      _profileState = profileDefault;
    },
    build: () {
      return profileBloc
        ..add(ProfileEventChangeToken(accessToken: accessTokenDefault));
    },
    act: (bloc) => bloc.add(ProfileEventUpdateInterests(
        accessToken: accessTokenDefault, interests: ['New Interest'])),
    expect: () => [
      isA<ProfileLoading>(),
      ProfileFound(profile: profileDefault),
      isA<ProfileLoading>(),
      ProfileFound(
          profile: profileDefault.copyWith(interests: ['New Interest'])),
    ],
    verify: (_) {
      verify(() => mockUpdateProfile.call(any())).called(1);
      verify(() => mockGetProfile.call(any())).called(2);
    },
  );

  blocTest<ProfileBloc, ProfileState>(
    'should emit [ProfileError] when interests update fails',
    setUp: () {
      _accessTokenState = "asdrasdfe";
      _profileState = profileDefault;
    },
    build: () {
      return profileBloc
        ..add(ProfileEventChangeToken(accessToken: accessTokenDefault));
    },
    act: (bloc) => bloc.add(ProfileEventUpdateInterests(
        accessToken: accessTokenDefault, interests: ['New Interest'])),
    expect: () => [
      isA<ProfileLoading>(),
      isA<ProfileError>(),
      ProfileError(exception: CustomException("User Belum Login")),
    ],
    verify: (_) {
      var a = verify(() => mockGetProfile.call(any())).called(1);
    },
  );
}
