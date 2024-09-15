import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:youapp_tester/base/error/custom_exception.dart';
import 'package:youapp_tester/base/usecase.dart';
import 'package:youapp_tester/features/login/domain/entities/login_dto.dart';
import 'package:youapp_tester/features/login/domain/entities/register_dto.dart';
import 'package:youapp_tester/features/login/domain/usecases/get_access_token.dart';
import 'package:youapp_tester/features/login/domain/usecases/post_login.dart';
import 'package:youapp_tester/features/login/domain/usecases/post_register.dart';
import 'package:youapp_tester/features/login/domain/usecases/revoke_access_token.dart';
import 'package:youapp_tester/features/login/domain/usecases/save_access_token.dart';
import 'package:youapp_tester/features/login/presentation/cubit/login_cubit.dart';

class FakeLoginDto extends Fake implements LoginDto {}

class FakeRegisterDto extends Fake implements RegisterDto {}

class FakeNoParams extends Fake implements NoParams {}

class MockPostLogin extends Mock implements PostLogin {}

class MockPostRegister extends Mock implements PostRegister {}

class MockGetAccessToken extends Mock implements GetAccessToken {}

class MockSaveAccessToken extends Mock implements SaveAccessToken {}

class MockRevokeAccessToken extends Mock implements RevokeAccessToken {}

