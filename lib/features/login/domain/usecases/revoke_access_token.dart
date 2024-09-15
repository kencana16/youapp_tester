import 'package:youapp_tester/features/login/domain/repositories/login_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../../base/usecase.dart';

@injectable
class RevokeAccessToken extends UseCaseAsync<bool, NoParams> {
  final LoginRepository _loginRepository;

  RevokeAccessToken(this._loginRepository);

  @override
  Future<bool> call(NoParams params) => _loginRepository.revokeAccessToken();
}