void main() {
  String? accessToken;
  late MockPostLogin mockPostLogin;
  late MockPostRegister mockPostRegister;
  late MockGetAccessToken mockGetAccessToken;
  late MockSaveAccessToken mockSaveAccessToken;
  late MockRevokeAccessToken mockRevokeAccessToken;

  setUp(() {
    registerFallbackValue(FakeLoginDto());
    registerFallbackValue(FakeRegisterDto());
    registerFallbackValue(FakeNoParams());

    accessToken = null;
    mockPostLogin = MockPostLogin();
    mockPostRegister = MockPostRegister();
    mockGetAccessToken = MockGetAccessToken();
    mockSaveAccessToken = MockSaveAccessToken();
    mockRevokeAccessToken = MockRevokeAccessToken();

    when(() => mockGetAccessToken.call(any())).thenAnswer(
      (invocation) async => accessToken,
    );
    when(() => mockSaveAccessToken.call(any())).thenAnswer((invocation) async {
      accessToken = invocation.positionalArguments[0];
      return true;
    });
    when(() => mockRevokeAccessToken.call(any()))
        .thenAnswer((invocation) async {
      accessToken = null;
      return true;
    });
  });

  tearDown(() {
    verifyNoMoreInteractions(mockPostLogin);
    verifyNoMoreInteractions(mockPostRegister);
    verifyNoMoreInteractions(mockGetAccessToken);
    verifyNoMoreInteractions(mockSaveAccessToken);
    verifyNoMoreInteractions(mockRevokeAccessToken);

    reset(mockPostLogin);
    reset(mockPostRegister);
    reset(mockGetAccessToken);
    reset(mockSaveAccessToken);
    reset(mockRevokeAccessToken);
  });

  test('initial state is LoginInitial', () {
    LoginCubit loginCubit = LoginCubit(
      postLogin: mockPostLogin,
      postRegister: mockPostRegister,
      getAccessToken: mockGetAccessToken,
      saveAccessToken: mockSaveAccessToken,
      revokeAccessToken: mockRevokeAccessToken,
    );

    expect(loginCubit.state, equals(LoginInitial()));

    verify(() => mockGetAccessToken.call(NoParams())).called(1);
  });

  blocTest<LoginCubit, LoginState>(
    'emits [LoginLoading, LoginSuccess] when login is successful',
    setUp: () {
      when(() => mockPostLogin.call(any()))
          .thenAnswer((_) async => 'dummyAccessToken');
    },
    build: () {
      return LoginCubit(
        postLogin: mockPostLogin,
        postRegister: mockPostRegister,
        getAccessToken: mockGetAccessToken,
        saveAccessToken: mockSaveAccessToken,
        revokeAccessToken: mockRevokeAccessToken,
      );
    },
    act: (cubit) => cubit.login(
      email: 'test@example.com',
      username: 'testuser',
      password: 'password',
    ),
    expect: () => [
      LoginLoading(),
      const LoginSuccess(accessToken: 'dummyAccessToken'),
    ],
    verify: (_) {
      verify(() => mockGetAccessToken.call(NoParams())).called(2);
      verify(() => mockPostLogin.call(any())).called(1);
      verify(() => mockSaveAccessToken.call('dummyAccessToken')).called(1);
    },
  );

  blocTest<LoginCubit, LoginState>(
    'emits [LoginLoading, LoginFailed] when login fails',
    setUp: () {
      when(() => mockPostLogin.call(any()))
          .thenThrow(const CustomException('Login failed'));
    },
    build: () {
      return LoginCubit(
        postLogin: mockPostLogin,
        postRegister: mockPostRegister,
        getAccessToken: mockGetAccessToken,
        saveAccessToken: mockSaveAccessToken,
        revokeAccessToken: mockRevokeAccessToken,
      );
    },
    act: (cubit) => cubit.login(
      email: 'test@example.com',
      username: 'testuser',
      password: 'password',
    ),
    expect: () => [
      LoginLoading(),
      const LoginFailed(e: CustomException('Login failed')),
    ],
    verify: (_) {
      verify(() => mockGetAccessToken.call(NoParams())).called(1);
      verify(() => mockPostLogin.call(any())).called(1);
    },
  );

  blocTest<LoginCubit, LoginState>(
    'emits [LoginLoading, LoginSuccess] when registration is successful and then logs in',
    setUp: () {
      when(() => mockPostRegister.call(any())).thenAnswer((_) async => true);
      when(() => mockPostLogin.call(any()))
          .thenAnswer((_) async => 'dummyAccessToken');
    },
    build: () {
      return LoginCubit(
        postLogin: mockPostLogin,
        postRegister: mockPostRegister,
        getAccessToken: mockGetAccessToken,
        saveAccessToken: mockSaveAccessToken,
        revokeAccessToken: mockRevokeAccessToken,
      );
    },
    act: (cubit) => cubit.register(
      email: 'test@example.com',
      username: 'testuser',
      password: 'password',
    ),
    expect: () => [
      LoginLoading(),
      const LoginSuccess(accessToken: 'dummyAccessToken'),
    ],
    verify: (_) {
      verify(() => mockGetAccessToken.call(any())).called(2);
      verify(() => mockPostRegister.call(any())).called(1);
      verify(() => mockPostLogin.call(any())).called(1);
      verify(() => mockSaveAccessToken.call('dummyAccessToken')).called(1);
    },
  );

  blocTest<LoginCubit, LoginState>(
    'emits [LoginLoading, LoginFailed] when registration fails',
    build: () {
      when(() => mockPostRegister.call(any()))
          .thenThrow(const CustomException('Registration failed'));
      return LoginCubit(
        postLogin: mockPostLogin,
        postRegister: mockPostRegister,
        getAccessToken: mockGetAccessToken,
        saveAccessToken: mockSaveAccessToken,
        revokeAccessToken: mockRevokeAccessToken,
      );
    },
    act: (cubit) => cubit.register(
      email: 'test@example.com',
      username: 'testuser',
      password: 'password',
    ),
    expect: () => [
      LoginLoading(),
      const LoginFailed(e: CustomException('Registration failed')),
    ],
    verify: (_) {
      verify(() => mockGetAccessToken.call(any())).called(1);
      verify(() => mockPostRegister.call(any())).called(1);
    },
  );

  blocTest<LoginCubit, LoginState>(
    'emits [LoginSuccess] when getAccessToken is successful',
    setUp: () {
      accessToken = 'dummyAccessToken';
    },
    build: () {
      return LoginCubit(
        postLogin: mockPostLogin,
        postRegister: mockPostRegister,
        getAccessToken: mockGetAccessToken,
        saveAccessToken: mockSaveAccessToken,
        revokeAccessToken: mockRevokeAccessToken,
      );
    },
    // act: (cubit) => cubit.getAccessToken(),
    expect: () => [
      const LoginSuccess(accessToken: 'dummyAccessToken'),
    ],
    verify: (_) {
      verify(() => mockGetAccessToken.call(any())).called(1);
    },
  );

  blocTest<LoginCubit, LoginState>(
    'emits [LoginFailed] when getAccessToken returns null',
    build: () {
      return LoginCubit(
        postLogin: mockPostLogin,
        postRegister: mockPostRegister,
        getAccessToken: mockGetAccessToken,
        saveAccessToken: mockSaveAccessToken,
        revokeAccessToken: mockRevokeAccessToken,
      );
    },
    act: (cubit) => cubit.getAccessToken(),
    expect: () => [
      const LoginFailed(e: CustomException("Access Token not saved")),
    ],
    verify: (_) {
      verify(() => mockGetAccessToken.call(any())).called(2);
    },
  );

  blocTest<LoginCubit, LoginState>(
    'emits [LoginInitial] after successful logout',
    build: () {
      return LoginCubit(
        postLogin: mockPostLogin,
        postRegister: mockPostRegister,
        getAccessToken: mockGetAccessToken,
        saveAccessToken: mockSaveAccessToken,
        revokeAccessToken: mockRevokeAccessToken,
      );
    },
    act: (cubit) => cubit.logout(),
    expect: () => [LoginInitial()],
    verify: (_) {
      verify(() => mockGetAccessToken.call(any())).called(1);
      verify(() => mockRevokeAccessToken.call(any())).called(1);
    },
  );

  blocTest<LoginCubit, LoginState>(
    'emits [LoginFailed] when logout fails',
    setUp: () {
      accessToken = "accessToken";
      when(() => mockRevokeAccessToken.call(any()))
          .thenAnswer((invocation) async => false);
    },
    build: () {
      return LoginCubit(
        postLogin: mockPostLogin,
        postRegister: mockPostRegister,
        getAccessToken: mockGetAccessToken,
        saveAccessToken: mockSaveAccessToken,
        revokeAccessToken: mockRevokeAccessToken,
      );
    },
    act: (cubit) => cubit.logout(),
    expect: () => [
      const LoginSuccess(accessToken: "accessToken"),
    ],
    verify: (_) {
      verify(() => mockGetAccessToken.call(any())).called(1);
      verify(() => mockRevokeAccessToken.call(any())).called(1);
    },
  );

  blocTest<LoginCubit, LoginState>(
    'emits [LoginFailed] when revokeAccessToken fails',
    setUp: () {
      accessToken = "accessToken";
      when(() => mockRevokeAccessToken.call(any()))
          .thenAnswer((invocation) async => false);
    },
    build: () {
      return LoginCubit(
        postLogin: mockPostLogin,
        postRegister: mockPostRegister,
        getAccessToken: mockGetAccessToken,
        saveAccessToken: mockSaveAccessToken,
        revokeAccessToken: mockRevokeAccessToken,
      );
    },
    act: (cubit) => cubit.revokeAccessToken(),
    expect: () => [
      const LoginSuccess(accessToken: "accessToken"),
    ],
    verify: (_) {
      verify(() => mockGetAccessToken.call(any())).called(1);
    },
  );
}
